//
//  YZMusicTableViewCell.m
//  音频
//
//  Created by lilida on 2017/8/8.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZMusicTableViewCell.h"
#import "YZMusic.h"
#import "UIImage+MJ.h"

@interface YZMusicTableViewCell()
@property (strong, nonatomic) CADisplayLink *link;
@end

@implementation YZMusicTableViewCell
- (CADisplayLink *)link
{
    if(!_link)
    {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(doSomething)];
    }
    return _link;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"music";
    YZMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[YZMusicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (void)setMusic:(YZMusic *)music
{
#warning 不懂
//    _music = music;这个写不写的作用是？？？貌似不写也没事
    
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
    self.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:2 borderColor:[UIColor blueColor]];
//    self.imageView.image = [UIImage imageNamed:music.singerIcon];
    
    if(music.isPlaying)//如果正在播放，则转圈
    {
        self.imageView.transform = CGAffineTransformIdentity;
        [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }else{//不在播放，则停止转圈
        [self.link invalidate];
        self.link = nil;
        self.imageView.transform = CGAffineTransformIdentity;
    }
}

- (void)doSomething
{
//    self.imageView.transform = CGAffineTransformMakeRotation(M_PI_2 / 100);//以自己为中心，下次调还是自己为中心，结果就是，度数一直没有变
    
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI_2 / 100);//以上次结果为中心，继续往下走
}

@end
