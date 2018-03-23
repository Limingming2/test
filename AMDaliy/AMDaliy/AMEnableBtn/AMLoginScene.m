//
//  AMLoginScene.m
//  AMDaliy
//
//  Created by 李明明 on 2018/3/23.
//  Copyright © 2018年 limingming. All rights reserved.
//

#import "AMLoginScene.h"

@interface AMLoginScene () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameTF;
@property (nonatomic, weak) IBOutlet UITextField *pwdTF;
@property (nonatomic, weak) IBOutlet UIButton *certainBtn;
@property (nonatomic, weak) IBOutlet UIButton *agreeBtn;
@property (nonatomic, strong) NSArray *viewArr;
@end

@implementation AMLoginScene

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewArr = @[self.nameTF, self.pwdTF];
    [self.agreeBtn setTitle:@"V" forState:UIControlStateSelected];
    [self.agreeBtn setTitle:@"" forState:UIControlStateNormal];
    [self changeCertainBtnState];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 使用通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldHaveChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - user action

- (IBAction)certainAction:(id)sender
{
    NSLog(@"确定");
}

- (IBAction)agreeAction:(id)sender
{
    self.agreeBtn.selected = !self.agreeBtn.selected;
    [self changeCertainBtnState];
}

- (void)textFieldHaveChanged:(NSNotification *)noti
{
    [self changeCertainBtnState];
}

#pragma mark - private methods

- (BOOL)judgeBtnEnable
{
    BOOL allHaveContent = YES;
    // 判断textfield
    for (UITextField *tf in self.viewArr) {
        if (tf.text.length == 0) {
            allHaveContent = NO;
            break;
        }
    }
    // 判断是否同意
    if (allHaveContent) {
        allHaveContent = self.agreeBtn.selected;
    }
    return allHaveContent;
}

- (void)changeCertainBtnState
{
    self.certainBtn.enabled = [self judgeBtnEnable];
    self.certainBtn.backgroundColor = self.certainBtn.enabled ? [UIColor blueColor] : [UIColor grayColor];
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
