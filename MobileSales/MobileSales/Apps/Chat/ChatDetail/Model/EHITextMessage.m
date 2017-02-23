//
//  EHITextMessage.m
//  MobileSales
//
//  Created by dengwx on 17/2/19.
//  Copyright © 2017年 wxdeng. All rights reserved.
//

#import "EHITextMessage.h"

static UILabel *textLabel = nil;

@implementation EHITextMessage
@synthesize text = _text;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:EHIMessageTypeText];
        if (textLabel == nil) {
            textLabel = [[UILabel alloc] init];
            [textLabel setFont:[UIFont systemFontOfSize:14]];
            [textLabel setNumberOfLines:0];
        }
    }
    return self;
}

- (NSString *)text
{
    if (_text == nil) {
        _text = [self.content objectForKey:@"text"];
    }
    return _text;
}
- (void)setText:(NSString *)text
{
    _text = text;
    [self.content setObject:text forKey:@"text"];
}

- (EHIMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[EHIMessageFrame alloc] init];
        kMessageFrame.height = 23 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0) + 23;
        textLabel.text = self.text;
        kMessageFrame.contentSize = [textLabel sizeThatFits:CGSizeMake(MAX_MESSAGE_WIDTH, MAXFLOAT)];
        kMessageFrame.height += kMessageFrame.contentSize.height;
    }
    return kMessageFrame;
}
@end
