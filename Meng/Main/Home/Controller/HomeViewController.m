//
//  HomeViewController.m
//  Meng
//
//  Created by lushitong on 16/8/8.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "HomeViewController.h"
#import "HeaderView.h"
#import "MyCell.h"
#import "ThingsModel.h"

@class HeaderView;
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_modelData;
}
@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated{
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self createTableView];
    [self createSearch];
    //调用创建刷新控件的方法
    [self createRefresh];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [_tableView registerClass:[MyCell class] forCellReuseIdentifier:@"cellID"];
    
}
#pragma mark - 加载model数据
- (void)loadData{
    
    //网络请求,加载20个商品

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://api.maimenghuo.com/v2/posts?limit=20&offset=0"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
                NSDictionary *dicData = dic[@"data"];
                NSArray *array = dicData[@"posts"];
                NSMutableArray *mutArray = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in array) {
                    ThingsModel *model = [[ThingsModel alloc] init];
                    model = [ThingsModel yy_modelWithJSON:dic];
                    [mutArray addObject:model];
                }
                _modelData = [mutArray copy];
                [_tableView reloadData];
        //获取到数据后停止刷新
        [_tableView.mj_header endRefreshing];
            }];
    [dataTask resume];

}
#pragma mark - 创建表视图
- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = [[HeaderView alloc]init];
    [self.view addSubview:_tableView];


    
}
//创建下拉刷新控件
- (void)createRefresh{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i =1; i<=6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%zd", i]];
        [refreshingImages addObject:image];
    }
    
    // 设置正在刷新状态的动画图片
    [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    //设置下拉的时候的图片
    [header setImages:refreshingImages forState:MJRefreshStateIdle];
    // 设置header
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
//    header.gifView.frame = CGRectMake(kScreenWidth / 2 - 20, 0, 40, 40);
    _tableView.mj_header = header;

}
#pragma mark - UITableViewDelegate,UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.thingsmodel = _modelData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}
#pragma mark - 创建搜索按钮
- (void)createSearch{
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 30, 30);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"searchButton"] forState:UIControlStateNormal];
    shareButton.layer.cornerRadius = 15;
    shareButton.layer.masksToBounds = YES;
    [shareButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
//    rightButton.customView.layer.cornerRadius = 20.5;
    self.navigationItem.rightBarButtonItem = rightButton;
}
- (void)searchAction{
    //进入查找界面
    
}
#pragma mark - 下滑的时候出现navgationbar
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double myX = 64 + scrollView.contentOffset.y;
//    NSLog(@"%f",myX);

    if (myX > 0) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_back"] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
        double al = myX / 64;
        self.navigationController.navigationBar.alpha = al;
//        [self.navigationController.navigationBar setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:al]];
        //设置titleview
        UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 84, 38)];
        titleView.image = [UIImage imageNamed:@"title"];
        self.navigationItem.titleView = titleView;
        
    }else if (myX <= 0){
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0]];
        self.navigationItem.titleView.alpha = 0;
        self.navigationItem.titleView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
