//
//  CommentsTableViewController.m
//  Meng
//
//  Created by ios on 16/8/19.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "CommentsTableViewController.h"
#import "CommentsCellTableViewCell.h"
@interface CommentsTableViewController()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
}
@end
@implementation CommentsTableViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self createTableView];
    [_table registerNib:[UINib nibWithNibName:@"CommentsCellTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellID"];
    
}
- (void)setComments:(NSArray *)comments{
    _comments = comments;
}
- (void)createTableView{
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _table.showsVerticalScrollIndicator = NO;
    _table.backgroundColor = [UIColor whiteColor];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    NSDictionary *dic = self.comments[indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM月dd日 mm:ss"];
    NSString *dateLoca = [NSString stringWithFormat:@"%@",dic[@"created_at"]];
    NSTimeInterval time=[dateLoca doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSString *timestr = [formatter stringFromDate:detaildate];
    
    NSString *iconUrlStr = dic[@"user"][@"avatar_url"];
    if (![iconUrlStr isKindOfClass:[NSNull class]]) {
        NSURL *iconURL = [NSURL URLWithString:iconUrlStr];
        [cell.icon sd_setImageWithURL:iconURL];
        cell.icon.layer.cornerRadius = 17.5;
        cell.icon.layer.masksToBounds = YES;
    }
    cell.name.text = dic[@"user"][@"nickname"];
    cell.text.text = dic[@"content"];
    
    cell.time.text = timestr;
    return cell;

}

@end
