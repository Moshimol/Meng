//
//  SecondViewTableViewController.m
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//
/*1.思路的方法  
 三个单元格，分别计算三个单元格的高度 来确定返回cell的高度
 
 
 */
#import "SecondViewTableViewController.h"
#import "WebViewController.h"
#import "StrategyModel.h"
#import "TopicCellCell.h"
#import "LanmuTableViewCell.h"
#import "GonglueTableViewCell.h"
#import "TopView.h"
@class TopView;
@interface SecondViewTableViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *_hotWorld;
    NSArray *_buttonImageURL;
    NSArray *_modelData;
}

@property(nonatomic ,strong)UITableView * myTableView;

@end

@implementation SecondViewTableViewController
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadImageAndWorld];
    
    _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _myTableView.backgroundColor  = [UIColor clearColor];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self loadNIBFile];
    self.view = _myTableView;
}
//加载三个NIB文件  注册相关的事情
-(void)loadNIBFile{
    
    [_myTableView registerClass:[TopicCellCell class] forCellReuseIdentifier:@"TopCell"];
    
    [_myTableView registerClass:[LanmuTableViewCell class] forCellReuseIdentifier:@"LanmuCell"];
    
    [_myTableView registerClass:[GonglueTableViewCell class] forCellReuseIdentifier:@"GonglueCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    //存在3个自定义的cell 所以返回值为3
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;//每个分区都存在一个cell
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    /*
    //    分别用语句进行判断 来确定每个部分的东西
    //     
    //     */
    if(indexPath.section == 0){
        
        TopicCellCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"TopCell"];
        if (cell == nil) {
            cell = [[TopicCellCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TopCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 1) {
        LanmuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LanmuCell"];
        if(cell == nil){
            
            cell = [[LanmuTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LanmuCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    GonglueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GonglueCell"];
    if (cell == nil) {
        cell = [[GonglueTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: @"GonglueCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第三组的高度
    if (indexPath.section == 2) {
        return 600;
    }
    else if (indexPath.section==1){
        return 700;
    }
    else{
        //第一组的高度
        return 380;
    }
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
                [_myTableView reloadData];
    }];
    [dataTask resume];
    
}

@end
