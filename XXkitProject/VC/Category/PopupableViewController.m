//
//  PopupableViewViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/23.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "PopupableViewController.h"
#import "../../../../XXkit/Object-C/Category/UIView+Popup.h"
#import "../../../../XXkit/Object-C/Category/UIView+TapToVisible.h"

@interface PopupableViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *topViewPopupConstraints;
@property (nonatomic,strong) NSArray *topViewPopdownConstraints;

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rightViewPopupConstraints;
@property (nonatomic,strong) NSArray *rightViewPopdownConstraints;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *bottomViewPopupConstraints;
@property (nonatomic,strong) NSArray *bottomViewPopdownConstraints;

@property (weak, nonatomic) IBOutlet UIView *midViwe;
@property (weak, nonatomic) IBOutlet UIButton *holdonButton;
@end

@implementation PopupableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _topViewPopdownConstraints = @[
        [_topView.bottomAnchor constraintEqualToAnchor:self.view.topAnchor constant:-10]
    ];
    _topView.xx_popupConstraint = _topViewPopupConstraints;
    _topView.xx_popdownConstraint = _topViewPopdownConstraints;
    
    _rightViewPopdownConstraints = @[
        [_rightView.leadingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:10]
    ];
    _rightView.xx_popupConstraint = _rightViewPopupConstraints;
    _rightView.xx_popdownConstraint = _rightViewPopdownConstraints;
    
    _bottomViewPopdownConstraints = @[
        [_bottomView.topAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:10]
    ];
    _bottomView.xx_popupConstraint = _bottomViewPopupConstraints;
    _bottomView.xx_popdownConstraint = _bottomViewPopdownConstraints;
    
    self.view.xx_visibleViews = @[_topView,_rightView,_bottomView,_midViwe];
    [self.view xx_installTapToVisible:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.xx_visible = NO;
}
- (void)dealloc{
    [self.view xx_installTapToVisible:NO];
}
- (IBAction)onButtonTouchUpInside:(id)sender {
    UIButton *button = sender;
    button.selected = !button.selected;
    [button setBackgroundColor:button.selected?UIColor.orangeColor:UIColor.grayColor];
    self.view.xx_holdon = button.selected;
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
