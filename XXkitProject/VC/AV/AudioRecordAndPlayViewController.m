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

@interface AudioRecordAndPlayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSString *dir;
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
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onButtonTouchUpInside:(id)sender {
    UIButton *button = sender;
    if(button == _startButton){
        if([XXaudioFileRecorder sharedInstance].isRunning){
            [_startButton setBackgroundColor:UIColor.greenColor];
            NSURL *url = [[XXaudioFileRecorder sharedInstance] stop];
            NSLog(@"[AudioRecordAndPlayViewController] 录音停止，文件保存到：%@",url);
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
