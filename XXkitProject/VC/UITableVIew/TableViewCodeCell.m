//
//  TableViewCodeCell.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/20.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "TableViewCodeCell.h"
#import "../../../../XXkit/Object-C/UITableView/XXtableViewShell.h"

@interface TableViewCodeCell() <XXtableViewCellDelegate>
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIButton *detailButton;
@property (nonatomic,assign) BOOL isDetailShowing;

@property (nonatomic,strong) NSMutableDictionary *data;
@end

@implementation TableViewCodeCell
@synthesize indexPath, tableViewShell;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        _titleLabel = [UILabel new];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_titleLabel];
        
        _messageLabel = [UILabel new];
        _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_messageLabel];
        
        _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _detailButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_detailButton setTitle:@"+" forState:UIControlStateNormal];
        [_detailButton setBackgroundColor:UIColor.greenColor];
        [_detailButton setTitle:@"-" forState:UIControlStateSelected];

        [_detailButton addTarget:self action:@selector(onButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_detailButton];
        
        [_titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
        [_titleLabel.trailingAnchor constraintEqualToAnchor:_messageLabel.leadingAnchor constant:-10].active = YES;
        [_titleLabel.firstBaselineAnchor constraintEqualToAnchor:_messageLabel.firstBaselineAnchor].active = YES;
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [_messageLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
        [_messageLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
        [_messageLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        [_messageLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
        
        [_detailButton.leadingAnchor constraintEqualToAnchor:_messageLabel.trailingAnchor constant:10].active = YES;
        [_detailButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
        [_detailButton.firstBaselineAnchor constraintEqualToAnchor:_messageLabel.firstBaselineAnchor].active = YES;
        [_detailButton.widthAnchor constraintEqualToConstant:30].active = YES;
        [_detailButton.heightAnchor constraintEqualToConstant:30].active = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)resetData:(id)data{
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

- (void)onButtonTouchUpInside:(id)sender {
    self.isDetailShowing = !self.isDetailShowing;
    [self.tableViewShell.target reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
