//
//  MainViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/14.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "MainViewController.h"
#import "./VC/UITableVIew/XXtableViewShellVC.h"
#import "../../XXkit/Object-C/UITableView/XXtableViewShell.h"
#import "../../XXkit/Object-C/XXocUtility.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XXtableViewShell *shell;

@property (nonatomic,copy) void(^onTableViewRowClicked)(XXtableViewShell *shell, NSIndexPath *indexPath, id data);
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _shell = [XXtableViewShell new];
    [_shell shell:_tableView];
    [_shell configSectionWithHeader:nil row:@[@"XXtableViewShell"] footer:nil];
    [_shell configFinished];
    
    _shell.onRowClicked = self.onTableViewRowClicked;
}


- (void (^)(XXtableViewShell*, NSIndexPath *, id))onTableViewRowClicked{
    if(!_onTableViewRowClicked){
        XXOC_WS;
        _onTableViewRowClicked = ^(XXtableViewShell *shell,NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
            XXOC_SS;
            XXtableViewShellVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"XXtableViewShellVC"];
            [ss.navigationController pushViewController:vc animated:YES];
        };
    }
    return _onTableViewRowClicked;
}

@end
