//
//  AMBlurView.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/6.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMBlurView.h"
#import "AppDelegate.h"

static AMBlurView *_blurView;

@implementation AMBlurView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _blurView = self;
    }
    return self;
}

+ (void)showInWindow:(UIWindow *)window
{
    if (!_blurView) {
//        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        UIVibrancyEffect *brancy = [UIVibrancyEffect effectForBlurEffect:effect];
//        _blurView = [[AMBlurView alloc] initWithEffect:brancy];
//        _blurView.frame = [UIScreen mainScreen].bounds;
//        _blurView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.95];
        
        _blurView = [[AMBlurView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIImage *img = [_blurView screenImageWithSize:[UIScreen mainScreen].bounds.size];
        UIImage *image = [_blurView convertToBlurImage:img];
        _blurView.image = [_blurView convertToBlurImage:image];
        
    }
    [window addSubview:_blurView];
}

+ (void)dismiss
{
    if (_blurView) {
        [_blurView removeFromSuperview];
        _blurView = nil;
    }
}

-(UIImage *)convertToBlurImage:(UIImage *)image{
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlurFilter setDefaults];
    CIImage *inputImage = [CIImage imageWithCGImage:[image CGImage]];
    [gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
    [gaussianBlurFilter setValue:@4 forKey:kCIInputRadiusKey];
    CIImage *outputImage = [gaussianBlurFilter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[inputImage extent]];
    UIImage *convertedImage = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    return convertedImage;
}

// 获取当前截图
-(UIImage *)screenImageWithSize:(CGSize )imgSize{
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate; //获取app的appdelegate，便于取到当前的window用来截屏
    [app.window.layer renderInContext:context];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
