//
//  PageShiftButtonViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/6/5.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "PageShiftButtonViewController.h"
#import "../../../../XXkit/Object-C/Shell/XXbuttonPageShiftShell.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"
#import "../../../../XXkit/Object-C/Utility/XXtoast.h"

@interface PageShiftButtonViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *prev;
@property (weak, nonatomic) IBOutlet UIButton *next;
@property (nonatomic,strong) XXbuttonPageShiftShell *shell;
@end

@implementation PageShiftButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _shell = [XXbuttonPageShiftShell new];
    [_shell shellWithPrev:_prev next:_next page:_label];
    [_shell resetCurrent:1 count:10];
    _shell.onPageTouchChanged = ^(XXbuttonPageShiftShell * _Nonnull shell, int previous, int current) {
        [XXtoast showMessage:[NSString stringWithFormat:@"%d -> %d", previous, current]];
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
