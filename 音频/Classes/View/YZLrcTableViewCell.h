//
//  YZLrcTableViewCell.h
//  音频
//
//  Created by lilida on 2017/8/31.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZLrcLine;
@interface YZLrcTableViewCell : UITableViewCell

@property (strong, nonatomic) YZLrcLine *line;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
