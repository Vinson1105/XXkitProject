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

#import "../../../../XXkit/Object-C/Shell/XXtableViewShell.h"
#import "../../../../XXkit/Object-C/Utility/XXcoreData.h"
#import "../../../CoreData/AudioFile+CoreDataProperties.h"
#import "../../../../XXkit/Object-C/XXocUtils.h"

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

@end
