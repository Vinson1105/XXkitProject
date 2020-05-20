//
//  TouchIDViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/18.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "TouchIDViewController.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"

@interface TouchIDViewController()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@end

@implementation TouchIDViewController
- (void)viewDidLoad{
}
- (IBAction)onButtonTouchUpInside:(id)sender {
    [XXocUtils evaluatePolicyWithReason:@"111" reply:^(BOOL success, NSError * _Nullable error) {
        NSLog(@"[TouchIDViewController] Utils success:%d error:%@", success, error);
    }];
}

- (IBAction)button3:(id)sender {
}
@end
