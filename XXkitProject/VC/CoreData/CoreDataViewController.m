//
//  CoreDataViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/13.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "CoreDataViewController.h"
#import "../../../../XXkit/Object-C/Utility/XXcoreData.h"
#import "../../CoreData/Person+CoreDataClass.h"
#import "../../CoreData/Person+CoreDataProperties.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"

#import "../../../../XXkit/Object-C/UITableView/XXtableViewShell.h"

@interface CoreDataViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property (nonatomic,strong) XXtableViewShell *tableViewShell;
@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [[XXocUtils documentAbsolutePathUrl] URLByAppendingPathComponent:[NSString stringWithFormat:@"xx.sqlite"]];
    [[XXcoreData sharedInstance] configModel:@"XXcoreModel" bundle:nil storeType:NSSQLiteStoreType storeUrl:url];
}


- (IBAction)onButtonTouchUpInside:(id)sender {
    if(sender == _addButton){
        [[XXcoreData sharedInstance] insertObject:@"Person" initHandle:^(id  _Nonnull obj) {
            Person *person = obj;
            person.name = @"111";
        } error:nil];
    }
    else if(sender == _delButton){
    }
    else{
        
    }
}

@end
