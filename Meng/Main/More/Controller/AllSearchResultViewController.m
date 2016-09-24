//
//  AllSearchResultViewController.m
//  Meng
//
//  Created by tenghaojun on 2016/9/18.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "AllSearchResultViewController.h"
#import "StrategyModel.h"
#import "AllTableViewCell.h"
@class AllTableViewCell;
@interface AllSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>
{
     NSArray *_modelData;
    UITableView *_tableView;
}
@end

@implementation AllSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全部主题";
    [self loadImageAndWorld];
    [self createTableView];
}
-(void)createTableView{

    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view = _tableView;
    //注册单元格
    [_tableView registerClass:[AllTableViewCell class] forCellReuseIdentifier:@"AllCell"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -mark tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    AllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllCell"];
    cell.selectionStyle = UITextAutocapitalizationTypeNone;
    if (cell == nil) {
        cell = [[AllTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AllCell"];
    }
    cell.model = _modelData[indexPath.row];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 210;
}
-(void)loadImageAndWorld{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:kSecondStrategy];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *oldArray = responseObject[@"data"];
        NSArray *array = oldArray[@"collections"];
        NSLog(@"array = %li",array.count);
        NSMutableArray *mArray  = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in array) {
            StrategyModel *model = [StrategyModel yy_modelWithJSON:dic];
            [mArray addObject:model];
        }
        _modelData = [mArray mutableCopy];
        
        [_tableView reloadData];
        
    }];
    [dataTask resume];

    
}

@end
