//
//  AMControlView.m
//  AMDaliy
//
//  Created by 李明明 on 2018/8/19.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMControlView.h"
#import <objc/runtime.h>

#define AM_ADDBTN_WIDTH     40
#define AM_RIGHT_MARGIN     15
#define AM_BTN_BG_ALPHA     0.6
#define AM_ADDBTN_HEIGHT    AM_ADDBTN_WIDTH
#define AM_TOP_MARGIN       AM_RIGHT_MARGIN


@interface AMControlView ()

@property (nonatomic, weak) UILabel *txtLab;
@property (nonatomic, weak) UIButton *addBtn;
@property (nonatomic, weak) UIButton *reduceBtn;
@end

@implementation AMControlView

+ (void)load
{
    Method targetShowMethod = class_getInstanceMethod([self class], @selector(showControlViewWithAnimated:));
    Method oriShowMethod = class_getInstanceMethod([self superclass], @selector(showControlViewWithAnimated:));
    method_exchangeImplementations(targetShowMethod, oriShowMethod);
    
    Method targetHideMethod = class_getInstanceMethod([self class], @selector(hideControlViewWithAnimated:));
    Method oriHideMethod = class_getInstanceMethod([self superclass], @selector(hideControlViewWithAnimated:));
    method_exchangeImplementations(targetHideMethod, oriHideMethod);
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.txtLab.text = @"1.0";
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    if (!self.portraitControlView.hidden) {
        [self.txtLab removeFromSuperview];
        [self.portraitControlView addSubview:self.txtLab];
        [self.addBtn removeFromSuperview];
        [self.portraitControlView addSubview:self.addBtn];
        [self.reduceBtn removeFromSuperview];
        [self.portraitControlView addSubview:self.reduceBtn];
        x = kScreenWidth - AM_ADDBTN_WIDTH * 3 - AM_RIGHT_MARGIN;
    }else {
        [self.txtLab removeFromSuperview];
        [self.landScapeControlView addSubview:self.txtLab];
        [self.addBtn removeFromSuperview];
        [self.landScapeControlView addSubview:self.addBtn];
        [self.reduceBtn removeFromSuperview];
        [self.landScapeControlView addSubview:self.reduceBtn];
        x = kScreenHeight - AM_ADDBTN_WIDTH * 3 - AM_RIGHT_MARGIN;
    }
    self.txtLab.frame = CGRectMake(x + AM_ADDBTN_WIDTH, AM_TOP_MARGIN, AM_ADDBTN_WIDTH, AM_ADDBTN_HEIGHT);
    self.addBtn.frame = CGRectMake(x + AM_ADDBTN_WIDTH * 2, AM_TOP_MARGIN, AM_ADDBTN_WIDTH, AM_ADDBTN_HEIGHT);
    self.reduceBtn.frame = CGRectMake(x, AM_TOP_MARGIN, AM_ADDBTN_WIDTH, AM_ADDBTN_HEIGHT);
}

#pragma mark - setter and getter

- (UILabel *)txtLab
{
    if (!_txtLab) {
        UILabel *txtLab = [[UILabel alloc] init];
        txtLab.textAlignment = NSTextAlignmentCenter;
        [self.portraitControlView addSubview:txtLab];
        txtLab.textColor = [UIColor whiteColor];
        txtLab.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:AM_BTN_BG_ALPHA];
        _txtLab = txtLab;
    }
    return _txtLab;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *addbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.portraitControlView addSubview:addbtn];
        [addbtn setTitle:@"+" forState:UIControlStateNormal];
        [addbtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [addbtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:AM_BTN_BG_ALPHA]];
        _addBtn = addbtn;
    }
    return _addBtn;
}

- (UIButton *)reduceBtn
{
    if (!_reduceBtn) {
        UIButton *reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.portraitControlView addSubview:reduceBtn];
        [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
        [reduceBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [reduceBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:AM_BTN_BG_ALPHA]];
        _reduceBtn = reduceBtn;
    }
    return _reduceBtn;
}

#pragma mark - user action

- (void)btnAction:(id)button
{
    CGFloat rate = [self calculateWithAdd:[button isEqual:self.addBtn]];
    self.txtLab.text = [NSString stringWithFormat:@"%.1f", rate];
    if (self.rate) {
        self.rate(rate);
    }
}

#pragma mark - private methods

- (CGFloat)calculateWithAdd:(BOOL)isAdd
{
    CGFloat result = [self.txtLab.text floatValue];
    if (isAdd) {
        result += 0.1;
    }else {
        result -= 0.1;
    }
    result = result > 2.0 ? 2.0 : result;
    result = result < 0.5 ? 0.5 : result;
    return result;
}

- (void)showControlViewWithAnimated:(BOOL)animated
{
    [self showControlViewWithAnimated:animated];
    self.addBtn.hidden = NO;
    self.reduceBtn.hidden = NO;
    self.txtLab.hidden = NO;
}

- (void)hideControlViewWithAnimated:(BOOL)animated
{
    [self hideControlViewWithAnimated:animated];
    self.addBtn.hidden = YES;
    self.reduceBtn.hidden = YES;
    self.txtLab.hidden = YES;
}
    


@end
