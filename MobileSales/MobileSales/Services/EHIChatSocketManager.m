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
#import <AudioToolbox/AudioToolbox.h>
#import <AFNetworkReachabilityManager.h>

static const int ERROR_CODE = 0;
static const int HEAD = sizeof(int);
static const int TIMEOUT = -1;

@interface EHIChatSocketManager()

@property (nonatomic , assign) int headLenth;
@property (nonatomic , assign) int bodyLenth;

@property (nonatomic , strong) NSData *headData;
@property (nonatomic , strong) NSData *bodyData;

@property (nonatomic , strong) EHIMessage *getMessage;

@end

@implementation EHIChatSocketManager
{
    int firstSend ;
    int auto_connect_time;
}
+ (EHIChatSocketManager *)shareInstance
{
    static EHIChatSocketManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            [self autoConnect];
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autoConnect) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    self.socket = nil;
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
        int headLenth = (int)headData.length;
        headLenthData = [NSData dataWithBytes:&headLenth length:sizeof(headLenth)];
        
        //包体
        bodyData  = [textMessage.text dataUsingEncoding:NSUTF8StringEncoding];
        //获取包体长度 转成data
        int boayLenth = (int)bodyData.length;
        bodyLenthData = [NSData dataWithBytes:&boayLenth length:sizeof(boayLenth)];
    }
    
    //拼接包发送
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    [data appendData:headLenthData];
    [data appendData:bodyLenthData];
    [data appendData:headData];
    [data appendData:bodyData];
    
    [self.socket writeData:data withTimeout:-1 tag:EHISocketTagDetault];
}

//发送初始化包
- (void)sendINITSocket
{
    NSLog(@"发送初始化包");
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
    int headLenth = (int)headData.length;
    headLenthData = [NSData dataWithBytes:&headLenth length:sizeof(headLenth)];
    
    //获取包体长度 转成data
    int boayLenth = 0;
    bodyLenthData = [NSData dataWithBytes:&boayLenth length:sizeof(boayLenth)];
    //拼接包发送
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    [data appendData:headLenthData];
    [data appendData:bodyLenthData];
    [data appendData:headData];
    
    [self.socket writeData:data withTimeout:TIMEOUT tag:EHISocketTagDetault];
}

//发送确认包
- (void)sendACKSocketWithMessageId:(NSString *)messageId
{
    NSData *headData = nil;
    NSData *headLenthData = nil;
    
    NSData *bodyLenthData = nil;
    
    NSMutableDictionary *headDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [headDic saveString:@"ACK" forKey:@"type"];
    [headDic saveString:messageId forKey:@"id"];
    
    headData = [headDic mj_JSONData] ;
    //获取包头长度 转成data
    int headLenth = (int)headData.length;
    headLenthData = [NSData dataWithBytes:&headLenth length:sizeof(headLenth)];
    
    //获取包体长度 转成data
    int boayLenth = 0;
    bodyLenthData = [NSData dataWithBytes:&boayLenth length:sizeof(boayLenth)];
    //拼接包发送
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:0];
    [data appendData:headLenthData];
    [data appendData:bodyLenthData];
    [data appendData:headData];
    
    [self.socket writeData:data withTimeout:-1 tag:EHISocketTagDetault];
}

#pragma mark GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接服务器成功");
    firstSend = 0;
    auto_connect_time = 0;
    [self sendINITSocket];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    if (err) {
        [self performSelector:@selector(autoConnect) withObject:self afterDelay:pow(2, auto_connect_time)];
        auto_connect_time ++ ;
        if (auto_connect_time >= 5) {
            auto_connect_time = 5;
        }
    }
}

//自动重连
- (void)autoConnect
{
    if (![self.socket isConnected]) {
        [self.socket connectToHost:SHARE_USER_CONTEXT.urlList.SOCKET_HOST onPort:SHARE_USER_CONTEXT.urlList.SOCKET_PORT error:nil];
    }
}

//收到信息
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSLog(@"收到消息");
    //如果没有包头长度 取包头长度
    if (_headLenth == ERROR_CODE) {
        [data getBytes:&_headLenth length:sizeof(_headLenth)];
        
        //如果取不出包头长度 则出错了
        if (_headLenth <= 0) {
            
            return;
        }
        [sock readDataToLength:HEAD withTimeout:TIMEOUT tag:EHISocketTagDetault];
        return;
    }
    
    //如果没有包体长度 取包体长度
    if (_bodyLenth == ERROR_CODE) {
        [data getBytes:&_bodyLenth length:sizeof(_bodyLenth)];
        
        //如果为0 可能是没有数据或者失败 都返回错误
        if (_bodyLenth == ERROR_CODE){
            _bodyLenth = -1;
             [sock readDataToLength:_headLenth withTimeout:TIMEOUT tag:EHISocketTagDetault];
             return;
        }
        [sock readDataToLength:_headLenth withTimeout:TIMEOUT tag:EHISocketTagDetault];
        return;
    }
    
    //如果没有包头数据 读取包头内容
    if (!_headData) {
        _headData = data;
        
        if (!_headData) {
            NSLog(@"包头为空,接受消息失败");
            return;
        }
        
        NSDictionary *headDic = [_headData mj_JSONObject];
        //收到的消息类型
        NSString *type = headDic[@"type"];
        
        //收到的是普通消息
        if ([type isEqualToString:@"MESSAGE"]) {
            [self handleMESSAGEDataWithSocket:sock
                     withHeaderDictionary:headDic];
            return;
        }
        
        //收到的是确认消息
        if ([type isEqualToString:@"ACK"]) {
            [self handleACKDataWithSocket:sock
                     withHeaderDictionary:headDic];
            return;
        }
        
        //收到的是初始化消息
        if ([type isEqualToString:@"INIT"]) {
             [self handleINITDataWithSocket:sock
                       withHeaderDictionary:headDic];
            return;
        }
        
        return;
    }
    
    //处理包体
    [self finalyHandleMessageWithSocket:sock withData:data];
    
}

