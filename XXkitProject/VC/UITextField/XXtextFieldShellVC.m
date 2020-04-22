//
//  XXtextFieldShellVC.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/22.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXtextFieldShellVC.h"
#import "../../../../XXkit/Object-C/UITextField/TextFieldExpressShell.h"
#import "../../../../XXkit/Object-C/UITextField/TextFieldPasswordShell.h"
#import "../../../../XXkit/Object-C/UITextField/XXtextFieldShell.h"

@interface XXtextFieldShellVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (nonatomic,strong) TextFieldExpressShell *expressShell;
@property (nonatomic,strong) TextFieldPasswordShell *passwordShell;
@property (nonatomic,strong) XXtextFieldShell *shell2;
@end

@implementation XXtextFieldShellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _passwordShell = [TextFieldPasswordShell new];
    [_passwordShell shell:_textField];
    _passwordShell.clearImage = [UIImage imageNamed:@"common_btn_cancel"];
    _passwordShell.secureONImage = [UIImage imageNamed:@"common_btn_pwhide"];
    _passwordShell.secureOFFImage = [UIImage imageNamed:@"common_btn_pwshow"];


    _shell2 = [XXtextFieldShell new];
    [_shell2 shell:_textField2];
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
