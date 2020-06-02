//
//  CycleClickButtonViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/6/2.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "CycleClickButtonViewController.h"
#import "../../../../XXkit/Object-C/Shell/XXbuttonCycleClickShell.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"
#import "../../../../XXkit/Object-C/View/XXtoast.h"

@interface CycleClickButtonViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic,strong) XXbuttonCycleClickShell *shell;
@end

@implementation CycleClickButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _shell = [XXbuttonCycleClickShell new];
    [_shell shell:_button];
    [_shell add:@"red" image:[XXocUtils imageFromColor:UIColor.redColor size:CGSizeMake(50, 50)]];
    [_shell add:@"blue" image:[XXocUtils imageFromColor:UIColor.blueColor size:CGSizeMake(50, 50)]];
    [_shell add:@"green" image:[XXocUtils imageFromColor:UIColor.greenColor size:CGSizeMake(50, 50)]];
    [_shell add:@"black" image:[XXocUtils imageFromColor:UIColor.blackColor size:CGSizeMake(50, 50)]];
    [_shell add:@"orange" image:[XXocUtils imageFromColor:UIColor.orangeColor size:CGSizeMake(50, 50)]];

    _shell.onClicked = ^(XXbuttonCycleClickShell * _Nonnull shell, NSString * _Nonnull previous, NSString * _Nonnull current) {
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
