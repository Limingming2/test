//
//  AMEnableTwoScene.m
//  AMDaliy
//
//  Created by limingming on 2019/1/3.
//  Copyright © 2019年 limingming. All rights reserved.
//

#import "AMEnableTwoScene.h"
#import "AMLoginScene.h"

@interface AMEnableTwoScene () <AMReceiveDelegate>
@property (nonatomic, weak) IBOutlet UITextField *twoTF;
@property (nonatomic, assign) id<AMReceiveDelegate> delegate;
@end

@implementation AMEnableTwoScene

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickOneBtn:(id)sender
{
    [self.arr addObject:self.twoTF.text];
    [self performSegueWithIdentifier:@"two2three" sender:nil];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    self.delegate = segue.destinationViewController;
    self.delegate.arr = self.arr;
}


@synthesize arr;

@end
