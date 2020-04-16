//
//  TableViewNibCell.m
//  XXkitProject
//
//  Created by VINSON on 2020/4/16.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "TableViewNibCell.h"

@interface TableViewNibCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@end

@implementation TableViewNibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)reset:(id)data{
    NSDictionary *dict = data;
    if(dict[@"Title"]) _titleLabel.text = dict[@"Title"];
    if(dict[@"Message"]) _messageLabel.text = dict[@"Message"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onButtonTouchUpInside:(id)sender {
    UIButton *button = sender;
    button.selected = !button.selected;
    [_detailButton setBackgroundColor:button.selected?UIColor.grayColor:UIColor.whiteColor];
    if(button.selected){
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    else{
        _messageLabel.numberOfLines = 1;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
}
@end
