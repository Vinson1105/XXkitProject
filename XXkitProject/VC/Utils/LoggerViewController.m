//
//  LoggerViewController.m
//  XXkitProject
//
//  Created by VINSON on 2020/11/24.
//  Copyright © 2020 郭文轩. All rights reserved.
//

#import "LoggerViewController.h"
#import "../../../../XXkit/Objective-C/XXocUtils.h"
#import "../../../../XXkit/Objective-C/Utility/XXlogger.h"
#import "../../../../XXkit/Objective-C/Utility/XXtimer.h"
#import "../../../../XXkit/Objective-C/Utility/DailyLogFileFifo.h"

#import "../../../../XXkit/Objective-C/Utility/NetworkFifo.h"

@interface LoggerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *intervalLabel;
@property (weak, nonatomic) IBOutlet UISlider *intervalSlider;
@property (weak, nonatomic) IBOutlet UIButton *startOrStopButton;

@property (nonatomic,assign) BOOL running;
@property (nonatomic,assign) CGFloat interval;
@end

@implementation LoggerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [XXocUtils button:self.startOrStopButton norTxt:@"开始" selTxt:@"停止"];
    self.intervalSlider.minimumValue = 0.05;
    self.intervalSlider.maximumValue = 2.0;
    self.intervalSlider.value = 0.5;
    self.intervalLabel.text = [NSString stringWithFormat:@"%.2f",self.intervalSlider.value];
    self.interval = self.intervalSlider.value;
    
    [XXlogger setFifoEnable:NO forName:@"XXlogger"];
    [XXlogger configFifoClassString:@"NetworkFifo" param:@{@"host":@"192.168.1.105",@"port":@(23333),@"way":@"tcp"} forName:@"Network"];
}
- (void)dealloc{
    self.running = NO;
}
- (IBAction)onIntervalSliderValueChanged:(id)sender {
    CGFloat interval = self.intervalSlider.value;
    self.intervalLabel.text = [NSString stringWithFormat:@"%.2f",interval];
    self.interval = interval;
}
- (IBAction)onStartOrStopButtonClicked:(id)sender {
    if(self.startOrStopButton.isSelected){
        self.startOrStopButton.selected = NO;
        self.running = NO;
    }
    else{
        self.startOrStopButton.selected = YES;
        self.running = YES;
        [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
    }
}

-(void)run{
    static NSUInteger index = 0;
    while (self.running) {
        ++index;
        [XXlogger message:@"%d",index];
        [NSThread sleepForTimeInterval:self.interval];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
