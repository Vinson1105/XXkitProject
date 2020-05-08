//
//  ZoomableViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/7.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "ZoomableViewController.h"
#import "../../../../XXkit/Object-C/Category/UIView+Zoomable.h"

@interface ZoomableViewController ()
@property (weak, nonatomic) IBOutlet UIView *zoomableView;

@end

@implementation ZoomableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _zoomableView.zoomable = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onButtonTouchUpInside:(id)sender {
    [_zoomableView zoomRestore];
}

@end
