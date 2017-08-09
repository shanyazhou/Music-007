//
//  YZListenBookTableViewController.m
//  音频
//
//  Created by lilida on 2017/8/9.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#import "YZListenBookTableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MJExtension.h"
#import "YZListenBook.h"
#import "YZAudioTool.h"

@interface YZListenBookTableViewController ()
@property (strong, nonatomic) NSArray *listenBooksArray;
@property (strong, nonatomic) CADisplayLink *link;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@end

@implementation YZListenBookTableViewController

- (NSArray *)listenBooksArray
{
    if(!_listenBooksArray)
    {
        _listenBooksArray = [YZListenBook mj_objectArrayWithFilename:@"一东.plist"];
    }
    return _listenBooksArray;
}

- (CADisplayLink *)link
{
    if(!_link)
    {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(doSomething)];
    }
    return _link;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //播放声音
    self.audioPlayer = [YZAudioTool playMusic:@"一东.mp3"];
    [YZAudioTool playMusic:@"Background.caf"];
    
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)doSomething
{
    //获得当前时间
    double currentTime = self.audioPlayer.currentTime;
    for (int i = 0; i < self.listenBooksArray.count; i++) {
        //当前的row
        YZListenBook *listenBook = self.listenBooksArray[i];
        
        
        //下一个的row
        int nextRow = i + 1;
        YZListenBook *nextListenBook = nil;
        if(nextRow < self.listenBooksArray.count)
        {
            nextListenBook = self.listenBooksArray[nextRow];
        }
        if(currentTime < nextListenBook.time && currentTime >= listenBook.time)
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionTop];
            break;
        }
    }
    
}
    

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listenBooksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"listenBook";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    YZListenBook *listenBook = self.listenBooksArray[indexPath.row];
    cell.textLabel.text = listenBook.text;
    return cell;
    
}

@end
