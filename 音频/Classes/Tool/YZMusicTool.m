//
//  YZMusicTool.m
//  音频
//
//  Created by lilida on 2017/8/14.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZMusicTool.h"
#import "MJExtension.h"
#import "YZMusic.h"

@implementation YZMusicTool

static NSArray *_musics;
static YZMusic *_playingMusic;
/**
 返回歌曲列表
 */
+ (NSArray *)musics
{
    if(!_musics)
    {
        _musics = [YZMusic mj_objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

/**
 如何才能知道当前正在播放的哪一首音乐呢？
 需要别人调你的一个方法，把当前正在的音乐传给你，然后你保存，就可以在下面的方法中使用了
 */
+ (void)setPlayingMusic:(YZMusic *)playingMusic
{
    //如果传的playingMusic不存在，返回
    //如果传的playingMusic不在音乐列表里面，也返回
    if(!playingMusic || ![[self musics] containsObject:playingMusic]) return;
    
    _playingMusic = playingMusic;
}

/**
 返回当前正在播放的歌曲
 */
+ (YZMusic *)playingMusic
{
    return _playingMusic;
}

/**
 返回下一个播放的歌曲
 */
+ (YZMusic *)nextMusic
{
    NSInteger next = 0;//首先，假设下一首播放的歌曲序号为0
    if(_playingMusic)//必须判断一下，不然如果为空，则里面数组找不到
    {
        NSInteger current = [[self musics] indexOfObject:_playingMusic];//通过当前正在播放的歌曲，找到真正的序号
        next = current + 1;//下一首的序号为当前序号+1
        if(next >= [self musics].count)//如果下一首序号超过数据，则为0
        {
            next = 0;
        }
    }
    return [self musics][next];
}

/**
 返回上一个播放的歌曲
 */
+ (YZMusic *)previousMusic
{
    NSInteger previous = 0;//首先，假设下一首播放的歌曲序号为0
    if(_playingMusic)
    {
        NSInteger current = [[self musics] indexOfObject:[self playingMusic]];//通过当前正在播放的歌曲，找到真正的序号
        previous = current - 1;//上一首的序号为当前序号-1
        if(previous < 0)//如果上一首序号为-1，则为最后一个
        {
            previous = [self musics].count - 1;
        }
    }
    
    return [self musics][previous];
}
@end
