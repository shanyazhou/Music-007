//
//  YZMusicTableViewCell.h
//  音频
//
//  Created by lilida on 2017/8/8.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZMusic;
@interface YZMusicTableViewCell : UITableViewCell

+ (instancetype)celllWithTableView:(UITableView *)tableview;

@property (strong, nonatomic) YZMusic *music;
@end
