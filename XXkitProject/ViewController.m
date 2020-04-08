//
//  ViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/7.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "ViewController.h"
#import "../../XXkit/Object-C/TableView/XXtableViewShell.h"

@interface ViewController ()
@property (nonatomic,strong) XXtableViewShell *tableViewShell;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableViewShell = [XXtableViewShell new];
    [_tableViewShell shell:_tableView];
}


@end
