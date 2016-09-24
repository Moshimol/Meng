//
//  GuideViewController.m
//  Meng
//
//  Created by ios on 16/8/15.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "GuideViewController.h"
#import "MainTabBarController.h"
@class MainTabBarController;
@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@end
@implementation GuideViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    [self createUI];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)createUI{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 5, kScreenHeight);
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"walkthrough_%d", i + 1];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:imageName];
        //给最后一张图片添加手势，让他点击能跳转
        if (i == 3) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
            [imageView addGestureRecognizer:tap];
        }
        [_scrollView addSubview:imageView];
    }
    [self.view addSubview:_scrollView];
}

- (void)tapAction{
    if (_scrollView.contentOffset.x == kScreenWidth * 3) {
        MainTabBarController *root = [[MainTabBarController alloc] init];
        [UIView transitionWithView:self.view.window duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            self.view.window.rootViewController = root;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == kScreenWidth * 3) {
        MainTabBarController *rootCtrl = [[MainTabBarController alloc] init];
        [UIView transitionWithView:self.view.window duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            self.view.window.rootViewController = rootCtrl;
        }completion:^(BOOL finished){
            
        }];
    }
}
@end
