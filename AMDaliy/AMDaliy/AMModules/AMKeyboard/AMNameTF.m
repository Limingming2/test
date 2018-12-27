//
//  AMNameTF.m
//  AMDaliy
//
//  Created by limingming on 2018/12/27.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMNameTF.h"

@implementation AMNameTF
{
    BOOL isUser;
}

@synthesize inputAccessoryView = _inputAccessoryView;

- (UIView *)inputAccessoryView
{
    if (!_inputAccessoryView) {
        CGRect frame = CGRectMake(0, 0, 375, 77);
        _inputAccessoryView = [[UIView alloc] initWithFrame:frame];
        _inputAccessoryView.backgroundColor = [UIColor grayColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(20, 20, 200, 37);
        [button setTitle:@"变身" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_inputAccessoryView addSubview:button];
    }
    return _inputAccessoryView;
}

- (UIView *)inputView
{
    CGRect frame = CGRectMake(0, 0, 375, 77);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor redColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [view addSubview:btn];
    btn.frame = CGRectMake(20, 20, 200, 40);
    [btn setTitle:@"我是一个键盘" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    if (!isUser) {
        view = nil;
    }
    return view;
}

- (void)clickAction:(UIButton *)button
{
    isUser = !isUser;
    [self resignFirstResponder];
    [self becomeFirstResponder];
}

- (void)clickKeyboard:(UIButton *)btn
{
    self.text = [self.text stringByAppendingString:@"我是一个键盘"];
    
}

@end
