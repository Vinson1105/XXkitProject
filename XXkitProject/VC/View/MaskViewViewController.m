//
//  MaskViewViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/6/6.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "MaskViewViewController.h"
//#import "../../../../XXkit/Object-C/View/XXmaskView.h"
//#import "../../../../XXkit/Object-C/Category/UIView+MaskView.h"
#import "../../../../XXkit/Object-C/Category/UIView+ModalPopup.h"

@interface CustomView : UIView
@end
@implementation CustomView
@end

@interface MaskViewViewController ()
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *greenButton;
@property (weak, nonatomic) IBOutlet UIButton *blueButton;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UIStackView *stackView;

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) CustomView *colorView;
@end

@implementation MaskViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _imageView = [[UIImageView alloc] initWithImage:[self convertViewToImage:_stackView]];
    [_imageView modalPopup_configAtCenterSize:CGSizeMake(100, 100) margin:0];
    _imageView.modalPopup_touchBackgroundToPopdown = YES;
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
    UIColor *color = UIColor.yellowColor;
    if(sender == _redButton){
        color = UIColor.redColor;
    }
    else if(sender == _greenButton){
        color = UIColor.greenColor;
    }
    else if(sender == _blueButton){
        color = UIColor.blueColor;
    }
    else if(sender == _categoryButton){
//        _imageView.xx_hiddenWithMaskView = NO;
        _imageView.modalPopup_popup = YES;
        return;
    }
    else{
        
    }
    
    CustomView *view = [CustomView new];
    view.backgroundColor = color;
    
    if(self.colorView){
        [self.colorView modalPopup_release];
    }
    self.colorView = view;
    self.colorView.modalPopup_touchBackgroundToPopdown = YES;
    [self.colorView modalPopup_configAtCenterSize:CGSizeMake(100, 100) margin:0];
    self.colorView.modalPopup_popup = YES;
//    [[XXmaskView sharedInstance] show:view animated:YES];
    
}
- (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}
@end
