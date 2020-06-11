//
//  AudioRecordAndPlayViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/5/8.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "AudioRecordAndPlayViewController.h"
#import "../../../../XXkit/Object-C/AV/XXaudioPlayer.h"
#import "../../../../XXkit/Object-C/AV/XXavFormat.h"
#import "../../../../XXkit/Object-C/AV/XXaudioFileRecorder.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"

#import "../../../../XXkit/Object-C/Shell/XXtableViewShell.h"
#import "../../../../XXkit/Object-C/Utility/XXcoreData.h"
#import "../../../CoreData/AudioFile+CoreDataProperties.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"
#import "../../../../XXkit/Object-C/AV/XXaudioFilePlayer.h"

@interface AudioRecordAndPlayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSString *dir;
@property (nonatomic,strong) XXtableViewShell *tableShell;

@property (nonatomic,strong) XXaudioFilePlayer *player;
@property (nonatomic,assign) int currentPlaying;
@end

@implementation AudioRecordAndPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentPlaying = -1;
    
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
    _tableShell.onRowEditingDelete = ^BOOL(XXtableViewShell * _Nonnull shell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        AudioFile *audioFile = data;
        [[XXcoreData sharedInstance] deleteObject:audioFile error:nil];
        return YES;
    };
    
    XXOC_WS;
    _tableShell.onRowClicked = ^(XXtableViewShell * _Nonnull shell, NSIndexPath * _Nonnull indexPath, id  _Nonnull data) {
        XXOC_SS;
                
        if(ss.player && ss.player.isPlaying){
            [ss.player stop];
        }
        
        AudioFile *audioFile = data;
        NSString *absulotePath = [[XXocUtils documentAbsolutePathString] stringByAppendingString:audioFile.path];
        
        NSError *error = nil;
        ss.player = [[XXaudioFilePlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:absulotePath] error:&error];
        if(error){
            NSLog(@"[###] 创建失败 %@", error);
        }
        
        ss.player.onFinished = ^(XXaudioFilePlayer * _Nonnull player, BOOL succeed) {
            NSLog(@"[###] 播放完成(%d)", succeed);
        };
        ss.player.onDecodeError = ^(XXaudioFilePlayer * _Nonnull player, NSError * _Nonnull error) {
            NSLog(@"[###] 解码出错 %@", error);
        };
        ss.player.onProgressUpdate = ^(XXaudioFilePlayer * _Nonnull player) {
            NSLog(@"[###] 进度：%.3f %.3f", player.currentTime, player.duration);
            [ws.tableShell rowDoSomething:@"progress" info:@(player.currentTime/player.duration) atIndex:indexPath];
        };
        if(![ss.player play]){
            NSLog(@"[###] 播放失败");
        }
    };
    
    NSArray *audioFiles = [[XXcoreData sharedInstance] getObject:@"AudioFile" predicate:nil error:nil];
    if(nil != audioFiles){
        [_tableShell addRow:audioFiles atSection:0];
    }
}

- (IBAction)onButtonTouchUpInside:(id)sender {
    UIButton *button = sender;
    if(button == _startButton){       
        if([XXaudioFileRecorder sharedInstance].isRunning){
            [_startButton setBackgroundColor:UIColor.greenColor];
            NSURL *url = [[XXaudioFileRecorder sharedInstance] stop];
            if(nil == url){
                NSLog(@"[AudioRecordAndPlayViewController] 录音失败");
                return;
            }


            NSString *docPath   = [XXocUtils documentAbsolutePathString];
            NSString *filePath  = url.relativePath;
            NSRange range       = [filePath rangeOfString:docPath];
            NSString *relaPath  = [filePath substringFromIndex:range.length];

            XXOC_WS
            __block UIAlertController *alert = [XXocUtils alertWithTitle:@"" msg:@"" okTitle:@"好的" onOK:^(UIAlertAction * _Nonnull action) {
                XXOC_SS
                [[XXcoreData sharedInstance] insertObject:@"AudioFile" initHandler:^(id  _Nonnull obj) {
                    AudioFile *audioFile = obj;
                    audioFile.path = relaPath;
                    audioFile.name = alert.textFields.firstObject.text;
                    audioFile.duration = [XXocUtils audioDuration:url];
                    [ss.tableShell addRow:@[audioFile] atSection:0];
                } error:nil];
            } cancelTitle:@"取消" onCancel:^(UIAlertAction * _Nonnull action) {
                [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
            }];
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.text = [XXocUtils currentDateString];
            }];
            [self presentViewController:alert animated:YES completion:nil];
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


- (void)playAtIndex:(int)index{
    if(_currentPlaying){
        
    }
}
- (void)stop{
    if(_currentPlaying < 0){
        return;
    }
    
}

@end
