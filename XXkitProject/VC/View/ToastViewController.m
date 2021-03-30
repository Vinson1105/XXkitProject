//
//  ToastViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/20.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "ToastViewController.h"
#import "../../../../XXkit/Objective-C/Utility/XXtoast.h"

@interface ToastViewController ()
@property (weak, nonatomic) IBOutlet UIButton *tips1;
@property (weak, nonatomic) IBOutlet UIButton *tips2;
@property (weak, nonatomic) IBOutlet UIButton *tips3;

@end

@implementation ToastViewController

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
- (IBAction)onTips:(id)sender {
    if(sender == _tips1){
        [XXtoast showMessage:@"这个是提示1"];
    }
    else if(sender == _tips2){
        [XXtoast showMessage:@"这个是提示2"];
    }
    else if(sender == _tips3){
        [XXtoast showMessage:@"这个是提示3"];
    }
    else{
    }
}
@end
