//
//  XXstackViewShellVC.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/22.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXstackViewShellVC.h"
#import "../../../../XXkit/Objective-C/Shell/XXstackViewShell.h"

@interface XXstackViewShellVC ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property (weak, nonatomic) IBOutlet UIStackView *hstackView1;
@property (weak, nonatomic) IBOutlet UIStackView *hstackView2;
@property (weak, nonatomic) IBOutlet UIStackView *vstackView1;
@property (weak, nonatomic) IBOutlet UIStackView *vstackView2;

@property (nonatomic,strong) XXstackViewShell *hstackViewShell1;
@property (nonatomic,strong) XXstackViewShell *hstackViewShell2;
@property (nonatomic,strong) XXstackViewShell *vstackViewShell1;
@property (nonatomic,strong) XXstackViewShell *vstackViewShell2;

@property (nonatomic,strong) NSMutableArray *names;
@property (nonatomic,strong) NSArray *colors;
@property (nonatomic,strong) NSArray *shells;
@end

@implementation XXstackViewShellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hstackViewShell1 = [XXstackViewShell new];
    [_hstackViewShell1 shell:_hstackView1];
    
    _hstackViewShell2 = [XXstackViewShell new];
    [_hstackViewShell2 shell:_hstackView2];
    
    _vstackViewShell1 = [XXstackViewShell new];
    [_vstackViewShell1 shell:_vstackView1];
    
    _vstackViewShell2 = [XXstackViewShell new];
    [_vstackViewShell2 shell:_vstackView2];
    
    _shells = @[_hstackViewShell1,_hstackViewShell2,_vstackViewShell1,_vstackViewShell2];
    _names = [NSMutableArray new];
    _colors = @[UIColor.blueColor,UIColor.brownColor,UIColor.cyanColor,UIColor.darkGrayColor,UIColor.grayColor,UIColor.greenColor,UIColor.lightGrayColor,UIColor.magentaColor];
}
- (IBAction)onButtonTouchUpInside:(id)sender {
    UIButton *button = sender;
    if(button == _addButton){
        int count       = (int)_names.count;
        NSString *name  = [NSString stringWithFormat:@"%d",count];
        UIColor *color  = _colors[count%_colors.count];
        
        for (XXstackViewShell *shell in _shells) {
            UIView *view = [UIView new];
            view.backgroundColor = color;
            [shell addView:view size:CGSizeMake(40, 40) forName:name];
        }
        [_names addObject:name];
    }
    else if(button == _delButton){
        if(_names.count <= 0){
            return;
        }
        NSString *name = _names.lastObject;
        for (XXstackViewShell *shell in _shells) {
            [shell removeViewForName:name];
        }
        [_names removeLastObject];
    }
    else{
        
    }
}
@end
