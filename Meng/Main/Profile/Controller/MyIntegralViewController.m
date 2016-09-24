//
//  MyIntegralViewController.m
//  Meng
//
//  Created by ios on 16/8/30.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "MyIntegralViewController.h"

@interface MyIntegralViewController ()

@end

@implementation MyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
    //设置字体颜色
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attribute;
    self.navigationController.navigationBar.translucent = YES;
    //创建返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 35, 35);
    [backButton setBackgroundImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //创建记录按钮
    UIButton *wanchengButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wanchengButton.frame = CGRectMake(0, 0, 50, 35);
    [wanchengButton setTitle:@"记录" forState:UIControlStateNormal];
    [wanchengButton addTarget:self action:@selector(jiluAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:wanchengButton];
    self.navigationItem.rightBarButtonItem = right;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSubViews];

}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)jiluAction{
    
}
- (void)createSubViews{
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 100)];
    image.image = [UIImage imageNamed:@"pic_top_bcce830"];
    [self.view addSubview:image];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
