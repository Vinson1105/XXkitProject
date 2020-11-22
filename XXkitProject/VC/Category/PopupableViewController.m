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
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *topViewPopupConstraints;
@property (nonatomic,strong) NSArray *topViewPopdownConstraints;

@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *rightViewPopupConstraints;
@property (nonatomic,strong) NSArray *rightViewPopdownConstraints;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *leftViewPopupConstraints;
@property (nonatomic,strong) NSArray *leftViewPopdownConstraints;

@property (weak, nonatomic) IBOutlet UIView *midViwe;
@property (weak, nonatomic) IBOutlet UIButton *holdonButton;
@end

@implementation PopupableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _bgView.clipsToBounds = YES;
    
    _topViewPopdownConstraints = @[
        [_topView.bottomAnchor constraintEqualToAnchor:_bgView.topAnchor constant:-10]
    ];
    _topView.popup_upLayoutConstraints = _topViewPopupConstraints;
    _topView.popup_downLayoutConstraints = _topViewPopdownConstraints;
//    [_topView popup_install:YES];
    _topView.popup_active = YES;
    
    _rightViewPopdownConstraints = @[
        [_rightView.leadingAnchor constraintEqualToAnchor:_bgView.trailingAnchor constant:10]
    ];
    _rightView.popup_upLayoutConstraints = _rightViewPopupConstraints;
    _rightView.popup_downLayoutConstraints = _rightViewPopdownConstraints;
//    [_rightView popup_install:YES];
    _rightView.popup_active = YES;

    _leftViewPopdownConstraints = @[
        [_leftView.trailingAnchor constraintEqualToAnchor:_bgView.leadingAnchor constant:-10]
    ];
    _leftView.popup_upLayoutConstraints = _leftViewPopupConstraints;
    _leftView.popup_downLayoutConstraints = _leftViewPopdownConstraints;
//    [_leftView popup_install:YES];
    _leftView.popup_active = YES;

    self.view.xx_visibleInterval = 5;
    self.view.xx_visibleViews = @[_topView,_rightView,_leftView,_midViwe];
    [self.view xx_installTapToVisible:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.xx_visible = NO;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)dealloc{
    [self.view xx_installTapToVisible:NO];
}
- (IBAction)onButtonTouchUpInside:(id)sender {
    UIButton *button = sender;
    button.selected = !button.selected;
    [button setBackgroundColor:button.selected?UIColor.orangeColor:UIColor.grayColor];
    self.view.xx_holdon = button.selected;
    //NSLog(@"popup : %d", !button.selected);
    //self.topView.xx_popup = button.selected;
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
