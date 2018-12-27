//
//  AMHTTPConnection.m
//  AMDaliy
//
//  Created by limingming on 2018/11/22.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMHTTPConnection.h"
#import "HTTPMessage.h"
#import "HTTPResponse.h"
#import "HTTPDynamicFileResponse.h"
#import "GCDAsyncSocket.h"
#import "WebSocket.h"
#import "HTTPLogging.h"

@interface AMHTTPConnection () <WebSocketDelegate>

@end

@implementation AMHTTPConnection

- (BOOL)isSecureServer
{
    return YES;
}

- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    if ([path isEqualToString:@"/websocketTest2.js"]) {
        
    
        NSString *wsLocation;
        
        NSString *wsHost = [request headerField:@"Host"];
        if (wsHost == nil)
        {
            NSString *port = [NSString stringWithFormat:@"%hu", [asyncSocket localPort]];
            wsLocation = [NSString stringWithFormat:@"ws://localhost:%@/service", port];
        }
        else
        {
            wsLocation = [NSString stringWithFormat:@"ws://%@/service", wsHost];
        }
        
        NSDictionary *replacementDict = [NSDictionary dictionaryWithObject:wsLocation forKey:@"WEBSOCKET_URL"];
        
        return [[HTTPDynamicFileResponse alloc] initWithFilePath:[self filePathForURI:path]
                                                   forConnection:self
                                                       separator:@"%%"
                                           replacementDictionary:replacementDict];
    }
    
    return [super httpResponseForMethod:method URI:path];
}

- (WebSocket *)webSocketForURI:(NSString *)path
{
    
    if([path isEqualToString:@"/service"])
    {
        self.ws = [[WebSocket alloc] initWithRequest:request socket:asyncSocket];
        
        return self.ws;
    }
    
    return [super webSocketForURI:path];
}




@end
