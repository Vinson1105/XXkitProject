//
//  TableViewNibCell.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/16.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "TableViewNibCell.h"
#import "../../../../XXkit/Object-C/UITableView/XXtableViewShell.h"

@interface TableViewNibCell() <XXtableViewCell>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (nonatomic,assign) BOOL isDetailShowing;

@property (nonatomic,strong) NSMutableDictionary *data;
@end

@implementation TableViewNibCell
@synthesize tableViewShell, indexPath;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_detailButton setBackgroundColor:UIColor.greenColor];
}
- (void)reset:(id)data{
    _data = data;
    if(_data[@"Title"]) _titleLabel.text = _data[@"Title"];
    if(_data[@"Message"]) _messageLabel.text = _data[@"Message"];
    if(_data[@"IsDetailShowing"] == nil){
        _data[@"IsDetailShowing"] = @(NO);
        self.isDetailShowing = NO;
    }
    else{
        self.isDetailShowing = [_data[@"IsDetailShowing"] boolValue];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setIsDetailShowing:(BOOL)isDetailShowing{
    if(_isDetailShowing == isDetailShowing) return;
    _isDetailShowing        = isDetailShowing;
    _detailButton.selected  = isDetailShowing;
    if(isDetailShowing){
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    else{
        _messageLabel.numberOfLines = 1;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    _data[@"IsDetailShowing"] = @(isDetailShowing);
    [_detailButton setBackgroundColor:isDetailShowing?UIColor.blueColor:UIColor.greenColor];
}

- (IBAction)onButtonTouchUpInside:(id)sender {
    self.isDetailShowing = !self.isDetailShowing;
    [self.tableViewShell.target reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
