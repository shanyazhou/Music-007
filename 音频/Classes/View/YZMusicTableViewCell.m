//
//  YZMusicTableViewCell.m
//  音频
//
//  Created by lilida on 2017/8/8.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZMusicTableViewCell.h"
#import "YZMusic.h"

@implementation YZMusicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)celllWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"music";
    YZMusicTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[YZMusicTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

-(void)setMusic:(YZMusic *)music
{
    _music = music;
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
    self.imageView.image = [UIImage imageNamed:music.singerIcon];
}


@end
