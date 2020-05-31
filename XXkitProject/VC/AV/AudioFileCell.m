//
//  AudioFileCell.m
//  XXkitProject
//
//  Created by 郭文轩 on 2020/5/9.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "AudioFileCell.h"
#import "../../../../XXkit/Object-C/Shell/XXtableViewShell.h"
#import "../../../CoreData/AudioFile+CoreDataProperties.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"

@interface AudioFileCell()<XXtableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UILabel *starttime;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UISlider *progress;

@end

@implementation AudioFileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@synthesize indexPath;
@synthesize tableViewShell;
- (void)resetData:(nonnull id)data {
    AudioFile *info = data;
    _name.text = info.name;
    _duration.text = [XXocUtils timeStringWithSecond:info.duration timeFormat:@"mm:ss"];
}
@end
