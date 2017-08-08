//
//  YZMusicTableViewController.m
//  音频
//
//  Created by lilida on 2017/8/7.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZMusicTableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "YZMusic.h"
#import "MJExtension.h"
#import "YZAudioTool.h"

@interface YZMusicTableViewController ()<AVAudioPlayerDelegate>
@property (strong, nonatomic) NSArray *musics;
@property (strong, nonatomic) CADisplayLink *link;
@property (strong, nonatomic) AVAudioPlayer *currentPlayingAudioPlayer;
- (IBAction)jump:(id)sender;
@end

@implementation YZMusicTableViewController

- (NSArray *)musics
{
    if(!_musics)
    {
        _musics = [YZMusic mj_objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

- (CADisplayLink *)link
{
    if(!_link)
    {
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkDoSomething)];
    }
    return _link;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

//一秒钟调用60次
- (void)linkDoSomething
{
    NSLog(@"%f^^^%f",self.currentPlayingAudioPlayer.duration,self.currentPlayingAudioPlayer.currentTime);
    
    //可以在这里调整歌词
}

#pragma mark: tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"music";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    YZMusic *music = self.musics[indexPath.row];
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.singer;
    cell.imageView.image = [UIImage imageNamed:music.singerIcon];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZMusic *music = self.musics[indexPath.row];
    [YZAudioTool stopMusic:music.filename];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //播放音乐，播放的音乐来至模型
    YZMusic *music = self.musics[indexPath.row];
    AVAudioPlayer *audioPlayer = [YZAudioTool playMusic:music.filename];
    audioPlayer.delegate = self;
    
    self.currentPlayingAudioPlayer = audioPlayer;
    
    //开启定时器，监听音乐播放进度，以及正在播放的音乐的其他信息
    [self.link invalidate];
    self.link = nil;
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    //显示锁屏信息
    [self showLockMusicInfo:music];
}

- (void)showLockMusicInfo:(YZMusic *)music
{
    //如果有这个类，则走下面的方法，如果没有这个类，不走。
    if(NSClassFromString(@"MPNowPlayingInfoCenter"))
    {
        //在锁屏界面显示歌词图片等信息
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        
        //歌名
        //    info[MPMediaItemPropertyTitle] = music.name;
        info[@"title"] = music.name;//与上面等价
        
        //歌手
        info[MPMediaItemPropertyArtist] = music.singer;
        
        //专辑名字
        info[MPMediaItemPropertyAlbumTitle] = music.singer;
        
        //图片
        info[MPMediaItemPropertyArtwork] = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:music.icon]];
        
        //    info[MPMediaItemPropertyLyrics] = music.lrcname;
        
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = info;
    }
    
}

#pragma mark: AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //播放完毕后，自动播放下一行。
    //1 取出当前行
    NSIndexPath *currentPath = [self.tableView indexPathForSelectedRow];
    //2 找出下一行
    NSInteger nextMusicRow = currentPath.row + 1;
    if(nextMusicRow >= self.musics.count)
    {
        nextMusicRow = 0;
    }
    
    //点击下一行
    NSIndexPath *nextPath = [NSIndexPath indexPathForRow:nextMusicRow inSection:currentPath.section];
    //实现那个系统的灰色效果
    [self.tableView selectRowAtIndexPath:nextPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    //这个只是执行了点击那一行里面的内容，并不能够实现那个灰色的效果
    [self tableView:self.tableView didSelectRowAtIndexPath:nextPath];
    
}

/**
 开始打断
 */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    //暂停播放音乐
}


/**
 停止打断
 */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player
{
    //开始播放音乐
    [player play];
}
- (IBAction)jump:(id)sender {
    self.currentPlayingAudioPlayer.currentTime = self.currentPlayingAudioPlayer.duration - 5;
}
@end
