//
//  YZMusic.h
//  音频
//
//  Created by lilida on 2017/8/7.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZMusic : NSObject

/**
 音乐的名字
 */
@property (copy, nonatomic) NSString *name;

/**
 音乐文件名字，即文件的命名，而不是音乐的名字
 */
@property (copy, nonatomic) NSString *filename;

/**
 歌手名字
 */
@property (copy, nonatomic) NSString *singer;

/**
 歌手的头像
 */
@property (copy, nonatomic) NSString *singerIcon;

/**
 歌曲的图片
 */
@property (copy, nonatomic) NSString *icon;

/**
 歌曲的歌词
 */
@property (copy, nonatomic) NSString *lrcname;

@property (assign, nonatomic, getter=isPlaying) BOOL playing;
@end
