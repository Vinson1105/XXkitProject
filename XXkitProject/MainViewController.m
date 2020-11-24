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

#import "./VC/Shell/XXtableViewShellVC.h"
#import "./VC/Shell/XXstackViewShellVC.h"
#import "./VC/Shell/XXtextFieldShellVC.h"
#import "./VC/Shell/WebViewProgressViewController.h"
#import "./VC/Shell/ExclusiveButtonViewController.h"
#import "./VC/Shell/CycleClickButtonViewController.h"
#import "./VC/Shell/PageShiftButtonViewController.h"

#import "./VC/Category/OrientationViewController.h"
#import "./VC/Category/ZoomableViewController.h"
#import "./VC/Category/PopupableViewController.h"
#import "./VC/Category/LangaugeViewController.h"

#import "./VC/AV/AudioRecordAndPlayViewController.h"
#import "./VC/AV/VideoRecordViewController.h"

#import "./VC/View/ToastViewController.h"
#import "./VC/View/MaskViewViewController.h"

#import "./VC/Utils/CoreDataViewController.h"
#import "./VC/Utils/TouchIDViewController.h"
#import "./VC/Utils/KeyChainViewController.h"

#import "./VC/Quick/QuickVC1.h"

#define kShellSection       0
#define kCategorySection    1
#define kAVSection          2
#define kViewSection        3
#define kUtilsSection       4
#define kQuickSection       5

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
    NSMutableArray *headers = [[NSMutableArray alloc] initWithArray:@[@"Shell",@"Category",@"AV",@"View",@"Utils",@"Quick"]];
    
    NSMutableArray *rows = [[NSMutableArray alloc] initWithArray:@[
        @[
            @{@"Title":@"XXtableViewShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXstackViewShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXtextFieldShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXwebViewProgressShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXbuttonExclusiveShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXbuttonCycleClickShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXbuttonPageShiftShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXpickerViewShell",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        ],
        @[
            @{@"Title":@"UIViewController+Orientation",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"UIView+Zoomable",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"UIView+TapToPopup",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"NSBundle+Language",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        ],
        @[
            @{@"Title":@"XXaudioFileRecorder",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXvideoRecorder",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        ],
        @[
            @{@"Title":@"XXtoast",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXmaskView",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        ],
        @[
            @{@"Title":@"XXcoreData",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXtouchID",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXkeyChain",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
            @{@"Title":@"XXlogger",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),}
        ],
        @[
            @{@"Title":@"XXquick",@"AccessoryType":@(UITableViewCellAccessoryDisclosureIndicator),},
        ]
    ]];
    
    _shell = [XXtableViewShell new];
    [_shell shell:_tableView];
    [_shell configSectionHeaders:headers rows:rows footers:nil];
    
    _shell.onSectionRowClicked = self.onTableViewRowClicked;
    
    NSURL *url = [[XXocUtils documentAbsolutePathUrl] URLByAppendingPathComponent:[NSString stringWithFormat:@"xx.sqlite"]];
    [[XXcoreData sharedInstance] configModel:@"XXcoreModel" bundle:nil storeType:NSSQLiteStoreType storeUrl:url];
}


- (void (^)(XXtableViewShell*, NSIndexPath *, id))onTableViewRowClicked{
    if(!_onTableViewRowClicked){
        XXOC_WS;
        _onTableViewRowClicked = ^(XXtableViewShell *shell,NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
            UIViewController *vc = nil;
            NSString *title = [data objectForKey:@"Title"];
            if(kShellSection == indexPath.section){
                if([title isEqualToString:@"XXtableViewShell"])             { vc = [XXocUtils viewController:@"XXtableViewShellVC"]; }
                else if([title isEqualToString:@"XXstackViewShell"])        { vc = [XXocUtils viewController:@"XXstackViewShellVC"]; }
                else if([title isEqualToString:@"XXtextFieldShell"])        { vc = [XXocUtils viewController:@"XXtextFieldShellVC"]; }
                else if([title isEqualToString:@"XXwebViewProgressShell"])  { vc = [XXocUtils viewController:@"WebViewProgressViewController"]; }
                else if([title isEqualToString:@"XXbuttonExclusiveShell"])  { vc = [XXocUtils viewController:@"ExclusiveButtonViewController"]; }
                else if([title isEqualToString:@"XXbuttonCycleClickShell"]) { vc = [XXocUtils viewController:@"CycleClickButtonViewController"]; }
                else if([title isEqualToString:@"XXbuttonPageShiftShell"]) { vc = [XXocUtils viewController:@"PageShiftButtonViewController"]; }
                else if([title isEqualToString:@"XXpickerViewShell"]) { vc = [XXocUtils viewController:@"XXpickerViewShellVC"]; }
                else{}
            }
            else if(kCategorySection == indexPath.section){
                if([title isEqualToString:@"UIViewController+Orientation"]) { vc = [XXocUtils viewController:@"OrientationViewController"]; }
                else if([title isEqualToString:@"UIView+Zoomable"])         { vc = [XXocUtils viewController:@"ZoomableViewController"]; }
                else if([title isEqualToString:@"UIView+TapToPopup"])       { vc = [XXocUtils viewController:@"PopupableViewController"]; }
                else if([title isEqualToString:@"NSBundle+Language"])       { vc = [XXocUtils viewController:@"LangaugeViewController"]; }
                else{}
            }
            else if(kAVSection == indexPath.section){
                if([title isEqualToString:@"XXaudioFileRecorder"])          { vc = [XXocUtils viewController:@"AudioRecordAndPlayViewController"]; }
                if([title isEqualToString:@"XXvideoRecorder"])          { vc = [XXocUtils viewController:@"VideoRecordViewController"]; }
                else{}
            }
            else if(kViewSection == indexPath.section){
                if([title isEqualToString:@"XXtoast"])          { vc = [XXocUtils viewController:@"ToastViewController"]; }
                if([title isEqualToString:@"XXmaskView"])          { vc = [XXocUtils viewController:@"MaskViewViewController"]; }
                else{}
            }
            else if(kUtilsSection == indexPath.section){
                if([title isEqualToString:@"XXcoreData"])       { vc = [XXocUtils viewController:@"CoreDataViewController"]; }
                else if([title isEqualToString:@"XXtouchID"])   { vc = [XXocUtils viewController:@"TouchIDViewController"]; }
                else if([title isEqualToString:@"XXkeyChain"])  { vc = [XXocUtils viewController:@"KeyChainViewController"]; }
                else if([title isEqualToString:@"XXlogger"])  { vc = [XXocUtils viewController:@"LoggerViewController"]; }
                else{}
            }
            else if(kQuickSection == indexPath.section){
                if([title isEqualToString:@"XXquick"])       { vc = [XXocUtils viewController:@"QuickViewController"]; }
                else{}
            }
            else{
            }
            
            if(nil == vc) return;
            XXOC_SS;
            [ss.navigationController pushViewController:vc animated:YES];
        };
    }
    return _onTableViewRowClicked;
}

@end
