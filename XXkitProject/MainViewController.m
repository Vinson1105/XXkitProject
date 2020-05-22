//
//  MainViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/4/14.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "MainViewController.h"
#import "../../XXkit/Object-C/Utility/XXcoreData.h"

#import "../../XXkit/Object-C/Shell/XXtableViewShell.h"
#import "../../XXkit/Object-C/XXocUtils.h"

#import "./VC/UITableVIew/XXtableViewShellVC.h"
#import "./VC/UIStackView/XXstackViewShellVC.h"
#import "./VC/UITextField/XXtextFieldShellVC.h"

#import "./VC/Category/OrientationViewController.h"
#import "./VC/Category/ZoomableViewController.h"

#import "./VC/AV/AudioRecordAndPlayViewController.h"

#import "./VC/Utils/CoreDataViewController.h"
#import "./VC/Utils/TouchIDViewController.h"
#import "./VC/Utils/KeyChainViewController.h"
#import "./VC/Utils/ToastViewController.h"

#define kShellSection 0
#define kCategorySection 1
#define kAVSection 2
#define kCoreDataSection 3

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XXtableViewShell *shell;

@property (nonatomic,copy) void(^onTableViewRowClicked)(XXtableViewShell *shell, NSIndexPath *indexPath, id data);
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"[MainViewController] alloc %p", self);
    
    // Do any additional setup after loading the view.
    NSMutableArray *headers = [[NSMutableArray alloc] initWithArray:@[@"Shell",@"Category",@"AV",@"Utils"]];
    
    NSMutableArray *rows = [[NSMutableArray alloc] initWithArray:@[
        @[
            @{@"Title":@"XXtableViewShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXstackViewShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXtextFieldShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),}
        ],
        @[
            @{@"Title":@"UIViewController+Orientation",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"UIView+Zoomable",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        ],
        @[
            @{@"Title":@"XXaudioFileRecorder",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        ],
        @[
            @{@"Title":@"CoreData",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"TouchID",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"KeyChain",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"Toast",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        ],
    ]];
    
    _shell = [XXtableViewShell new];
    [_shell shell:_tableView];
    [_shell configSectionWithHeaders:headers rows:rows footers:nil];
    
    _shell.onRowClicked = self.onTableViewRowClicked;
    
    NSURL *url = [[XXocUtils documentAbsolutePathUrl] URLByAppendingPathComponent:[NSString stringWithFormat:@"xx.sqlite"]];
    [[XXcoreData sharedInstance] configModel:@"XXcoreModel" bundle:nil storeType:NSSQLiteStoreType storeUrl:url];}


- (void (^)(XXtableViewShell*, NSIndexPath *, id))onTableViewRowClicked{
    if(!_onTableViewRowClicked){
        XXOC_WS;
        _onTableViewRowClicked = ^(XXtableViewShell *shell,NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
            XXOC_SS;
            NSString *title = [data objectForKey:@"Title"];
            if(kShellSection == indexPath.section){
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
            }
            else if(kCategorySection == indexPath.section){
                if([title isEqualToString:@"OrientationViewController"]){
                    OrientationViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrientationViewController"];
                    [ss.navigationController pushViewController:vc animated:YES];
                }
                else if([title isEqualToString:@"UIView+Zoomable"]){
                    ZoomableViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ZoomableViewController"];
                    [ss.navigationController pushViewController:vc animated:YES];
                }
                else{
                    
                }
            }
            else if(kAVSection == indexPath.section){
                if([title isEqualToString:@"XXaudioFileRecorder"]){
                    AudioRecordAndPlayViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AudioRecordAndPlayViewController"];
                    [ss.navigationController pushViewController:vc animated:YES];
                }
                else{
                    
                }
            }
            else if(kCoreDataSection == indexPath.section){
                UIViewController *vc = nil;
                if([title isEqualToString:@"CoreData"]){
                    vc = [XXocUtils viewController:@"CoreDataViewController"];
                }
                else if([title isEqualToString:@"TouchID"]){
                    vc = [XXocUtils viewController:@"TouchIDViewController"];
                }
                else if([title isEqualToString:@"KeyChain"]){
                    vc = [XXocUtils viewController:@"KeyChainViewController"];
                }
                else if([title isEqualToString:@"Toast"]){
                    vc = [XXocUtils viewController:@"ToastViewController"];
                }
                else{
                    return;
                }
                [ss.navigationController pushViewController:vc animated:YES];
            }
            else{
                
            }
        };
    }
    return _onTableViewRowClicked;
}

@end
