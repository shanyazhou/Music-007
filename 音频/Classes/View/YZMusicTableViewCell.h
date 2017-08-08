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
@property (strong, nonatomic) YZMusic *music;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
