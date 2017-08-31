//
//  YZLrcView.m
//  音频
//
//  Created by lilida on 2017/8/30.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZLrcView.h"
#import "YZLrcLine.h"
@interface YZLrcView()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;//控件用weak很正常
@property (strong, nonatomic) NSMutableArray *lrcLines;
@end

@implementation YZLrcView

#pragma mark - 懒加载
- (NSMutableArray *)lrcLines
{
    if(!_lrcLines)
    {
        _lrcLines = [NSMutableArray array];
    }
    return _lrcLines;
}

//通过代码调用initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

//通过文件，Xib\nib\storyboard调用initWithCoder。decoder算是从文件中读取，解档归档那一节中
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}

//通过Xib\nib\storyboard调用initWithCoder
- (void)awakeFromNib
{
    [super awakeFromNib];
    // [self setup];//不需要这个了，如果还写这个，等于调用两次。因为initWithCoder里面已经调用了setup方法。
}

//会先调用 initWithCoder 再调用awakeFromNib。都会调用，只是一个先后顺序的问题
//不管从哪里创建的，都调用setup，比较安全
- (void)setup
{
    UITableView *tableView = [[UITableView alloc] init];
//    NSLog(@"%p,%p",self.tableView,tableView);//模拟器真傻B
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线不要
    [self addSubview:tableView];
    self.tableView = tableView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (void)setLrcname:(NSString *)lrcname
{
    _lrcname = [lrcname copy];
    
    //在加载新的之前，把旧的全部移除
    [self.lrcLines removeAllObjects];
    
    //加载歌词文件
    NSURL *url = [[NSBundle mainBundle] URLForResource:lrcname withExtension:nil];
    
    NSString *lrcStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];//加载出来的是string
    NSArray *lrcLineArray = [lrcStr componentsSeparatedByString:@"\n"];
    
    
    //输出
    for (NSString *lrcLine in lrcLineArray) {
        YZLrcLine *line = [[YZLrcLine alloc] init];//每遍历出一行歌词，对应创建一个模型
        line.time = nil;
        line.word = nil;
        if([lrcLine hasPrefix:@"["])//如果有[符号：
        {
            //如果是头部信息（歌手、歌名、专辑）
            if([lrcLine containsString:@"[ti:"] || [lrcLine containsString:@"[ar:"] || [lrcLine containsString:@"[al:"])
            {
                //[ti:123456]
                NSString *word0 = [[lrcLine componentsSeparatedByString:@":"] lastObject];
                //删掉最后一个]
                //方法一：
                NSString *word1 = [[word0 componentsSeparatedByString:@"]"] firstObject];
                
                //方法二：
                NSString *word2 = [word0 substringToIndex:word0.length - 1];
                
                //方法三：
                NSRange range = NSMakeRange(0, word0.length - 1);
                NSString *word3 = [word0 substringWithRange:range];
                
                
                line.word = word1;
            }else{//正常的歌词
                
                //[00:00.74]You are best
                NSString *word = [[lrcLine componentsSeparatedByString:@"]"] lastObject];
                NSString *time = [[lrcLine componentsSeparatedByString:@"]"] firstObject];
                line.time = [time substringFromIndex:1];
                line.word = word;
            }
            
            NSLog(@"%@,%@",line.time,line.word);
        }
        
        [self.lrcLines addObject:line];//把每一个模型，都加入到一个数组中去。
    }
    
    [self.tableView reloadData];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcLines.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"lrc";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//cell选中没反应
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.backgroundColor = [UIColor redColor];//cell的label就是显示的那么大，因此，居中不管用
        cell.textAlignment = NSTextAlignmentCenter;
    }
    
    YZLrcLine *line = self.lrcLines[indexPath.row];
    
    cell.textLabel.text = line.word;
    return cell;
}

@end
