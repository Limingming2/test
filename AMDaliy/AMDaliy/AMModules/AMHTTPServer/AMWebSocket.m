//
//  AMWebSocket.m
//  AMDaliy
//
//  Created by limingming on 2018/11/22.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMWebSocket.h"
#import "HTTPLogging.h"

static const int httpLogLevel = HTTP_LOG_LEVEL_WARN | HTTP_LOG_FLAG_TRACE;

@implementation AMWebSocket

- (void)didOpen
{
    HTTPLogTrace();
    [super didOpen];
}

- (void)didClose
{
    HTTPLogTrace();
    [super didClose];
}

- (void)didReceiveMessage:(NSString *)msg
{
    HTTPLogTrace2(@"didReceiveMessage: %@", msg);
    NSLog(@"subclass msg:%@", msg);
    [self sendMessage:[NSString stringWithFormat:@"%@", [NSDate date]]];
    [super didReceiveMessage:msg];
}


@end
