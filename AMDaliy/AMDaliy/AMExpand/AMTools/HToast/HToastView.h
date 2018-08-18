//
//  HToastView.h
//  HDT
//
//  Created by 李明明 on 16/6/13.
//  Copyright © 2016年 海融易. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HToastView : UIView
+ (void)toast:(NSString *)message;
+ (void)message:(NSString *)message image:(UIImage *)img;
@end
