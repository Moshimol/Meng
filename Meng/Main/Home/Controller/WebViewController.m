//
//  WebViewController.m
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "WebViewController.h"
#import "CommentsTableViewController.h"
#import "UMSocial.h"
@class CommentsTableViewController;
@interface WebViewController ()<UIGestureRecognizerDelegate,UMSocialUIDelegate>
{
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    BOOL isLiked;
    NSArray *array;//网络加载的评论数组
    
    
}
@end

@implementation WebViewController
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    return YES;
//}
- (instancetype)initWithURL:(NSURL *)url thingModel:(ThingsModel *)thingsModel{
    self = [super init];
    if (self) {
        self.url = url;
        _thingsModel = thingsModel;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44)];
    web.scrollView.showsVerticalScrollIndicator = NO;
    NSURLRequest *requst = [[NSURLRequest alloc] initWithURL:self.url];
    [web loadRequest:requst];
    
    //底部加上三个按钮
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44)];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(kScreenWidth / 6 - 30, 7, 30, 30);
    [button1 setBackgroundImage:[UIImage imageNamed:@"toolbarbutton1"] forState:UIControlStateNormal];
    button1.adjustsImageWhenHighlighted = NO;
    [button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(kScreenWidth / 6 * 3 - 30, 7, 30, 30);
    [button2 setBackgroundImage:[UIImage imageNamed:@"toolbarbutton2"] forState:UIControlStateNormal];
    button2.adjustsImageWhenHighlighted = NO;
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(kScreenWidth / 6 * 5 - 30, 7, 30, 30);
    [button3 setBackgroundImage:[UIImage imageNamed:@"toolbarbutton3"] forState:UIControlStateNormal];
    button3.adjustsImageWhenHighlighted = NO;
    [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    label1 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 6, 7, 40, 30)];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [NSString stringWithFormat:@"%ld", (long)_thingsModel.likes_count];
    label2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 6 * 3, 7, 40, 30)];
    label2.textColor = [UIColor blackColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"%ld", (long)_thingsModel.comments_count];
    label3 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 6 * 5, 7, 40, 30)];
    label3.textColor = [UIColor blackColor];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.text = [NSString stringWithFormat:@"%ld", (long)_thingsModel.shares_count];
    [bottomView addSubview:button1];
    [bottomView addSubview:button2];
    [bottomView addSubview:button3];
    [bottomView addSubview:label1];
    [bottomView addSubview:label2];
    [bottomView addSubview:label3];
    
    [self.view addSubview:web];
    [self.view addSubview:bottomView];
    //设置字体颜色
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attribute;
    self.navigationController.navigationBar.translucent = YES;
}
- (void)button1Action:(UIButton *)button{
    
    isLiked = !isLiked;
    if (isLiked) {
        [button setBackgroundImage:[UIImage imageNamed:@"toolbarbutton1_heliht"] forState:UIControlStateNormal];
        label1.text = [NSString stringWithFormat:@"%ld", _thingsModel.likes_count + 1];
    }else{
        [button setBackgroundImage:[UIImage imageNamed:@"toolbarbutton1"] forState:UIControlStateNormal];
        label1.text = [NSString stringWithFormat:@"%ld", _thingsModel.likes_count];
    }
}
- (void)button2Action{
    //网络请求,加载20个商品
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.maimenghuo.com/v2/posts/%lu/comments?dataset=top&limit=600&offset=0", (unsigned long)_thingsModel.myID];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSDictionary *dicData = dic[@"data"];
        array = [NSArray array];
        array = dicData[@"comments"];
        CommentsTableViewController *comCtr = [[CommentsTableViewController alloc] init];
        comCtr.comments = array;
        [self.navigationController pushViewController:comCtr animated:YES];
        
    }];
    [dataTask resume];

    
    
}
- (void)button3Action{
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

@end
