//
//  ExclusiveButtonViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/26.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "ExclusiveButtonViewController.h"
#import "../../../../XXkit/Object-C/Shell/XXbuttonExclusiveShell.h"
#import "../../../../XXkit/Object-C/View/XXtoast.h"
#import "../../../../XXkit/Object-C/Category/UIButton+StateSettings.h"

@interface ExclusiveButtonViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;

@property (nonatomic,strong) XXbuttonExclusiveShell *buttonShell;
@end

@implementation ExclusiveButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *buttons = @[_button1,_button2,_button3,_button4,_button5];
    for (UIButton *button in buttons) {
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [button setTitleColor:UIColor.redColor forState:UIControlStateSelected];
    }
    
    _buttonShell = [XXbuttonExclusiveShell new];
    [_buttonShell addButton:_button1 name:@"button1"];
    [_buttonShell addButton:_button2 name:@"button2"];
    [_buttonShell addButton:_button3 name:@"button3"];
    [_buttonShell addButton:_button4 name:@"button4"];
    [_buttonShell addButton:_button5 name:@"button5"];
    _buttonShell.onSelectChanged = ^(XXbuttonExclusiveShell * _Nonnull shell, NSString * _Nonnull previous, NSString * _Nonnull current) {
        [XXtoast showMessage:[NSString stringWithFormat:@"%@ -> %@", previous, current]];
    };
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
