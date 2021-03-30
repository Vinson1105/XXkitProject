//
//  OrientationViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/6.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "OrientationViewController.h"
#import "../../../../XXkit/Objective-C/Category/UIViewController+Orientation.h"
#import "../../../../XXkit/Objective-C/XXocUtils.h"

@interface OrientationViewController ()
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *installLayouts;

@end

@implementation OrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self installOrientation:YES];
    self.portraitLayouts = _installLayouts;
    self.landscapeLayouts = @[
        [_blueView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:20],
        [_blueView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [_blueView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-20],
        [_blueView.widthAnchor constraintEqualToConstant:120],
        
        [_redView.topAnchor constraintEqualToAnchor:_blueView.topAnchor],
        [_redView.bottomAnchor constraintEqualToAnchor:_blueView.bottomAnchor],
        [_redView.widthAnchor constraintEqualToAnchor:_blueView.widthAnchor],
        [_redView.leadingAnchor constraintEqualToAnchor:_blueView.trailingAnchor constant:20],
        
        [_greenView.topAnchor constraintEqualToAnchor:_blueView.topAnchor],
        [_greenView.bottomAnchor constraintEqualToAnchor:_blueView.bottomAnchor],
        [_greenView.widthAnchor constraintEqualToAnchor:_blueView.widthAnchor],
        [_greenView.leadingAnchor constraintEqualToAnchor:_redView.trailingAnchor constant:20],
    ];
    
    self.onOrientationWillChange = ^{
        NSLog(@"[OrientationViewController] onOrientationWillChange");
    };
    
    XXOC_WS
    self.onOrientationDidChanged = ^{
        XXOC_SS
        NSLog(@"[OrientationViewController] onOrientationDidChanged %d", ss.isLandscape);
    };
}
- (void)dealloc{
    [self installOrientation:NO];
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
