//
//  ThirdViewCollectionViewController.m
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import "ThirdViewCollectionViewController.h"
#import "WebViewController.h"
#import "CommodityModel.h"
#import "SSeconndDetailsTableViewCell.h"
@class SSeconndDetailsTableViewCell;
/*
 1.这个cell的布局是 上面一整张图片 下面是相关的button 相关的文字
 2.图片的点击事件，以及按钮的点击时间
 
 */
@interface ThirdViewCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *_modelData;
    UITableView *_tableView;
}
@end

@implementation ThirdViewCollectionViewController
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [_tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];//读取网络数据
    [self createTableView];
    
    
    [_tableView registerClass:[SSeconndDetailsTableViewCell class] forCellReuseIdentifier:@"SSeconndCell"];
    
    
}
-(void)createTableView{
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.view = _tableView;
    //注册单元格
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableView代理方法

//代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelData.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SSeconndDetailsTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"SSeconndCell"];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    if (cell == nil) {
        cell = [[SSeconndDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SSeconndCell"];
    }
    cell.model = _modelData [indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //填充微博数据
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 350;
}

#pragma mark --UITableViewDelegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%li",indexPath.row);
    WebViewController *web = [[WebViewController alloc]init];
    NSString *strUrl =@"https://www.baidu.com/";
    web.url =[NSURL URLWithString:strUrl];
    web.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:web animated:YES];
}

//数据加载的方法
-(void)loadData{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:kSecondCommodity];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        NSDictionary *oldArray = responseObject[@"data"];
        NSArray *array = oldArray[@"categories"];
        NSMutableArray *mArray  = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in array) {
            CommodityModel *model = [CommodityModel yy_modelWithJSON:dic];
            [mArray addObject:model];
        }
        _modelData = [mArray mutableCopy];
        
        [_myTableView reloadData];

    }];
    [dataTask resume];

    
}
//获取number  进行字符创的拼接  在进行页面的跳转
-(NSURL*)setNumber:(NSNumber*)number{
    
    NSString *stringURL = [[NSString alloc]init];
    stringURL =@"badu.com";
    NSString *numberURL = [number stringValue];
    
    NSString *newString = [NSString stringWithFormat:@"%@%@",stringURL,numberURL];
    
    return [NSURL URLWithString:newString];
    
}

@end
