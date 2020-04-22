//
//  MainViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/14.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "MainViewController.h"
#import "../../XXkit/Object-C/UITableView/XXtableViewShell.h"
#import "../../XXkit/Object-C/XXocUtility.h"
#import "./VC/UITableVIew/XXtableViewShellVC.h"
#import "./VC/UIStackView/XXstackViewShellVC.h"
#import "./VC/UITextField/XXtextFieldShellVC.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XXtableViewShell *shell;

@property (nonatomic,copy) void(^onTableViewRowClicked)(XXtableViewShell *shell, NSIndexPath *indexPath, id data);
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *row = [[NSMutableArray alloc] initWithArray:@[
        @{@"Title":@"XXtableViewShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        @{@"Title":@"XXstackViewShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        @{@"Title":@"XXtextFieldShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
    ]];
    
    _shell = [XXtableViewShell new];
    [_shell shell:_tableView];
    [_shell configSectionWithHeader:nil row:row footer:nil];
    [_shell configFinished];
    
    _shell.onRowClicked = self.onTableViewRowClicked;
}


- (void (^)(XXtableViewShell*, NSIndexPath *, id))onTableViewRowClicked{
    if(!_onTableViewRowClicked){
        XXOC_WS;
        _onTableViewRowClicked = ^(XXtableViewShell *shell,NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
            XXOC_SS;
            NSString *title = [data objectForKey:@"Title"];
            if([title isEqualToString:@"XXtableViewShell"]){
                XXtableViewShellVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"XXtableViewShellVC"];
                [ss.navigationController pushViewController:vc animated:YES];
            }
            else if([title isEqualToString:@"XXstackViewShell"]){
                XXstackViewShellVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"XXstackViewShellVC"];
                [ss.navigationController pushViewController:vc animated:YES];
            }
            else if([title isEqualToString:@"XXtextFieldShell"]){
                XXtextFieldShellVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"XXtextFieldShellVC"];
                [ss.navigationController pushViewController:vc animated:YES];
            }
            else{
                
            }
        };
    }
    return _onTableViewRowClicked;
}

@end
