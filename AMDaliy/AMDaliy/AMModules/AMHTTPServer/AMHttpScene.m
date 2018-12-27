//
//  AMHttpScene.m
//  AMDaliy
//
//  Created by limingming on 2018/11/22.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMHttpScene.h"
#import "AMWebSocket.h"
#import "HTTPMessage.h"
#import "GCDAsyncSocket.h"
#import "HTTPServer.h"
#import "AMHTTPConnection.h"
#import "DDLog.h"
#import "DDTTYLogger.h"

@interface AMHttpScene () <WebSocketDelegate>
@property (nonatomic, strong) HTTPServer *httpServer;
@end

@implementation AMHttpScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.httpServer stop];
}

- (IBAction)sendAction:(id)sender
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
//    data = [data base64EncodedDataWithOptions:0];
//    NSString *str = [NSString stringWithFormat:@"%.3f", [NSDate date].timeIntervalSince1970];
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
//    for (int i = 0; i < 1300; i++) {
//        NSString *str = [NSString stringWithFormat:@"Web/video_720/%d", i];
//        path = [path stringByAppendingPathComponent:str];
//        NSData *data = [NSData dataWithContentsOfFile:path];
//
//        [self.httpServer sendData:data];
//    }
    static int count = 0;
    count++;
    NSString *str = [NSString stringWithFormat:@"'%d'", count];
    
    [self.httpServer sendData:str];
    
    
}

- (IBAction)startAction:(id)sender
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    self.httpServer = [[HTTPServer alloc] init];
    [self.httpServer setPort:1111];
    [self.httpServer setConnectionClass:[AMHTTPConnection class]];
    [self.httpServer setType:@"_http._tcp."];
    
    NSString *webPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Web"];

    [self.httpServer setDocumentRoot:webPath];
    NSError *error;
    if(![self.httpServer start:&error])
    {
        NSLog(@"start:%@", error);
//        DDLogError(@"Error starting HTTP Server: %@", error);
    }
}

- (void)webSocketDidOpen:(WebSocket *)ws
{
    NSLog(@"start");
    
}

- (void)webSocketDidClose:(WebSocket *)ws
{
    NSLog(@"close");
}

- (void)webSocket:(WebSocket *)ws didReceiveMessage:(NSString *)msg
{
    NSLog(@"msg:%@", msg);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
