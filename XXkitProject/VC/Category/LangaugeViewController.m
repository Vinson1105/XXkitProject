//
//  LangaugeViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/6/3.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "LangaugeViewController.h"
#import "../../../../XXkit/Object-C/Category/NSBundle+Language.h"
#import "../../../../XXkit/Object-C/Shell/XXtableViewShell.h"

@interface LangaugeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XXtableViewShell *tableShell;
@end

@implementation LangaugeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tipLabel.text = NSLocalizedString(@"language.tip", nil);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    NSLog(@"[Language] %@",path);
    NSArray *available = [NSBundle xx_avaliableLanguages];
    NSLog(@"[Language] %@",available);
    NSLog(@"[Language] %@",[NSBundle mainBundle].resourcePath);

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
