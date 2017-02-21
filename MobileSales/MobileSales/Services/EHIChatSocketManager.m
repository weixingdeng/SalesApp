//
//  EHIChatSocketManager.m
//  MobileSales
//
//  Created by dengwx on 17/2/20.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHIChatSocketManager.h"
#import "NSMutableDictionary+EHIDicSaveString.h"
#import "NSDate+Extension.h"
#import "NSString+EHIDateFormat.h"
#import "EHIChatDetailViewController.h"
#import "EHIChatManager.h"

static const int ERROR_CODE = 0;

@interface EHIChatSocketManager()

@property (nonatomic , assign) int headLenth;
@property (nonatomic , assign) int bodyLenth;

@property (nonatomic , strong) NSData *headData;
@property (nonatomic , strong) NSData *bodyData;

@end

@implementation EHIChatSocketManager

+ (EHIChatSocketManager *)shareInstance
{
    static EHIChatSocketManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
//        sharedInstance.headLenth = ERROR_CODE;
//        sharedInstance.bodyLenth = ERROR_CODE;
    });
    
    return sharedInstance;
}

//连接到服务器
-(void)connectToHostWithHost:(NSString *)socketHost
                    withPort:(NSInteger)socketPort
{
    NSError *error = nil;
    if (self.socket.isConnected) {
        [self.socket disconnect];
    }
    [self.socket connectToHost:socketHost onPort:socketPort error:&error];
    if(error) {
        NSLog(@"error:%@", error);
    }
}

//断开连接
- (void)disconnectSocket
{
    if ([self.socket isConnected]) {
        [self.socket disconnect];
    }
}

//发送消息
- (void)sendMessageWithMessage:(EHIMessage *)message
{
    NSData *headData = nil;
    NSData *headLenthData = nil;
    
    NSData *bodyData = nil;
    NSData *bodyLenthData = nil;
    
    if (message.messageType == EHIMessageTypeText) {
        EHITextMessage *textMessage = (EHITextMessage *)message;
        
        NSMutableDictionary *headDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        NSInteger nodeID = [message.nodeID integerValue];
        NSInteger sendID = [message.sendID integerValue];
        [headDic saveString:@"MESSAGE" forKey:@"type"];
        [headDic saveString:message.messageID forKey:@"id"];
        [headDic setObject :@(sendID) forKey:@"senderId"];
        [headDic saveString:message.sendName forKey:@"senderName"];
        [headDic setObject :@(nodeID) forKey:@"nodeId"];
        [headDic saveString:[message.date formatYMDHMS] forKey:@"time"];
        [headDic saveString:@"TEXT" forKey:@"messageType"];
        
        headData = [headDic mj_JSONData] ;
        //获取包头长度 转成data
        int headLenth = headData.length;
        headLenthData = [NSData dataWithBytes:&headLenth length:sizeof(headLenth)];
        
        //包体
        bodyData  = [textMessage.text dataUsingEncoding:NSUTF8StringEncoding];
        //获取包体长度 转成data
        int boayLenth = bodyData.length;
        bodyLenthData = [NSData dataWithBytes:&boayLenth length:sizeof(boayLenth)];
    }
    
    //拼接包发送
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    [data appendData:headLenthData];
    [data appendData:bodyLenthData];
    [data appendData:headData];
    [data appendData:bodyData];
    
    [self.socket writeData:data withTimeout:-1 tag:EHISocketTagMESSAGE];
    
    //加入到聊天列表
    
    
}

//发送初始化
- (void)sendINITSocket
{
    NSData *headData = nil;
    NSData *headLenthData = nil;

    NSData *bodyLenthData = nil;
    
    NSMutableDictionary *headDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSInteger userID = [SHARE_USER_CONTEXT.user.user_id integerValue];
    [headDic saveString:@"INIT" forKey:@"type"];
    [headDic setObject:@(userID) forKey:@"userId"];
    [headDic saveString:SHARE_USER_CONTEXT.user.user_name forKey:@"userName"];
    [headDic saveString:@"session" forKey:@"session"];

    headData = [headDic mj_JSONData] ;
    //获取包头长度 转成data
    int headLenth = headData.length;
    headLenthData = [NSData dataWithBytes:&headLenth length:sizeof(headLenth)];
    
    //获取包体长度 转成data
    int boayLenth = 0;
    bodyLenthData = [NSData dataWithBytes:&boayLenth length:sizeof(boayLenth)];
    //拼接包发送
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    [data appendData:headLenthData];
    [data appendData:bodyLenthData];
    [data appendData:headData];
    
    [self.socket writeData:data withTimeout:-1 tag:EHISocketTagINIT];
}

//发送确认包
- (void)sendACKSocket
{
    
}

#pragma mark GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接服务器成功");
    [self sendINITSocket];
//    [sock readDataWithTimeout:-1 tag:EHISocketTagINIT];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"断开连接");
    NSLog(@"error : %@",err);
}

