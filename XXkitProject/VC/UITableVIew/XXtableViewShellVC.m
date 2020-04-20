//
//  XXtableViewShellVC.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/10.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "XXtableViewShellVC.h"
#import "../../../../XXkit/Object-C/UITableView/XXtableViewShell.h"

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
    
    NSMutableArray *row = [NSMutableArray new];
    int sectionCount    = 5;
    int rowCount        = 10;
    
    for (int sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
        for (int rowIndex = 0; rowIndex < rowCount; rowIndex++) {
            [row addObject:[[NSMutableDictionary alloc] initWithDictionary:@{
                @"Title":[NSString stringWithFormat:@"[Title %d]",rowIndex],
                @"Message":@"[Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message Message]",
            }]];
        }
        
        [_headers addObject:[NSString stringWithFormat:@"[Header %d]",sectionIndex]];
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
            [_defaultRowShell configRowType:nil loadType:0 systemStyle:UITableViewCellStyleDefault height:0];
            [_defaultRowShell configSectionWithHeaders:_headers rows:_rows footers:_footers];
            break;
        }
        case kNibRowButtonID:{
            _nibRowShell = [XXtableViewShell new];
            [_nibRowShell shell:_tableView];
            [_nibRowShell configRowType:@"TableViewNibCell" loadType:XXtableViewShellRowLoadTypeNib systemStyle:0 height:0];
            [_nibRowShell configSectionWithHeaders:_headers rows:_rows footers:_footers];
            break;
        }
        case kCodeRowButtonID:{
            _codeRowShell = [XXtableViewShell new];
            [_codeRowShell shell:_tableView];
            [_codeRowShell configRowType:@"TableViewCodeCell" loadType:XXtableViewShellRowLoadTypeCode systemStyle:0 height:0];
            [_codeRowShell configSectionWithHeaders:_headers rows:_rows footers:_footers];
            break;
        }
        default:
            break;
    }
}
@end
