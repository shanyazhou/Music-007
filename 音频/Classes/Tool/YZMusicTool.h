//
//  YZMusicTool.h
//  音频
//
//  Created by lilida on 2017/8/14.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YZMusic;

@interface YZMusicTool : NSObject
/**
    返回歌曲列表
 */
+ (NSArray *)musics;

/**
    如何才能知道当前正在播放的哪一首音乐呢？
    需要别人调你的一个方法，把当前正在的音乐传给你，然后你保存，就可以在下面的方法中使用了
 */
+ (void)setPlayingMusic:(YZMusic *)playingMusic;

/**
 返回当前正在播放的歌曲
 */
+ (YZMusic *)playingMusic;

/**
 返回下一个播放的歌曲
 */
+ (YZMusic *)nextMusic;

/**
 返回上一个播放的歌曲
 */
+ (YZMusic *)previousMusic;

@end
