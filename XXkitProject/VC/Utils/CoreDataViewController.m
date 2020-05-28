//
//  CoreDataViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/13.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "CoreDataViewController.h"
#import "../../../../XXkit/Object-C/Utility/XXcoreData.h"
#import "../../../CoreData/Person+CoreDataClass.h"
#import "../../../CoreData/Person+CoreDataProperties.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"

#import "../../../../XXkit/Object-C/Shell/XXtableViewShell.h"
#import "../../../../XXkit/Object-C/Shell/XXtextFieldShell.h"
#import "../../../../XXkit/Object-C/View/XXtoast.h"

@interface CoreDataViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property (nonatomic,strong) XXtableViewShell *tableViewShell;
@property (nonatomic,strong) XXtextFieldShell *textFieldShell;
@property (nonatomic,assign) BOOL isEditing;
@end

@implementation CoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(onRightItemClicked)];    
    
    _tableViewShell = [XXtableViewShell new];
    [_tableViewShell shell:_tableView];
    [_tableViewShell configRowType:nil loadType:0 systemStyle:UITableViewCellStyleDefault height:0];
    
    NSError *error;
    NSArray *objs = [[XXcoreData sharedInstance] getObject:@"Person" predicate:nil error:&error];
    if(error){
        NSLog(@"[CoreDataViewController] error:%@ (LINE:%d)",error,__LINE__);
    }
    else{
        NSMutableArray *persondata = [NSMutableArray new];
        for (Person *person in objs) {
            NSMutableDictionary *dict = [NSMutableDictionary new];
            dict[@"Title"] = person.name;
            dict[@"Object"] = person;
            [persondata addObject:dict];
        }
        [_tableViewShell addSectionWithHeader:nil row:persondata footer:nil];
        [_tableViewShell configFinished];
    }
    
    XXOC_WS
    _tableViewShell.onRowClicked = ^(XXtableViewShell * _Nonnull shell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        XXOC_SS
        
        NSMutableDictionary *info = data;
        Person *person = info[@"Object"];
        __block UIAlertController *alertController = [XXocUtils alertWithTitle:@"修改"
                                                                   msg:@""
                                                               okTitle:@"好的"
                                                                  onOK:^(UIAlertAction * _Nonnull action) {
            person.name = alertController.textFields.firstObject.text;
            info[@"Title"] = person.name;
            dispatch_async(dispatch_get_main_queue(), ^{
                [ss.tableViewShell resetData:info atIndexPath:indexPath];
            });
        }
                                                           cancelTitle:@"取消"
                                                              onCancel:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = person.name;
        }];
        [ss presentViewController:alertController animated:YES completion:^{
            
        }];
        
    };
    
    _tableViewShell.onRowEditingDelete = ^BOOL(XXtableViewShell * _Nonnull shell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        NSMutableDictionary *info = data;
        Person *person = info[@"Object"];
        [[XXcoreData sharedInstance] deleteObject:person error:nil];
        return YES;
    };
}


- (IBAction)onButtonTouchUpInside:(id)sender {
    if(sender == _addButton){
        XXOC_WS
        __block UIAlertController *alertController = [XXocUtils alertWithTitle:@"新增"
                                                                   msg:@""
                                                               okTitle:@"好的"
                                                                  onOK:^(UIAlertAction * _Nonnull action) {
            [[XXcoreData sharedInstance] insertObject:@"Person" initHandler:^(id  _Nonnull obj) {
                Person *person = obj;
                person.name = alertController.textFields.firstObject.text;
                NSLog(@"[###] 新增 %@",person);
                
                NSMutableDictionary *info = [[NSMutableDictionary alloc] initWithDictionary:@{@"Title":person.name,@"Object":person,}];
                
                XXOC_SS
                [ss.tableViewShell addRow:@[info] atSection:0];
            } error:nil];
        }
                                                           cancelTitle:@"取消"
                                                              onCancel:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = @"Default";
        }];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
    }
    else if(sender == _delButton){
    }
    else{
        
    }
}


- (void)onRightItemClicked{
    _isEditing = !_isEditing;
    _tableView.editing = _isEditing;
    self.navigationItem.rightBarButtonItem.title = _isEditing ? @"取消" : @"编辑";
}
@end
