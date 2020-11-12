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
#import "XXocUtils.h"

@interface ViewA : UIView
@end
@implementation ViewA
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"[###] [ViewA] touchesBegan");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"[###] [ViewA] touchesMoved");
}
@end

@interface VideoRecordViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic,strong) UIView *preview;
@end

@implementation VideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.preview = [[ViewA alloc] initWithFrame:CGRectMake(50, 50, 50, 100)];
    self.preview.backgroundColor = UIColor.blackColor;
    [self.view insertSubview:self.preview aboveSubview:self.tableView];
//    [self.view addSubview:self.preview];

    [XXvideoRecorder sharedInstance].preview = self.preview;
    [_button setBackgroundColor:UIColor.greenColor forState:UIControlStateNormal];
    [_button setBackgroundColor:UIColor.redColor forState:UIControlStateSelected];
    
    ViewA *viewA = [[ViewA alloc] initWithFrame:CGRectMake(0, 200, 100, 100)];
    viewA.backgroundColor = UIColor.grayColor;
    [self.view addSubview:viewA];
}
- (void)dealloc{
    [XXvideoRecorder sharedInstance].preview = nil;
    [[XXvideoRecorder sharedInstance] stopConnect];
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
    if(button.selected){
        [[XXvideoRecorder sharedInstance] stopConnect];
        button.selected = NO;
    }
    else{
        [XXocUtils anthorizedCameraCheckAtViewController:self title:@"请求权限" message:@"请求摄像机权限" succeed:^{
            [[XXvideoRecorder sharedInstance] startConnect];
            button.selected = YES;
        }];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"[###] [VideoRecordViewController] touchesBegan");
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"[###] [VideoRecordViewController] touchesMoved");
}
@end
