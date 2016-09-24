//
//  HeaderView.m
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "HeaderView.h"
#import "SmallImageWebViewController.h"
#import "BaseWebViewController.h"
@interface HeaderView ()<UIScrollViewDelegate>
{
    NSArray *imageArray;//五张图片的数组
    NSArray *buttonArray;//中间7个button的数组
    UIScrollView *scroller;
    UIPageControl *pagCtr;
    //定时器实现图片轮播
    NSTimer *timer;
    
}
@end
@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadData];
        [self createScrollerView];
        [self createButtonsView];
        self.frame = CGRectMake(0, 0, kScreenWidth, 300);
        [self addTimer];
    }
    
    
    return self;
    
}
- (void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页五张图片" ofType:@"json"];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"中间7个Button的图片" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSData *data2 = [NSData dataWithContentsOfFile:path2];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic3 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *dic4 = dic3[@"data"];
    buttonArray  = [NSArray array];
    buttonArray = dic4[@"secondary_banners"];
    
    NSDictionary *dic2 = dic[@"data"];
    imageArray = [[NSArray alloc] init];
    imageArray = dic2[@"banners"];
    
    
    
}
//开启定时器
- (void)addTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
}
//关闭定时器
- (void)removeTimer{
    [timer invalidate];
}

- (void)nextImage{
    pagCtr.currentPage  = scroller.contentOffset.x / kScreenWidth;
    int page = (int)pagCtr.currentPage;
    if (page == 4) {
        page = 0;
    }else
    {
        page++;
    }
    
    //  滚动scrollview
    CGFloat x = page * kScreenWidth;
    scroller.contentOffset = CGPointMake(x, 0);
}


#pragma mark - 创建头部的滑动视图
- (void)createScrollerView{
    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    scroller.contentSize = CGSizeMake(kScreenWidth * imageArray.count, 0);
    scroller.showsHorizontalScrollIndicator = NO;
    scroller.showsVerticalScrollIndicator = NO;
    scroller.pagingEnabled = YES;
    scroller.bounces = NO;
    
    scroller.delegate = self;
    [self addSubview:scroller];
    
    for (int i = 0; i < imageArray.count; i ++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, 200)];
        image.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [image addGestureRecognizer:tap];
        NSURL *url = [NSURL URLWithString:imageArray[i][@"image_url"]];
        [image sd_setImageWithURL:url];
        image.tag = i;
        
        [scroller addSubview:image];
        
    }
    pagCtr = [[UIPageControl alloc] initWithFrame:CGRectMake(-kScreenWidth / 2, 180, kScreenWidth, 20)];
    pagCtr.numberOfPages = 5;
    
    [self addSubview:pagCtr];
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    UIImageView *image = (UIImageView *)tap.view;
    NSString *urlStr = imageArray[image.tag][@"target_url"];
    NSURL *url = [NSURL URLWithString:urlStr];
    BaseWebViewController *web = [[BaseWebViewController alloc] initWithURL:url] ;
    web.hidesBottomBarWhenPushed = YES;
    NSDictionary *dic = imageArray[image.tag][@"target"];
    NSString *titleStr = dic[@"title"];
    if (dic == nil) {
        web.title = nil;
    }else{
        
        web.title = titleStr;
    }
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)nextResponder;
            [nav pushViewController:web animated:YES];
            break;
        }else{
            nextResponder = nextResponder.nextResponder;
        }
        
    }
    
}
#pragma mark - 创建中间的Button
- (void)createButtonsView{
    UIScrollView *midScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 100)];
    midScrollerView.backgroundColor = [UIColor whiteColor];
    midScrollerView.showsVerticalScrollIndicator = NO;
    midScrollerView.showsHorizontalScrollIndicator = NO;
    midScrollerView.bounces = NO;
    midScrollerView.contentSize = CGSizeMake(700, 0);
    [self addSubview:midScrollerView];
    //创建中间7个button
    for (int i = 0; i < buttonArray.count; i ++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10 + i * 100, 10, 80, 80)];
        NSURL *url = [NSURL URLWithString:buttonArray[i][@"image_url"]];
        image.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
        [image addGestureRecognizer:tap];
        image.tag = i;
        [image sd_setImageWithURL:url];
        [midScrollerView addSubview:image];
    }
}

- (void)buttonAction:(UITapGestureRecognizer *)tap{
    UIImageView *image = (UIImageView *)tap.view;
    
    if (image.tag != 0) {
        NSString *urlStr = buttonArray[image.tag][@"target_url"];
        NSURL *url = [NSURL URLWithString:urlStr];
        BaseWebViewController *web = [[BaseWebViewController alloc] initWithURL:url] ;
        web.hidesBottomBarWhenPushed = YES;
        
        NSString *titleStr = buttonArray[image.tag][@"title"];
        web.title = titleStr;
        UIResponder *nextResponder = self.nextResponder;
        while (nextResponder) {
            if ([nextResponder isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)nextResponder;
                [nav pushViewController:web animated:YES];
                break;
            }else{
                nextResponder = nextResponder.nextResponder;
            }
            
        }
        
        
    }
    
    
}


#pragma mark - scrollerViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //滑动结束，开启定时器
    [self addTimer];
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //滑动开始，关闭定时器
    [self removeTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    pagCtr.currentPage  = scroller.contentOffset.x / kScreenWidth ;
//    NSLog(@"----");
}



@end
