//
//  XXtextFieldShellVC.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/22.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXtextFieldShellVC.h"
#import "../../../../XXkit/Object-C/UITextField/TextFieldExpressShell.h"

@interface XXtextFieldShellVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,strong) TextFieldExpressShell *expressShell;
@end

@implementation XXtextFieldShellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _expressShell = [TextFieldExpressShell new];
    [_expressShell shell:_textField];
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
