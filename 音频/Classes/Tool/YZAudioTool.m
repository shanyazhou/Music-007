//
//  YZAudioTool.m
//  音频
//
//  Created by lilida on 2017/8/7.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZAudioTool.h"
#import <AVFoundation/AVFoundation.h>

//@class YZAudioTool;

//@interface YZAudioTool()
//@property (nonatomic, assign) SystemSoundID soundID;
//类方法不可以访问成员变量
//@property (nonatomic, strong) NSDictionary * dict;
//@end


@implementation YZAudioTool

/**
 创建一个字典，用以存储文件名与soundID的关系
 key:filename   value:soundID
 */
static NSMutableDictionary *_soundIDDict;

/**
    key:filename value:audioPlayer
 */
static NSMutableDictionary *_audioPlayerDict;

+ (void)initialize
{
    _soundIDDict = [NSMutableDictionary dictionary];
    
    _audioPlayerDict = [NSMutableDictionary dictionary];
}

+ (void)playSound:(NSString *)filename
{
    if(!filename) return;//如果filename为空，则返回
    SystemSoundID soundID = [_soundIDDict[filename] unsignedIntValue];
    if(!soundID)
    {
        NSURL * url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if(!url) return;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
        
        //放入字典
        _soundIDDict[filename] = @(soundID);
    }
    
    AudioServicesPlaySystemSound(soundID);
}

+ (void)disposeSound:(NSString *)filename
{
    if(!filename) return;
    SystemSoundID soundID = [_soundIDDict[filename] unsignedIntValue];
    if(soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [_soundIDDict removeObjectForKey:filename];
    }
}


+ (void)playMusic:(NSString *)filename
{
    if(!filename) return;
    
    AVAudioPlayer * audioPlayer = _audioPlayerDict[filename];
    
    if(audioPlayer == nil)
    {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if(!url) return;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _audioPlayerDict[filename] = audioPlayer;
    }
    
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    
}

+ (void)pauseMusic:(NSString *)filename
{
    
}

+ (void)stopMusic:(NSString *)filename
{
    
}


@end
