//
//  YZRecordViewController.m
//  音频
//
//  Created by lilida on 2017/8/9.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZRecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YZAudioTool.h"

@interface YZRecordViewController ()

@property (strong, nonatomic) AVAudioRecorder *recorder;

- (IBAction)startRecord:(id)sender;
- (IBAction)stopRecord:(id)sender;
- (IBAction)startPlayRecord:(id)sender;

@end

@implementation YZRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)startRecord:(id)sender {
    
    self.recorder = nil;
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"录音文件.caf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    //音频格式
    setting[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
    //音频采样率
    setting[AVSampleRateKey] = @(8000.0);
    //音频通道数
    setting[AVNumberOfChannelsKey] = @(1);
    //线性音频的位深度
    setting[AVLinearPCMBitDepthKey] = @(8);
    
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:nil];
    
    self.recorder = recorder;
    
    [self.recorder prepareToRecord];
    [self.recorder record];
}

- (IBAction)stopRecord:(id)sender {
    [self.recorder stop];
}

- (IBAction)startPlayRecord:(id)sender {
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"录音文件.caf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    [YZAudioTool playMusicWithURL:url];
    
}
@end
