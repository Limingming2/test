//
//  HToastView.m
//  HDT
//
//  Created by 李明明 on 16/6/13.
//  Copyright © 2016年 海融易. All rights reserved.
//

#import "HToastView.h"
#import "HToastLab.h"

#define HMARGIN         10
#define HMINHEIGHT      37
#define HCORNER_RADIUS  6
#define HFONT           14

#define HIMG_MARGIN     90
#define HIMG_BG_HEIGHT  90
#define HTOP            20
#define HIMG_LAB        10
#define HIMG_HEIGHT     25
#define HBG_COLOR   [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]


@interface HToastView ()
@property (nonatomic, strong) UIImage *img;
@end

static HToastLab *_lab;
static HToastView *_bgView;
static UIImageView *_imgView;

@implementation HToastView

+ (HToastLab *)uniqueLab
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _lab = [[HToastLab alloc] init];
    });
    return _lab;
}

+ (HToastView *)shareInstanse
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _bgView = [[HToastView alloc] init];
    });
    return _bgView;
}

+ (UIImageView *)uniqueImgView
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imgView = [[UIImageView alloc] init];
    });
    return _imgView;
}

+ (void)toast:(NSString *)message
{
//    NSString *msg = [NSString stringWithFormat:@".  %@  .", message];
//    NSMutableAttributedString *attmsg = [[NSMutableAttributedString alloc] initWithString:msg];
//    [attmsg addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:NSMakeRange(0, 1)];
//    NSRange range = [msg rangeOfString:@"." options:NSBackwardsSearch];
//    [attmsg addAttribute:NSForegroundColorAttributeName value:[UIColor clearColor] range:range];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.subviews containsObject:_lab]) return ;
    [self initWindow];
    HToastLab *label = [self uniqueLab];
    [window addSubview:label];
    label.text = message;
    [self configLab];
//    label.attributedText = attmsg;
    NSDictionary *metrics = @{@"maxWidth":@([UIScreen mainScreen].bounds.size.width - HMARGIN * 2),@"minHeight":@(HMINHEIGHT)};
    [window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[label(<=maxWidth)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(label)]];
    [window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label(>=minHeight)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(label)]];
    [window addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [window addConstraint:[NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    _lab = label;
    [self performSelector:@selector(removeAll) withObject:nil afterDelay:1.5];
}
+ (void)message:(NSString *)message image:(UIImage *)img
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self initWindow];
    HToastView *bgView = [self shareInstanse];
    bgView.backgroundColor = HBG_COLOR;
    [window addSubview:bgView];
    bgView.translatesAutoresizingMaskIntoConstraints = NO;
    bgView.img = img;
    bgView.layer.cornerRadius = HCORNER_RADIUS;
    
    UIImageView *imgView = [self uniqueImgView];
    imgView.image = [img imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imgView.tintColor = [UIColor whiteColor];
    [bgView addSubview:imgView];
    imgView.contentMode = UIViewContentModeCenter;
    imgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    HToastLab *lab = [self uniqueLab];
    [self configLab];
    lab.text = message;
    lab.backgroundColor = [UIColor clearColor];
    [bgView addSubview:lab];
    
    NSDictionary *metrics = @{@"width":@([UIScreen mainScreen].bounds.size.width - HIMG_MARGIN * 2),@"height":@(HIMG_BG_HEIGHT),@"top":@(HTOP),@"imgHeight":@(HIMG_HEIGHT),@"imglab":@(HIMG_LAB)};
    [window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[bgView(==width)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(bgView)]];
    [window addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bgView(==height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(bgView)]];
    [window addConstraint:[NSLayoutConstraint constraintWithItem:bgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [window addConstraint:[NSLayoutConstraint constraintWithItem:bgView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [bgView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1.5];
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imgView]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(imgView)]];
    
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[lab]-|" options:NSLayoutFormatAlignAllLeft metrics:metrics views:NSDictionaryOfVariableBindings(lab)]];
    [bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[imgView(==imgHeight)]-imglab-[lab(>=0)]" options:NSLayoutFormatAlignAllLeft metrics:metrics views:NSDictionaryOfVariableBindings(lab,imgView)]];
}

+ (void)initWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.frame = [UIScreen mainScreen].bounds;
    window.backgroundColor = [UIColor clearColor];
    for (UIView *view in window.subviews) {
        if (CGRectGetHeight(view.bounds) != kScreenHeight) {
            [view removeFromSuperview];
        }
    }
    window.alpha = 1;
}

+ (void)removeAll
{
    [_lab removeFromSuperview];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (![NSStringFromClass(window.class) isEqualToString:NSStringFromClass([UIWindow class])]) {
        window.alpha = 0;
    }
}

+ (void)configLab
{
    HToastLab *label = [self uniqueLab];
    label.numberOfLines = 0;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = HCORNER_RADIUS;
    label.clipsToBounds = YES;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:HFONT];
    label.backgroundColor = HBG_COLOR;
}




@end
