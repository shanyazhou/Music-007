//
//  YZMusicTableViewController2.m
//  音频
//
//  Created by lilida on 2017/8/9.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZMusicTableViewController2.h"
#import <AVFoundation/AVFoundation.h>
#import "YZMusic.h"
#import "MJExtension.h"
#import "YZAudioTool.h"
#import "YZMusicTableViewCell.h"

@interface YZMusicTableViewController2 ()
@property (strong, nonatomic) NSArray *musics;
@end

@implementation YZMusicTableViewController2
- (NSArray *)musics
{
    if(!_musics)
    {
        _musics = [YZMusic mj_objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZMusicTableViewCell *cell = [YZMusicTableViewCell cellWithTableView:tableView];
    
    cell.music = self.musics[indexPath.row];
    
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
    [self performSegueWithIdentifier:@"musiclistToPlaying" sender:nil];
    
}

@end
