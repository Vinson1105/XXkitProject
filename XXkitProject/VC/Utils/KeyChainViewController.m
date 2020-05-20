//
//  KeyChainViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/5/20.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "KeyChainViewController.h"
#import "../../../../XXkit/Object-C/Utility/XXkeyChain.h"

@interface KeyChainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UIButton *check;
@property (weak, nonatomic) IBOutlet UIButton *update;
@property (weak, nonatomic) IBOutlet UIButton *del;

@end

@implementation KeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)onButtonTouchUpInside:(id)sender {
    if(sender == _check){
        NSError *error = nil;
        NSString *password =  [[XXkeyChain sharedInstance] getPasswordWithAccount:_account.text error:&error];
        if(error){
            NSLog(@"[KeyChainViewController] %@",error);
        }
        else {
            NSLog(@"[KeyChainViewController] %@",password);
            _password.text = password;
        }
    }
    else if(sender == _update){
        NSError *error = nil;
        [[XXkeyChain sharedInstance] updateAccount:_account.text password:_password.text error:&error];
        if(error){
            NSLog(@"[KeyChainViewController] %@",error);
        }
    }
    else if(sender == _del){
        NSError *error = nil;
        [[XXkeyChain sharedInstance] deleteAccount:_account.text error:&error];
        if(error){
            NSLog(@"[KeyChainViewController] %@",error);
        }
    }
    else{
    }
}

@end
