//
//  XXtextFieldShellVC.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/22.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXtextFieldShellVC.h"
#import "../../../../XXkit/Object-C/UITextField/XXtextFieldShell.h"
#import "../../../../XXkit/Object-C/Shell/XXloginShell.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"

#define kBarViewBgColorON   [XXocUtils colorFromHexString:@"#33cccc"]
#define kBarViewBgColorOFF  [XXocUtils colorFromHexString:@"#f6f6ee"]

 
@interface XXtextFieldShellVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (nonatomic,strong) XXtextFieldShell *shell1;
@property (nonatomic,strong) XXtextFieldShell *shell2;

@property (weak, nonatomic) IBOutlet UITextField *textField3;
@property (weak, nonatomic) IBOutlet UITextField *textField4;
@property (weak, nonatomic) IBOutlet UIView *textField3BarView;
@property (weak, nonatomic) IBOutlet UIView *textField4BarView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic,strong) XXloginShell *mijiaLoginShell;
@end

@implementation XXtextFieldShellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _shell1 = [XXtextFieldShell new];
    [_shell1 shell:_textField1];
    [_shell1 configLogo:[UIImage imageNamed:@"login.account"] size:CGSizeMake(30, 30)];
    [_shell1 configClear:[UIImage imageNamed:@"login.clear"] size:CGSizeMake(30, 30) margin:5];

    _shell2 = [XXtextFieldShell new];
    [_shell2 shell:_textField2];
    [_shell2 configLogo:[UIImage imageNamed:@"login.password"] size:CGSizeMake(30, 30)];
    [_shell2 configClear:[UIImage imageNamed:@"login.clear"]
                secureON:[UIImage imageNamed:@"login.secureON"]
               secureOFF:[UIImage imageNamed:@"login.secureOFF"]
                    size:CGSizeMake(30, 30)
                  margin:5
                 spacing:5];
    
    _mijiaLoginShell = [XXloginShell new];
    [_mijiaLoginShell shellAccount:_textField3 password:_textField4];
    [_mijiaLoginShell configAccountLogo:[UIImage imageNamed:@"login.account"]
                           passwordLogo:[UIImage imageNamed:@"login.password"]
                                   size:CGSizeMake(30, 30)];
    [_mijiaLoginShell configClearImage:[UIImage imageNamed:@"login.clear"]
                              secureON:[UIImage imageNamed:@"login.secureON"]
                             secureOFF:[UIImage imageNamed:@"login.secureOFF"]
                                  size:CGSizeMake(30, 30)
                                margin:5
                               spacing:5];
    XXOC_WS;
    [_mijiaLoginShell configOKButton:_loginButton action:^(NSString * _Nonnull account, NSString * _Nonnull password) {
        UIAlertController *alert = [XXocUtils alertWithTitle:@"title"
                                                         msg:[NSString stringWithFormat:@"Account:%@\nPassword:%@",account,password]
                                                     okTitle:@"ok"
                                                        onOK:^(UIAlertAction * _Nonnull action) {}
                                                 cancelTitle:@"cancel"
                                                    onCancel:^(UIAlertAction * _Nonnull action) {}];
        XXOC_SS;
        [ss presentViewController:alert animated:YES completion:nil];
    }];
    _mijiaLoginShell.accountShell.onEditBegin = ^(XXtextFieldShell * _Nonnull shell) {
        XXOC_SS;
        ss.textField3BarView.backgroundColor = kBarViewBgColorON;
        ss.textField4BarView.backgroundColor = kBarViewBgColorOFF;
    };
    _mijiaLoginShell.passwordShell.onEditBegin = ^(XXtextFieldShell * _Nonnull shell) {
        XXOC_SS;
        ss.textField3BarView.backgroundColor = kBarViewBgColorOFF;
        ss.textField4BarView.backgroundColor = kBarViewBgColorON;
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
