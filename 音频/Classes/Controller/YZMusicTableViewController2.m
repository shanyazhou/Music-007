//
//  YZMusicTableViewController2.m
//  音频
//
//  Created by lilida on 2017/8/9.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZMusicTableViewController2.h"
#import <AVFoundation/AVFoundation.h>
#import "YZAudioTool.h"
#import "YZMusicTool.h"
#import "YZMusicTableViewCell.h"
#import "YZMusicPlayingViewController.h"

@interface YZMusicTableViewController2 ()
@property (strong, nonatomic) YZMusicPlayingViewController *musicPlayingVc;
@end

@implementation YZMusicTableViewController2

- (YZMusicPlayingViewController *)musicPlayingVc
{
    if (!_musicPlayingVc) {
        _musicPlayingVc = [[YZMusicPlayingViewController alloc] init];
    }
    return _musicPlayingVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return [YZMusicTool musics].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZMusicTableViewCell *cell = [YZMusicTableViewCell cellWithTableView:tableView];
    
    cell.music = [YZMusicTool musics][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1 选中一会后，灰色消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //2 使用modal方式，调转到新的控制器
    //[self performSegueWithIdentifier:@"musiclistToPlaying" sender:nil];
    //上面的方法有点不好，因为，控制器消失后，歌曲还是在播放的，并没有消失，所以，用下面的方法：
    
    YZMusic *music = [YZMusicTool musics][indexPath.row];
    [YZMusicTool setPlayingMusic:music];
    
    [self.musicPlayingVc show];
    
}

@end
