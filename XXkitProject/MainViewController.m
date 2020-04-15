//
//  MainViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/14.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "MainViewController.h"
#import "./VC/UITableVIew/XXtableViewShellVC.h"
#import "../../XXkit/Object-C/TableView/XXtableViewShell.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XXtableViewShell *shell;

@property (nonatomic,copy) void(^onTableViewRowClicked)(NSIndexPath *indexPath, id data);
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


- (void (^)(NSIndexPath *, id))onTableViewRowClicked{
    if(!_onTableViewRowClicked){
        _onTableViewRowClicked = ^(NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
            XXtableViewShellVC *
        }
    }
    return _onTableViewRowClicked;
}

@end
