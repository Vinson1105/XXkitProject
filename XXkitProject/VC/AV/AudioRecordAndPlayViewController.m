//
//  AudioRecordAndPlayViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/8.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "AudioRecordAndPlayViewController.h"
#import "../../../../XXkit/Object-C/AV/XXaudioPlayer.h"
#import "../../../../XXkit/Object-C/AV/XXaudioFormat.h"
#import "../../../../XXkit/Object-C/AV/XXaudioFileRecorder.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"
#import "../../../../XXkit/Object-C/UITableView/XXtableViewShell.h"

@interface AudioRecordAndPlayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSString *dir;
@property (nonatomic,strong) XXtableViewShell *tableShell;
@end

@implementation AudioRecordAndPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSError *error;
    _dir = [XXocUtils mkdirInDocument:@[@"XXkitProject",@"Audio"] error:&error];
    if(error){
        NSLog(@"[AudioRecordAndPlayViewController] 创建目录失败");
    }
    
    [_startButton setBackgroundColor:UIColor.greenColor];
    
    XXaudioFormat *format = [XXaudioFormat new];
    format.sampleRate = 16000;
    format.channels = 2;
    format.sampleBitSize = 16;
    format.formatID = kAudioFormatMPEG4AAC;
    format.formatFlags = kAudioFormatFlagIsSignedInteger;
    [[XXaudioFileRecorder sharedInstance] config:format];
    
    _tableShell = [XXtableViewShell new];
    [_tableShell shell:_tableView];
    [_tableShell configRowType:@"AudioFileCell" loadType:XXtableViewShellRowLoadTypeNib systemStyle:0 height:0];
}

- (IBAction)onButtonTouchUpInside:(id)sender {
    UIButton *button = sender;
    if(button == _startButton){
        if([XXaudioFileRecorder sharedInstance].isRunning){
            [_startButton setBackgroundColor:UIColor.greenColor];
            NSURL *url = [[XXaudioFileRecorder sharedInstance] stop];
            NSLog(@"[AudioRecordAndPlayViewController] 录音停止，文件保存到：%@",url);
            [_tableShell addRow:@[@{@"url":url,@"filename":[XXocUtils currentDateString]}] atSection:0];
        }
        else{
            NSString *name = [[XXocUtils currentDateString] stringByAppendingString:@".aac"];
            NSString *path = [_dir stringByAppendingPathComponent:name];
            NSURL *url = [NSURL fileURLWithPath:path];
            if([[XXaudioFileRecorder sharedInstance] start:url]){
                NSLog(@"[AudioRecordAndPlayViewController] 开始成功");
                [_startButton setBackgroundColor:UIColor.redColor];
            }
            else{
                NSLog(@"[AudioRecordAndPlayViewController] 开始失败");
            }
        }
    }
    else{
    }
}

@end