//收到信息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"收到消息 %@:",[data mj_JSONString]);
    if (tag == EHISocketTagINIT) {
        NSLog(@"init");
        [sock readDataToLength:4 withTimeout:-1 tag:EHISocketTagMESSAGE];
    }else if (tag == EHISocketTagACK){
        NSLog(@"ack");
    }else if (tag == EHISocketTagMESSAGE){
        NSLog(@"message");
        [self ehi_socket:sock didReadMessageData:data];
    }
}

//处理收到的消息
- (void)ehi_socket:(GCDAsyncSocket *)sock didReadMessageData:(NSData *)data
{
    static EHIMessage *message = nil;
    //如果没有包头长度 取包头长度
    if (_headLenth == ERROR_CODE) {
        [data getBytes:&_headLenth length:sizeof(_headLenth)];
//        _headLenth   = -((const char *)[data bytes])[0];
        //如果取不出包头长度 则出错了
        if (_headLenth <= 0) {
            NSLog(@"接受消息失败");
            return;
        }
        [sock readDataToLength:4 withTimeout:-1 tag:EHISocketTagMESSAGE];
        return;
    }
    
    //如果没有包体长度 取包体长度
    if (_bodyLenth == ERROR_CODE) {
        [data getBytes:&_bodyLenth length:sizeof(_bodyLenth)];
//        _bodyLenth = -((const char *)[data bytes])[0];;
        
        //如果还没有
        if (_bodyLenth == ERROR_CODE) {
            NSLog(@"接受消息失败");
            return;
        }
        [sock readDataToLength:_headLenth withTimeout:-1 tag:EHISocketTagMESSAGE];
        return;
    }
    
    //如果没有包头数据 读取
    if (!_headData) {
        _headData = data;

        if (!_headData) {
            NSLog(@"包头为空,接受消息失败");
            return;
        }
        
        NSDictionary *headDic = [_headData mj_JSONObject];
        if ([headDic[@"messageType"] isEqualToString:@"TEXT"]) {
            EHITextMessage *textMessage = [[EHITextMessage alloc] init];
            textMessage.nodeID = [NSString stringWithFormat:@"%@",headDic[@"nodeId"]];
            textMessage.messageID = headDic[@"id"];
            textMessage.sendID = headDic[@"senderId"];
            textMessage.sendName = headDic[@"senderName"];
            textMessage.date = [NSString getDateWithString:headDic[@"time"]];
            textMessage.messageType = EHIMessageTypeText;
            textMessage.receivedID = SHARE_USER_CONTEXT.user.user_id;
            textMessage.receivedName = SHARE_USER_CONTEXT.user.user_name;
            textMessage.ownerTyper = EHIMessageOwnerTypeFriend;
            textMessage.showName = YES;
            
            message = textMessage;
        }
        
        //如果包体有长度 读取包体长度数据
        if (_bodyLenth) {
            [sock readDataToLength:_bodyLenth withTimeout:-1 tag:EHISocketTagMESSAGE];
            return;
        }else
        {
            message = nil;
            
            _headLenth = ERROR_CODE;
            _bodyLenth = ERROR_CODE;
            
            _headData = nil;
            _bodyData = nil;
            
            [sock readDataToLength:4 withTimeout:-1 tag:EHISocketTagMESSAGE];
            return;
            
        }
    }

    //取包体内容
    _bodyData = data;
    if (message.messageType == EHIMessageTypeText) {
        
        NSString *bodyString = [[NSString  alloc] initWithData:_bodyData encoding:NSUTF8StringEncoding];
        
        EHITextMessage *textMessage = (EHITextMessage *)message;
        if (bodyString.length) {
            textMessage.text = bodyString;
        }
#warning 如果聊天详情页代理不释放 会崩在这儿 原因待查
        //如果是在聊天详情页
        if (self.delegate && [self.delegate respondsToSelector:@selector(receivedMessage:)]) {
            [self.delegate receivedMessage:textMessage];
        }else
        {
            //r如果不在聊天详情页 isRead  传NO
            [[EHIChatManager sharedInstance] addMessage:message
                                       toChatListNodeId:message.nodeID
                                                 isRead:NO];
            //不是在详情页 存到数据库
            [[EHIChatManager sharedInstance] sendMessage:message
                                                progress:^(EHIMessage * message, CGFloat pregress) {
                
            } success:^(EHIMessage * message) {
                NSLog(@"send success");
            } failure:^(EHIMessage * message) {
                NSLog(@"send failure");
            }];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HAVE_NEW_MESSAGE_NOTIFATION object:nil];
        }
      
      
    }
    
     message = nil;
    
    _headLenth = ERROR_CODE;
    _bodyLenth = ERROR_CODE;
    
    _headData = nil;
    _bodyData = nil;
    [sock readDataToLength:4 withTimeout:-1 tag:EHISocketTagMESSAGE];
    return; 
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"消息发送成功");
    if (tag == EHISocketTagINIT) {
        [self.socket readDataWithTimeout:-1 tag:EHISocketTagINIT ];
    }
    
}

- (GCDAsyncSocket *)socket
{
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];//这种是在主线程中运行
    }
    return _socket;
}

@end
