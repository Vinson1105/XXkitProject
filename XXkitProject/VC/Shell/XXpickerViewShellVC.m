//
//  XXpickerViewShellVC.m
//  XXkitProject
//
//  Created by VINSON on 2020/7/27.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXpickerViewShellVC.h"
#import "../../../../XXkit/Object-C/Shell/XXpickerViewShell.h"

@interface XXpickerViewShellVC ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) XXpickerViewShell *shell;
@end

@implementation XXpickerViewShellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pickerView.hidden = YES;
    _pickerView.backgroundColor = UIColor.grayColor;
    
    _shell = [XXpickerViewShell new];
    [_shell shell:_pickerView];
    NSMutableArray *data = [NSMutableArray new];
    for (int index= 0 ; index<50; index++) {
        [data addObject:[NSString stringWithFormat:@"%d",index]];
    }
    [_shell setData:data atComponent:0];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onButtonUpInside:(id)sender {
    _pickerView.hidden = !_pickerView.hidden;
}

@end
