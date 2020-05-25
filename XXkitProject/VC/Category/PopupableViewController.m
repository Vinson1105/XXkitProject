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
    _topView.xx_popupConstraint = _topViewPopupConstraints;
    _topView.xx_popdownConstraint = _topViewPopdownConstraints;
    [_topView xx_initPopup:YES];
    
    _rightViewPopdownConstraints = @[
        [_rightView.leadingAnchor constraintEqualToAnchor:_bgView.trailingAnchor constant:10]
    ];
    _rightView.xx_popupConstraint = _rightViewPopupConstraints;
    _rightView.xx_popdownConstraint = _rightViewPopdownConstraints;
    [_rightView xx_initPopup:YES];

    _leftViewPopdownConstraints = @[
        [_leftView.trailingAnchor constraintEqualToAnchor:_bgView.leadingAnchor constant:-10]
    ];
    _leftView.xx_popupConstraint = _leftViewPopupConstraints;
    _leftView.xx_popdownConstraint = _leftViewPopdownConstraints;
    [_leftView xx_initPopup:YES];

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
