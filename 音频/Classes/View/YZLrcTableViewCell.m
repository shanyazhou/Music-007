//
//  YZLrcTableViewCell.m
//  音频
//
//  Created by lilida on 2017/8/31.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZLrcTableViewCell.h"
#import "YZLrcLine.h"
@implementation YZLrcTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"lrc";
    YZLrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[YZLrcTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell选中没反应
        cell.textLabel.textColor = [UIColor whiteColor];
//        cell.textLabel.backgroundColor = [UIColor redColor];//cell的label就是显示的那么大，因此，居中不管用
        cell.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.numberOfLines = 0;
    }
    
    return cell;
}

- (void)setLine:(YZLrcLine *)line
{
    _line = line;
    
    self.textLabel.text = line.word;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = self.bounds;//666
}


@end
