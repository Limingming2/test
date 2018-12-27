//
//  AMHTTPConnection.h
//  AMDaliy
//
//  Created by limingming on 2018/11/22.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "HTTPConnection.h"

@class WebSocket;

NS_ASSUME_NONNULL_BEGIN

@interface AMHTTPConnection : HTTPConnection 

@property (nonatomic, strong) WebSocket *ws;

@end

NS_ASSUME_NONNULL_END
