//
//  TableViewCodeHeaderFooter.m
//  XXkitProject
//
//  Created by VINSON on 2020/7/30.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "TableViewCodeHeaderFooter.h"
#import "../../../../XXkit/Objective-C/Shell/XXtableViewShell.h"
#import "../../../../XXkit/Objective-C/XXocUtils.h"
#import "../../../../XXkit/Objective-C/Category/UIButton+StateSettings.h"
#import "../../../../XXkit/Objective-C/Shell/XXviewBase.h"

@interface TableViewCodeHeaderFooter()<XXviewBase>
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *openButton;
@property (nonatomic,strong) NSMutableDictionary *dictData;
@property (nonatomic,strong) NSLayoutConstraint *titleHeightConstraint;
@end

@implementation TableViewCodeHeaderFooter
@synthesize indexPath,onDataPost,onEventOccured;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        [self setup:self.contentView];
        [self setupLayout:self.contentView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"[GWX] layoutSubviews");
}
- (void)setup:(UIView*)superview{
    _titleLabel = [UILabel new];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:_titleLabel];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    _openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _openButton.translatesAutoresizingMaskIntoConstraints = NO;
    [superview addSubview:_openButton];
    [self.openButton setBackgroundColor:UIColor.grayColor forState:UIControlStateNormal];
    [self.openButton setBackgroundColor:UIColor.greenColor forState:UIControlStateSelected];
    [XXocUtils view:self.openButton size:CGSizeMake(43, 43)];
    [self.openButton addTarget:self action:@selector(onButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    superview.backgroundColor = [XXocUtils colorFromHexString:@"#2f2f2f"];
}
- (void)setupLayout:(UIView*)superview{
    [self.titleLabel.leadingAnchor constraintEqualToAnchor:superview.leadingAnchor constant:10].active = YES;
    [self.titleLabel.topAnchor constraintEqualToAnchor:superview.topAnchor constant:10].active = YES;
    [self.titleLabel.bottomAnchor constraintEqualToAnchor:superview.bottomAnchor constant:-10].active = YES;
    
    [XXocUtils view:self.openButton containsRight:-10 centerYAt:superview];
    [self.openButton.leadingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:10].active = YES;
}

- (void)onButtonTouchUpInside:(UIButton*)sender{
    if(sender == self.openButton){
        BOOL isOpen = !self.openButton.selected;
        
        NSString *title = isOpen ?
        @"title title title title title title title title title title title title title title title title title title title title title title title title title title title":
        @"TITLE TITLE TITLE TITLE TITLE TITLE TITLE TITLE TITLE TITLE TITLE TITLE ";
        self.titleLabel.textColor = isOpen ? UIColor.greenColor : UIColor.redColor;
        self.titleLabel.text = title;
        
        _dictData[@"Open"] = @(isOpen);
        _dictData[@"Title"] = title;
        
        [self.contentView setNeedsLayout];
        [self setNeedsLayout];
        [self setNeedsDisplay];
        self.onDataPost(self, self.dictData);
    }
}
- (void)resetData:(nonnull id)data {
    if([data isKindOfClass:[NSDictionary class]]){
        _dictData = data;
        self.titleLabel.text = nil!=_dictData[@"Title"] ? _dictData[@"Title"] : @"Unknown";
        self.openButton.selected = nil!=_dictData[@"Open"] ? [_dictData[@"Open"] boolValue] : NO;
    }
}
- (void)performTask:(NSString *)task info:(id)info{
    NSLog(@"[TableViewCodeHeaderFooter] [performTask] event:%@ info:%@", task, info);
}
@end
