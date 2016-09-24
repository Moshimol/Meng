//
//  MyCell.m
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "MyCell.h"
#import "OneThingView.h"
#import "OneThingModel.h"
#import "WebViewController.h"
#import "SmallImageWebViewController.h"

@class OneThingView;
@interface MyCell()
{
    UIImageView *image;
    UILabel *label;
    UIImageView *likeImage;
    UILabel *likeCountLabel;
    UIScrollView *scroller;
    
}

@end

@implementation MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        image.userInteractionEnabled  =YES;
        
        //添加喜欢图片
        likeImage = [[UIImageView alloc] init];
        likeImage.image = [UIImage imageNamed:@"likeimage"];
        likeCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 35, 30, 10)];
        likeCountLabel.textColor = [UIColor whiteColor];
        likeCountLabel.font = [UIFont systemFontOfSize:14];
        likeCountLabel.textAlignment = NSTextAlignmentCenter;
        likeCountLabel.backgroundColor = [UIColor clearColor];
        [likeImage addSubview:likeCountLabel];
        likeImage.alpha = 0.6;
        likeImage.frame = CGRectMake(kScreenWidth - 40 - 10, 0, 40, 55);
        [image addSubview:likeImage];
        //给图片添加手势
        UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction)];
        [image addGestureRecognizer:imageTap];
        

        //添加titlelabel
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, kScreenWidth, 30)];
        label.textColor = [UIColor colorWithWhite:1 alpha:0.8];
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        [image addSubview:label];
        
        [self addSubview:image];
        //在图片下面创建一个scrollerview
        scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 150)];
        scroller.pagingEnabled = NO;
        scroller.showsVerticalScrollIndicator = NO;
        scroller.showsHorizontalScrollIndicator = NO;
        scroller.bounces = NO;
        scroller.backgroundColor = [UIColor whiteColor];
        scroller.contentSize = CGSizeMake(700 + kSpaceWidth * 8, 0);
        [self addSubview:scroller];
        
        
        
        NSMutableArray *mutArray = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 7; i++) {
            OneThingView *view = [[OneThingView alloc] initWithFrame:CGRectMake(kSpaceWidth * (i + 1) + 100 * i, kSpaceWidth, 100, 130)];
            [mutArray addObject:view];
            //给每个小的商品添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onethingAction:)];
            [view addGestureRecognizer:tap];
            [scroller addSubview:view];
        }
        
        self.sevenSmallImage = [mutArray copy];
 
    }
    return self;
}



- (void)setThingsmodel:(ThingsModel *)thingsmodel{
    _thingsmodel = thingsmodel;
    //大图
    [image sd_setImageWithURL:_thingsmodel.cover_image_url];
    //大图里面的字
    label.text = _thingsmodel.title;
    //大图上面的liked图片
    likeCountLabel.text = [NSString stringWithFormat:@"%ld", _thingsmodel.likes_count];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in _thingsmodel.post_items) {
        OneThingModel *model = [OneThingModel yy_modelWithJSON:dic];
        [array addObject:model];
    }
    self.sevenThingsModel = [array copy];
    
    for (int i = 0; i < self.sevenThingsModel.count; i++) {
        OneThingView *view = _sevenSmallImage[i];
        view.onethingmodel = _sevenThingsModel[i];
    }
    
    
}

//大图点击的动作
- (void)imageAction{
    
    
    WebViewController *web = [[WebViewController alloc] initWithURL:self.thingsmodel.content_url thingModel:_thingsmodel];
    web.hidesBottomBarWhenPushed = YES;
    web.title = @"攻略详情";
    
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
//小图点击的动作
- (void)onethingAction:(UITapGestureRecognizer *)tap{
    OneThingView *view = (OneThingView *)tap.view;
    SmallImageWebViewController *web = [[SmallImageWebViewController alloc] initWithURL:view.onethingmodel.url andTaobaoURL:view.onethingmodel.purchase_url];
    web.hidesBottomBarWhenPushed = YES;
    web.title = @"商品详情";
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

@end
