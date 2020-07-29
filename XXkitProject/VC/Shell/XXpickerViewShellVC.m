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
    
    _shell = [XXpickerViewShell new];
    [_shell shell:_pickerView];
    NSMutableArray *data = [NSMutableArray new];
    for (int index= 0 ; index<50; index++) {
        [data addObject:[NSString stringWithFormat:@"%d",index]];
    }
    _shell.componentData = @[data];
    _shell.selectedColor = UIColor.blueColor;
    
    UILabel *suffixLabel = [UILabel new];
    suffixLabel.translatesAutoresizingMaskIntoConstraints = NO;
    suffixLabel.textColor = UIColor.redColor;
    suffixLabel.text = @"秒";
    
    [_pickerView addSubview:suffixLabel];
    _pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    CGSize size = [_pickerView rowSizeForComponent:0];
    [suffixLabel.centerYAnchor constraintEqualToAnchor:_pickerView.centerYAnchor].active = YES;
    [suffixLabel.centerXAnchor constraintEqualToAnchor:_pickerView.centerXAnchor constant:size.height*2].active = YES;
}

- (IBAction)onButtonUpInside:(id)sender {
    _pickerView.hidden = !_pickerView.hidden;
}

@end
