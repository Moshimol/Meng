//
//  SmallImageWebViewController.m
//  Meng
//
//  Created by ios on 16/8/19.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "SmallImageWebViewController.h"
#import "BaseWebViewController.h"
@implementation SmallImageWebViewController
- (instancetype)initWithURL:(NSURL *)url andTaobaoURL:(NSURL *)taobaoURL{
    self = [super init];
    if (self) {
        self.url = url;
        _taobaoURL = taobaoURL;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.navigationController.toolbarHidden = NO;
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    web.scrollView.showsVerticalScrollIndicator = NO;
    NSURLRequest *requst = [[NSURLRequest alloc] initWithURL:self.url];
    [web loadRequest:requst];
    [self.view addSubview:web];
    //设置字体颜色
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attribute;
    self.navigationController.navigationBar.translucent = YES;
    [self createBottomView];
}

- (void)createBottomView{
    UIView *custom = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 64, kScreenWidth, 64)];
    custom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:custom];
    
    UIButton *xihuan = [UIButton buttonWithType:UIButtonTypeCustom];
    [xihuan setBackgroundImage:[UIImage imageNamed:@"xihuanButton"] forState:UIControlStateNormal];
    xihuan.frame = CGRectMake(5, 7, kScreenWidth / 2 - 5, 50);
    [custom addSubview:xihuan];
    
    UIButton *taobao = [UIButton buttonWithType:UIButtonTypeCustom];
    taobao.backgroundColor = [UIColor redColor];
    [taobao addTarget:self action:@selector(taobaoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [taobao setTitle:@"去淘宝购买" forState:UIControlStateNormal];
    taobao.layer.cornerRadius = 25;
    taobao.layer.masksToBounds = YES;
    taobao.titleLabel.textColor = [UIColor whiteColor];
    taobao.frame = CGRectMake(kScreenWidth / 2 + 10, 7, kScreenWidth / 2 - 5, 50);
    [custom addSubview:taobao];
    
    UIImageView *rabbitImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 80, kScreenHeight - 100, 80, 100)];
    rabbitImage.image = [UIImage imageNamed:@"rabbit"];
    rabbitImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:rabbitImage];
    
}
- (void)taobaoButtonAction{
    BaseWebViewController *web = [[BaseWebViewController alloc] initWithURL:_taobaoURL];
    web.title = @"商品详情";
    [self.navigationController pushViewController:web animated:YES];
}

@end
