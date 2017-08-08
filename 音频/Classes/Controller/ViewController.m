//
//  ViewController.m
//  音频
//
//  Created by lilida on 2017/8/7.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "ViewController.h"
#import "YZAudioTool.h"

@interface ViewController ()

//@property (nonatomic, assign) SystemSoundID soundID;

@end

@implementation ViewController

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
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1 加载音效文件（短音频）
    //1个音效文件 对应一个 SoundID
    //2播放
//    AudioServicesPlaySystemSound(self.soundID);
    [YZAudioTool playSound:@"shake_match.wav"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [YZAudioTool disposeSound:@"shake_match.wav"];
}

@end
