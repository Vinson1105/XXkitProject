//
//  MainViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/14.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "MainViewController.h"
#import "../../XXkit/Object-C/TableView/XXtableViewShell.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XXtableViewShell *shell;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _shell = [XXtableViewShell new];
    [_shell shell:_tableView];
    [_shell configSectionWithHeader:nil row:@[@"XXtableViewShell"] footer:nil];
    [_shell configFinished];
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
