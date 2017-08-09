//
//  YZViewController.m
//  音频
//
//  Created by lilida on 2017/8/7.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZViewController.h"
#import "YZAudioTool.h"

@interface YZViewController ()
//@property (nonatomic, assign) SystemSoundID soundID;
- (IBAction)soundClick:(id)sender;
@property (strong, nonatomic) NSArray *soundArray;

@end

@implementation YZViewController

- (IBAction)soundClick:(id)sender {
    //1 加载音效文件（短音频）
    //1个音效文件 对应一个 SoundID
    //2播放
    //    AudioServicesPlaySystemSound(self.soundID);
    
    NSString *soundName = self.soundArray[arc4random() % 3];
    
    [YZAudioTool playSound:soundName];
}

- (NSArray *)soundArray
{
    if(!_soundArray)
    {
        return _soundArray = [NSArray arrayWithObjects:@"Click Pop (Medium 1).wav", @"shake_match.wav", @"shake_nomatch.wav", @"shake_sound_male.wav", nil];
    }
    return _soundArray;
}

//- (SystemSoundID)soundID
//{
//    if (!_soundID) {
//        NSURL * url = [[NSBundle mainBundle] URLForResource:@"shake_match" withExtension:@"wav"];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &_soundID);
//    }
//    return _soundID;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
//    [YZAudioTool disposeSound:@"shake_match.wav"];
}

@end
