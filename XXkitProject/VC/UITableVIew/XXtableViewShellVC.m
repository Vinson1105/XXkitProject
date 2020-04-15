//
//  XXtableViewShellVC.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/10.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXtableViewShellVC.h"
#import "../../../../../XXkit/Object-C/TableView/XXtableViewShell.h"
@interface XXtableViewShellVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *rowTypeDefaultButton;
@property (weak, nonatomic) IBOutlet UIButton *rowTypeNibButton;
@property (weak, nonatomic) IBOutlet UIButton *rowTypeCodeButton;

@property (nonatomic,strong) XXtableViewShell *tableViewShell;
@end

@implementation XXtableViewShellVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)onButtonTouchUpInside:(id)sender {
}

@end
