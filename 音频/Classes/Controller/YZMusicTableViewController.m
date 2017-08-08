//
//  YZMusicTableViewController.m
//  音频
//
//  Created by lilida on 2017/8/7.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZMusicTableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "YZMusic.h"
#import "MJExtension.h"
#import "YZAudioTool.h"

@interface YZMusicTableViewController ()
@property (strong, nonatomic) NSArray *musics;
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


- (void)viewDidLoad
{
    [super viewDidLoad];
}

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //播放音乐，播放的音乐来至模型
    YZMusic *music = self.musics[indexPath.row];
    
    [YZAudioTool playMusic:music.filename];
    
}

@end
