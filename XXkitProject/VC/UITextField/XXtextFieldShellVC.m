//
//  XXtextFieldShellVC.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/22.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXtextFieldShellVC.h"
#import "../../../../XXkit/Object-C/UITextField/XXtextFieldShell.h"

@interface XXtextFieldShellVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (nonatomic,strong) XXtextFieldShell *shell1;
@property (nonatomic,strong) XXtextFieldShell *shell2;
@end

@implementation XXtextFieldShellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shell1 = [XXtextFieldShell new];
    [_shell1 shell:_textField];
    [_shell1 configLogo:[UIImage imageNamed:@"username"] size:CGSizeMake(30, 30)];
    [_shell1 configClear:[UIImage imageNamed:@"common_btn_cancel"] size:CGSizeMake(30, 30) margin:5];

    _shell2 = [XXtextFieldShell new];
    [_shell2 shell:_textField2];
    [_shell2 configLogo:[UIImage imageNamed:@"password"] size:CGSizeMake(30, 30)];
    [_shell2 configClear:[UIImage imageNamed:@"common_btn_cancel"]
                secureON:[UIImage imageNamed:@"common_btn_pwhide"]
               secureOFF:[UIImage imageNamed:@"common_btn_pwshow"]
                    size:CGSizeMake(30, 30)
                  margin:5
                 spacing:5];
    // Do any additional setup after loading the view.
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
