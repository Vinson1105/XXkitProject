//
//  XXtableViewShellVC.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/10.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXtableViewShellVC.h"
#import "../../../../XXkit/Object-C/Shell/XXtableViewShell.h"

#define kDefaultRowButtonID 0
#define kNibRowButtonID 1
#define kCodeRowButtonID 2

@interface XXtableViewShellVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *rowTypeDefaultButton;
@property (weak, nonatomic) IBOutlet UIButton *rowTypeNibButton;
@property (weak, nonatomic) IBOutlet UIButton *rowTypeCodeButton;

@property (nonatomic,strong) XXtableViewShell *defaultRowShell;
@property (nonatomic,strong) XXtableViewShell *nibRowShell;
@property (nonatomic,strong) XXtableViewShell *codeRowShell;

@property (nonatomic,strong) NSMutableArray *headers;
@property (nonatomic,strong) NSMutableArray *rows;
@property (nonatomic,strong) NSMutableArray *footers;
@end

@implementation XXtableViewShellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *buttons = @[_rowTypeDefaultButton,_rowTypeNibButton,_rowTypeCodeButton];
    UIButton *button = nil;
    for (int index = 0; index < 3; index++) {
        button = buttons[index];
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [button setTitleColor:UIColor.redColor forState:UIControlStateSelected];
        [button setTag:index];
    }
    
    _headers    = [NSMutableArray new];
    _rows       = [NSMutableArray new];
    _footers    = [NSMutableArray new];
    
    int sectionCount    = 5;
    int rowCount        = 20;
    
    for (int sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
        NSMutableArray *row = [NSMutableArray new];
        for (int rowIndex = 0; rowIndex < rowCount; rowIndex++) {
            [row addObject:[[NSMutableDictionary alloc] initWithDictionary:@{
                @"Title":[NSString stringWithFormat:@"[Title (%d-%d)]",sectionIndex,rowIndex],
                @"Message":@"[Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message]",
                @"IsDetailShowing":@(NO)
            }]];
        }
        
        [_headers addObject:[[NSMutableDictionary alloc] initWithDictionary:@{
            @"Title":[NSString stringWithFormat:@"[Header %d] Header Header Header Header Header Header Header Header Header Header Header",sectionIndex],
            @"Open":@(NO),
//            @"Height":@(50)
        }]];
        [_footers addObject:[NSString stringWithFormat:@"[Footer %d]",sectionIndex]];
        [_rows addObject:row];
    }
}
- (IBAction)onButtonTouchUpInside:(id)sender {
    UIButton *button = sender;
    if(button.isSelected){
        return;
    }
    
    _rowTypeDefaultButton.selected  = NO;
    _rowTypeNibButton.selected      = NO;
    _rowTypeCodeButton.selected     = NO;
    
    _defaultRowShell    = nil;
    _nibRowShell        = nil;
    _codeRowShell       = nil;
    
    button.selected = YES;
    int tag = (int)button.tag;
    switch (tag) {
        case kDefaultRowButtonID:{
             _defaultRowShell = [XXtableViewShell new];
            [_defaultRowShell shell:_tableView];
            [_defaultRowShell configSectionRowSystemStyle:UITableViewCellStyleDefault height:0];
            [_defaultRowShell configSectionHeaders:_headers rows:_rows footers:_footers];
            break;
        }
        case kNibRowButtonID:{
            _nibRowShell = [XXtableViewShell new];
            [_nibRowShell shell:_tableView];
            [_nibRowShell configSectionRowClass:@"TableViewNibCell" loadType:XXtableViewShellLoadTypeNib height:-1];
            [_nibRowShell configSectionHeaders:_headers rows:_rows footers:_footers];
            _nibRowShell.onSectionRowClicked = ^(XXtableViewShell * _Nonnull shell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
                NSMutableDictionary *dict = data;
                BOOL curr = [dict[@"IsDetailShowing"] boolValue];
                dict[@"IsDetailShowing"] = @(!curr);
                [shell setSectionRow:dict atIndexPath:indexPath];
            };
            break;
        }
        case kCodeRowButtonID:{
            _codeRowShell = [XXtableViewShell new];
            [_codeRowShell shell:_tableView];
            [_codeRowShell configSectionRowClass:@"TableViewCodeCell" loadType:XXtableViewShellLoadTypeCode height:-1];
            [_codeRowShell configSectionHeaderClass:@"TableViewCodeHeaderFooter" loadType:XXtableViewShellLoadTypeCode height:-1];
            [_codeRowShell configSectionHeaders:_headers rows:_rows footers:_footers];
            _codeRowShell.onSectionRowClicked = ^(XXtableViewShell * _Nonnull shell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
                NSMutableDictionary *dict = data;
                BOOL curr = [dict[@"IsDetailShowing"] boolValue];
                dict[@"IsDetailShowing"] = @(!curr);
                [shell setSectionRow:dict atIndexPath:indexPath];
            };
            break;
        }
        default:
            break;
    }
}
@end
