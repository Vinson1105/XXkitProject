//
//  LangaugeViewController.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/6/3.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "LangaugeViewController.h"
#import "../../../../XXkit/Object-C/Category/NSBundle+Language.h"
#import "../../../../XXkit/Object-C/Shell/XXtableViewShell.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"

@interface LangaugeViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XXtableViewShell *tableShell;
@property (nonatomic,copy) NSIndexPath *indexPath;
@end

@implementation LangaugeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *currentLanguage   = [NSBundle xx_currentLanguage];
    NSMutableArray *available   = [[NSMutableArray alloc] initWithArray:[NSBundle xx_avaliableLanguages]];
    [available insertObject:@"system" atIndex:0];
    
    _tableShell = [XXtableViewShell new];
    [_tableShell shell:_tableView];
    [_tableShell configRowType:nil loadType:0 systemStyle:UITableViewCellStyleDefault height:57];
    
    NSMutableArray *row = [NSMutableArray new];
    for (NSString *language in available) {
        BOOL isUsing = (nil != currentLanguage && [currentLanguage isEqualToString:language]) || (nil == currentLanguage && [language isEqualToString:@"system"]);
        NSMutableDictionary *rowInfo = [[NSMutableDictionary alloc] initWithDictionary:@{
            @"Title":NSLocalizedString(([NSString stringWithFormat:@"language.%@",language]), nil),
            @"Language":language,
            @"AccessoryType":isUsing?@(UITableViewCellAccessoryCheckmark):@(UITableViewCellAccessoryNone)
        }];
        [row addObject:rowInfo];
        
        if(isUsing){
            _indexPath = [NSIndexPath indexPathForRow:row.count-1 inSection:0];
        }
    }
    
    [_tableShell configSectionWithHeaders:nil rows:@[row] footers:nil];
    XXOC_WS;
    _tableShell.onRowClicked = ^(XXtableViewShell * _Nonnull shell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        XXOC_SS;
        
        /// 清除之前的状态
        NSIndexPath *lastIndexPath = ss.indexPath;
        NSMutableDictionary *info = [shell getDataAtIndexPath:lastIndexPath];
        if(nil != info){
            info[@"AccessoryType"] = @(UITableViewCellAccessoryNone);
        }
        
        /// 设置当前选中状态
        info = data;
        if(nil != info){
            info[@"AccessoryType"] = @(UITableViewCellAccessoryCheckmark);
            ss.indexPath = indexPath;
        }
        
        /// 更新状态
        [shell.tableView reloadRowsAtIndexPaths:@[indexPath,lastIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        /// 设置
        NSString *language = info[@"Language"];
        BOOL isSystem = [language isEqualToString:@"system"];
        [NSBundle xx_setLanguage:isSystem?nil:language];
        
        /// 退出APP
        UIAlertController *alert =  [XXocUtils alertWithTitle:@""
                                                          msg:@"需要重启APP才生效"
                                                      okTitle:@"好的"
                                                         onOK:^(UIAlertAction *action){exit(0);}
                                                               cancelTitle:nil
                                                               onCancel:nil];
        [ss presentViewController:alert animated:YES completion:nil];
    };
}
@end
