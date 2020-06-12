//
//  MediaRecordAndPlayViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/6/8.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "VideoRecordViewController.h"
#import "../../../../XXkit/Object-C/AV/XXvideoRecorder.h"
#import "../../../../XXkit/Object-C/Category/UIButton+StateSettings.h"

@interface VideoRecordViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@end

@implementation VideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [XXvideoRecorder sharedInstance].preview = self.view;
    [_button setBackgroundColor:UIColor.greenColor forState:UIControlStateNormal];
    [_button setBackgroundColor:UIColor.redColor forState:UIControlStateSelected];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button:(id)sender {
    UIButton *button = sender;
    button.selected = !button.selected;
    if(button.selected){
        [[XXvideoRecorder sharedInstance] startConnect];;
    }
    else{
        [[XXvideoRecorder sharedInstance] stopConnect];;
    }
}
@end
