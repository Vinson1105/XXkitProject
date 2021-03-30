//
//  KeyboardAdapterViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/12/15.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "KeyboardAdapterViewController.h"
#import "../../../../XXkit/Objective-C/Category/UIView+KeyboradAdapter.h"
#import "../../../../XXkit/Objective-C/Category/UIView+ModalPopup.h"
#import "../../../../XXkit/Objective-C/XXocUtils.h"

@interface KeyboardAdapterViewController ()
@property (nonatomic,strong) UIView *pview;
@end

@implementation KeyboardAdapterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"SHOW" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [XXocUtils view:button centerAt:self.view];
    [button addTarget:self action:@selector(onShow) forControlEvents:UIControlEventTouchUpInside];
    
    self.pview = [UIView new];
    self.pview.translatesAutoresizingMaskIntoConstraints = NO;
    self.pview.backgroundColor = UIColor.whiteColor;
    self.pview.layer.cornerRadius = 20;
    
    UITextField *tf1 = [UITextField new];
    tf1.translatesAutoresizingMaskIntoConstraints = NO;
    tf1.backgroundColor = UIColor.grayColor;
    [self.pview addSubview:tf1];
    [tf1.leadingAnchor constraintEqualToAnchor:self.pview.leadingAnchor constant:10].active = YES;
    [tf1.trailingAnchor constraintEqualToAnchor:self.pview.trailingAnchor constant:-10].active = YES;
    [tf1.topAnchor constraintEqualToAnchor:self.pview.topAnchor constant:10].active = YES;

    UITextField *tf2 = [UITextField new];
    tf2.translatesAutoresizingMaskIntoConstraints = NO;
    tf2.backgroundColor = UIColor.grayColor;
    [self.pview addSubview:tf2];
    [tf2.leadingAnchor constraintEqualToAnchor:self.pview.leadingAnchor constant:10].active = YES;
    [tf2.trailingAnchor constraintEqualToAnchor:self.pview.trailingAnchor constant:-10].active = YES;
    [tf2.topAnchor constraintEqualToAnchor:tf1.bottomAnchor constant:10].active = YES;
    [tf2.bottomAnchor constraintEqualToAnchor:self.pview.bottomAnchor constant:-10].active = YES;

    NSMutableArray *upLayouts = [NSMutableArray new];
    [upLayouts addObject:[self.pview.leadingAnchor constraintEqualToAnchor:self.pview.modalPopup_backgroundView.leadingAnchor constant:20]];
    [upLayouts addObject:[self.pview.trailingAnchor constraintEqualToAnchor:self.pview.modalPopup_backgroundView.trailingAnchor constant:-20]];
    [upLayouts addObject:[self.pview.bottomAnchor constraintEqualToAnchor:self.pview.modalPopup_backgroundView.bottomAnchor constant:-20]];
    //[upLayouts addObject:[self.pview.centerYAnchor constraintEqualToAnchor:self.pview.modalPopup_backgroundView.centerYAnchor constant:50]];
    
    NSMutableArray *downLayouts = [NSMutableArray new];
    [downLayouts addObject:[self.pview.leadingAnchor constraintEqualToAnchor:self.pview.modalPopup_backgroundView.leadingAnchor constant:20]];
    [downLayouts addObject:[self.pview.trailingAnchor constraintEqualToAnchor:self.pview.modalPopup_backgroundView.trailingAnchor constant:-20]];
    [downLayouts addObject:[self.pview.topAnchor constraintEqualToAnchor:self.pview.modalPopup_backgroundView.bottomAnchor constant:20]];

    [self.pview modalPopup_configPopupConstraint:upLayouts popdownConstraint:downLayouts];
    self.pview.modalPopup_touchBackgroundToPopdown = YES;
    [self.pview keyboradAdapter_install:YES];
    self.pview.keyboradAdapter_vlayout = upLayouts[2];
}
- (void)dealloc{
    [self.pview modalPopup_release];
}
-(void)onShow{
    self.pview.modalPopup_popup = YES;
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
