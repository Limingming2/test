//
//  AMEnableThreeScene.m
//  AMDaliy
//
//  Created by limingming on 2019/1/3.
//  Copyright © 2019年 limingming. All rights reserved.
//

#import "AMEnableThreeScene.h"
#import "AMLoginScene.h"

@interface AMEnableThreeScene () <AMReceiveDelegate>
@property (nonatomic, weak) IBOutlet UITextField *threeTF;
@end

@implementation AMEnableThreeScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickOneBtn:(id)sender
{
    NSLog(@"%@", self.threeTF.text);
    [self.arr addObject:self.threeTF.text];
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
//    [self performSegueWithIdentifier:@"three2main" sender:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}


@synthesize arr;

@end
