//
//  ExclusiveButtonViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/26.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "ExclusiveButtonViewController.h"
#import "../../../../XXkit/Object-C/Shell/XXbuttonExclusiveShell.h"
#import "../../../../XXkit/Object-C/Utility/XXtoast.h"
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
        button.layer.borderWidth = 2;
        
        [button setBackgroundColor:UIColor.grayColor forState:UIControlStateNormal];
        [button setBorderColor:UIColor.grayColor forState:UIControlStateNormal];
        
        [button setBackgroundColor:UIColor.blueColor forState:UIControlStateSelected];
        [button setBorderColor:UIColor.blackColor forState:UIControlStateSelected];
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
@end
