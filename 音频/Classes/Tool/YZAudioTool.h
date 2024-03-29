//
//  YZAudioTool.h
//  音频
//
//  Created by lilida on 2017/8/7.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AVAudioPlayer;

@interface YZAudioTool : NSObject


/**
 播放音效
 */
+ (void)playSound:(NSString *)filename;


/**
 销毁音效
 @param filename 音效文件名
 */
+ (void)disposeSound:(NSString *)filename;

/************************************************************/

/**
 播放音乐

 @param filename 音乐文件名
 */
+ (AVAudioPlayer *)playMusic:(NSString *)filename;

+ (AVAudioPlayer *)playMusicWithURL:(NSURL *)url;


/**
 暂停音乐

 @param filename 音乐文件名
 */
+ (void)pauseMusic:(NSString *)filename;


/**
 销毁音乐

 @param filename 音乐文件名
 */
+ (void)stopMusic:(NSString *)filename;


/**
 当前正在播放的歌
 */
+ (AVAudioPlayer *)currentPlayingAudioPlayer;

@end
