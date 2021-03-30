//
//  ActivityIndicatorViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2021/3/29.
//  Copyright © 2021 郭文轩. All rights reserved.
//

#import "ActivityIndicatorViewController.h"
#import "../../../../XXkit/Objective-C/Category/UIViewController+ActivityIndicator.h"

@implementation ActivityIndicatorViewController
- (void)viewDidLoad{
}

- (IBAction)onButtonTouchUpInside:(id)sender {
    [self activityIndicator_show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self activityIndicator_hide];
    });
}
@end