//处理收到的确认消息
- (void)handleACKDataWithSocket:(GCDAsyncSocket *)socket
           withHeaderDictionary:(NSDictionary *)dic
{
    if ([dic[@"id"] length]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(receivedACKWithMessageId:toSenderStatus:)]) {
            [self.delegate receivedACKWithMessageId:dic[@"id"]
                                     toSenderStatus:EHIMessageSendSuccess];
        }else
        {
            [[EHIChatManager sharedInstance] updateMessageSendStatusTo:EHIMessageSendSuccess
                                                         WithMessageID:dic[@"id"]];
        }
    }
    [self resetToReadNextSocketWithSocket:socket];
}

//处理收到的初始化消息
- (void)handleINITDataWithSocket:(GCDAsyncSocket *)socket
            withHeaderDictionary:(NSDictionary *)dic
{
    [self resetToReadNextSocketWithSocket:socket];
}

//处理收到的普通消息 进行下一步处理
- (void)handleMESSAGEDataWithSocket:(GCDAsyncSocket *)socket
               withHeaderDictionary:(NSDictionary *)dic
{
    if ([dic[@"messageType"] isEqualToString:@"TEXT"]){
        
        EHITextMessage *textMessage = [[EHITextMessage alloc] init];
        textMessage.nodeID = [NSString stringWithFormat:@"%@",dic[@"nodeId"]];
        textMessage.messageID = dic[@"id"];
        textMessage.sendID = [NSString stringWithFormat:@"%@",dic[@"senderId"]];
        textMessage.sendName = dic[@"senderName"];
        textMessage.date = [NSString getDateWithString:dic[@"time"]];
        textMessage.messageType = EHIMessageTypeText;
        textMessage.receivedID = SHARE_USER_CONTEXT.user.user_id;
        textMessage.receivedName = SHARE_USER_CONTEXT.user.user_name;
        textMessage.ownerTyper = EHIMessageOwnerTypeFriend;
        
        self.getMessage = textMessage;
    }
    
    [socket readDataToLength:_bodyLenth
                 withTimeout:TIMEOUT
                         tag:EHISocketTagDetault];
}

//最终消息的处理
- (void)finalyHandleMessageWithSocket:(GCDAsyncSocket *)socket
                                 withData:(NSData *)data
{
    //发送确认收到消息
    [self sendACKSocketWithMessageId:self.getMessage.messageID];
    
    if (self.getMessage.messageType == EHIMessageTypeText) {
        
        NSString *bodyString = [[NSString  alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        EHITextMessage *textMessage = (EHITextMessage *)self.getMessage;
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
            [[EHIChatManager sharedInstance] addMessage:textMessage
                                       toChatListNodeId:textMessage.nodeID
                                                 isRead:NO];
            //不是在详情页 存到数据库
            [[EHIChatManager sharedInstance] sendMessage:textMessage
                                                progress:^(EHIMessage * message, CGFloat pregress) {
                                                    
                                                } success:^(EHIMessage * message) {
                                                    NSLog(@"send success");
                                                } failure:^(EHIMessage * message) {
                                                    NSLog(@"send failure");
                                                }];
            
            AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);//震动
            
            [[NSNotificationCenter defaultCenter] postNotificationName:HAVE_NEW_MESSAGE_NOTIFATION object:nil];
        }

    }
    [self resetToReadNextSocketWithSocket:socket];
}

//重置所有状态 接受下一条内容
- (void)resetToReadNextSocketWithSocket:(GCDAsyncSocket *)socket
{
    _headLenth = ERROR_CODE;
    _bodyLenth = ERROR_CODE;
    
    _headData = nil;
    _bodyData = nil;
    [socket readDataToLength:HEAD withTimeout:TIMEOUT tag:EHISocketTagDetault];
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"消息发送成功");
    if (firstSend == 0) {
         [sock readDataToLength:HEAD withTimeout:TIMEOUT tag:EHISocketTagDetault];
    }
    firstSend ++;
}

- (EHIMessage *)getMessage
{
    if (!_getMessage) {
        _getMessage = [[EHIMessage alloc] init];
    }
    return _getMessage;
}

- (GCDAsyncSocket *)socket
{
    if (!_socket) {
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(0, 0)];//这种是在主线程中运行
    }
    return _socket;
}

@end
