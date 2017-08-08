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
    
    //设置音频会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [session setMode:AVAudioSessionCategorySoloAmbient error:nil];//这个好像不管用了
    [session setActive:YES error:nil];
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


/************************************************************/


+ (AVAudioPlayer *)playMusic:(NSString *)filename
{
    if(!filename) return nil;
    
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    
    if(!audioPlayer)
    {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if(!url) return nil;
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        [audioPlayer prepareToPlay];
        
        _audioPlayerDict[filename] = audioPlayer;
    }
    
    if(!audioPlayer.isPlaying){
        [audioPlayer play];
    }
    return audioPlayer;
}

+ (void)pauseMusic:(NSString *)filename
{
    if(!filename) return;
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
    if(audioPlayer.isPlaying)
    {
        [audioPlayer pause];
    }
}

+ (void)stopMusic:(NSString *)filename
{
    if(!filename) return;
    AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
//    if(audioPlayer)
    if(audioPlayer.isPlaying)
    {
        [audioPlayer stop];
        
        [_audioPlayerDict removeObjectForKey:filename];
    }
}

+ (AVAudioPlayer *)currentPlayingAudioPlayer
{
    //遍历字典数组
    for (NSString *filename in _audioPlayerDict) {
        AVAudioPlayer *audioPlayer = _audioPlayerDict[filename];
        if(audioPlayer.isPlaying)
        {
            return audioPlayer;
        }
    }
    
    return nil;
}

@end
