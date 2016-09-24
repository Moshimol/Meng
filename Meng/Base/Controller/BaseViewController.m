//
//  BaseViewController.m
//  Meng
//
//  Created by lushitong on 16/8/8.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "BaseViewController.h"
#import "MenuView.h"
#import "UMSocial.h"
@interface BaseViewController ()<UMSocialUIDelegate>
@property (nonatomic,assign) BOOL flag;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackButton];
    self.flag = YES;
    
    
}
//创建返回和分享按钮
//创建返回按钮
- (void)createBackButton{
    if (self.navigationController.viewControllers.count >= 2) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 35, 35);
        [backButton setBackgroundImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        //热度排序按钮
        UIButton *rightBUtton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBUtton.frame = CGRectMake(0, 0, 40,35);
        [rightBUtton setBackgroundImage:[UIImage imageNamed:@"icon_navigation_share"] forState:UIControlStateNormal];
        
        //添加点击事件
        
        [rightBUtton addTarget:self action:@selector(shareAction) forControlEvents:(UIControlEventTouchUpInside)];
        UIBarButtonItem *navrightButton = [[UIBarButtonItem alloc]initWithCustomView:rightBUtton];
        
        
        self.navigationItem.leftBarButtonItem = leftButton;
        self.navigationItem.rightBarButtonItem = navrightButton;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_back"] forBarMetrics:UIBarMetricsDefault];
        
        
        
        
        
    }
}

- (void)shareAction{
    
    [UMSocialData defaultData].extConfig.title = self.title;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url.absoluteString;
    NSString *text = [NSString stringWithFormat:@"卖萌货，您手上的萌货专家%@", self.url.absoluteString];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57d545b6e0f55a336b004786"
                                      shareText:text
                                     shareImage:[UIImage imageNamed:@"Brand Assets-800-Portrait-736h"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina]
                                       delegate:self];
    
    
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
