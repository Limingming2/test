//
//  HToastLab.m
//  HDT
//
//  Created by 李明明 on 16/10/19.
//  Copyright © 2016年 海融易. All rights reserved.
//

#import "HToastLab.h"

@implementation HToastLab

- (void)drawTextInRect:(CGRect)rect
{
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [self.text drawInRect:CGRectMake(0, 10, rect.size.width, rect.size.height) withAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSParagraphStyleAttributeName:style}];
}

@end
