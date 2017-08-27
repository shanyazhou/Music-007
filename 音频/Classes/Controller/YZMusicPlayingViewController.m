//
//  YZMusicPlayingViewController.m
//  音频
//
//  Created by lilida on 2017/8/14.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZMusicPlayingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YZMusic.h"
#import "YZMusicTool.h"
#import "YZAudioTool.h"

@interface YZMusicPlayingViewController ()

/**
 当前进度的 定时器
 */
@property (strong, nonatomic) NSTimer *currentTimeTimer;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) YZMusic *playingMusic;

- (IBAction)exit;
- (IBAction)lyricOrPic:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *musicBagImage;
@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *slideBtn;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIView *progressView;

- (IBAction)nextMusic:(UIButton *)sender;
- (IBAction)previousMusic:(UIButton *)sender;

@end

@implementation YZMusicPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)show
{
    //显示，需要显示在最前面，因此，加入在window控制器
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.view.frame = window.bounds;
    self.view.hidden = NO;
    //在view上升的过程中，最好不让用户再次操作
    window.userInteractionEnabled = NO;
    [window addSubview:self.view];
    
    //在出现前，如果是不同歌曲需要把歌曲数据重置
    YZMusic *newMusic = [YZMusicTool playingMusic];
    if(self.playingMusic != newMusic)
    {
        [self resetPlayingMusic];
    }
    
    //执行动画
    self.view.y = self.view.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
        [self startPlayingMusic];
        window.userInteractionEnabled = YES;
    }];
    
}

/**
 重置音乐数据
 */
- (void)resetPlayingMusic
{
    
    self.musicBagImage.image = [UIImage imageNamed:@"play_cover_pic_bg"];
    self.songNameLabel.text = nil;
    self.singerNameLabel.text = nil;
    self.durationLabel.text = nil;
    
    //把之前的老音乐停止
    [YZAudioTool stopMusic:self.playingMusic.filename];
    self.player = nil;
    
    //关闭进度定时器
    [self removeCurrentTime];
}

/**
 初始化音乐数据，开始播放音乐
 */
- (void)startPlayingMusic
{
    //如果新歌跟正在播放的歌是同一个，则不用进入下面，直接返回
    if(self.playingMusic == [YZMusicTool playingMusic]) {
        [self addCurrentTime];
        return;
    }
    
    YZMusic *playingMusic = [YZMusicTool playingMusic];
    self.playingMusic = playingMusic;
    self.player = [YZAudioTool playMusic:playingMusic.filename];
    self.durationLabel.text = [self strWithTime:self.player.duration];
    
    self.musicBagImage.image = [UIImage imageNamed:playingMusic.icon];
    self.songNameLabel.text = playingMusic.name;
    self.singerNameLabel.text = playingMusic.singer;
    
    //开启监听进度的定时器
    [self addCurrentTime];
    
}

//时间的长度 转成 时间字符串
- (NSString *)strWithTime:(NSTimeInterval)time
{
    //假如time=122,那么，应该表示为2:02
    return [NSString stringWithFormat:@"%d:%02d",(int)time/60,(int)time%60];
}

#pragma mark - 当前进度定时器的处理
- (void)addCurrentTime
{
    [self updataTime];//因为定时器是在1s之后才执行的，会有一个1s钟的空白，自己先调用一下，不要空白
    
    self.currentTimeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updataTime) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.currentTimeTimer forMode:NSRunLoopCommonModes];
}

- (void)removeCurrentTime
{
    [self.currentTimeTimer invalidate];
    self.currentTimeTimer = nil;
}

- (void)updataTime
{
    //计算进度值
    double progress = self.player.currentTime / self.player.duration;
    self.slideBtn.x = (self.view.width - self.slideBtn.width) * progress;
    
    
    //进度条的长度=view的宽度-滑块的中间x值
    self.progressView.width = self.slideBtn.center.x;
    [self.slideBtn setTitle:[self strWithTime:self.player.currentTime] forState:UIControlStateNormal];
}


#pragma mark - 事件
- (IBAction)exit {
    
    //退出的时候，也不需要监听进度条
    [self removeCurrentTime];
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    window.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.y = self.view.height;
    } completion:^(BOOL finished) {
        window.userInteractionEnabled = YES;
        self.view.hidden = YES;//如果不隐藏的话，虽然我们看不见，但是系统仍然认为view存在，而对其做一些事件处理。
    }];
    
}

- (IBAction)lyricOrPic:(UIButton *)sender {
}

- (IBAction)nextMusic:(UIButton *)sender {
    
    //重置上首音乐
    [self resetPlayingMusic];
    
    //获得下一曲歌曲
    [YZMusicTool setPlayingMusic:[YZMusicTool nextMusic]];
    
    //播放音乐
    [self startPlayingMusic];
    
    
    /**
    [YZAudioTool stopMusic:self.playingMusic.filename];
    
    YZMusic *nextMusic = [YZMusicTool nextMusic];
    [YZAudioTool playMusic:nextMusic.filename];
    
    self.playingMusic = nextMusic;
    
    [self startPlayingMusic];
     */
}

- (IBAction)previousMusic:(UIButton *)sender {
    [YZAudioTool stopMusic:self.playingMusic.filename];
    YZMusic *previousMusic = [YZMusicTool previousMusic];
    [YZAudioTool playMusic:previousMusic.filename];
    
    self.playingMusic = previousMusic;
}
@end
