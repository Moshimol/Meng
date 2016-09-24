//
//  TopView.m
//  Meng
//
//  Created by imac on 16/8/23.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "TopView.h"
#import "BaseWebViewController.h"
#import "StrategyModel.h"
@class StrategyModel;
#define firstPIC @"http://7xkwn3.com1.z0.glb.clouddn.com/image/160812/utjm8f8kf.jpg-w300";
#define sePIC @"http://7xkwn3.com1.z0.glb.clouddn.com/image/160809/4maatqhr5.jpg-w300";
#define THpic @"http://7xkwn3.com1.z0.glb.clouddn.com/image/160804/gch829uel.jpg-w300";
#define foPIC @"http://7xkwn3.com1.z0.glb.clouddn.com/image/160801/jdkok59he.jpg-w300";
@class  BaseWebViewController;
@implementation TopView{

    UIViewController *BaseView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createTwoButton];
        [self createButton];
        self.frame = CGRectMake(0, 10, kScreenWidth, 500);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)createTwoButton{
   
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(8, 64+5, 60, 20)];
    lable.backgroundColor = [UIColor yellowColor];
    lable.font = [UIFont systemFontOfSize:12];
    lable.text = @"热门攻略";
    
    [self addSubview:lable];
    
    
    StrategyModel *mode = [[StrategyModel alloc]init];
    NSLog(@"%@",mode.banner_image_url);
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-68, 64+5, 60, 20)];
    button.backgroundColor = [UIColor purpleColor];
    button.titleLabel.text = @"查看更多>";
    button.titleLabel.textColor = [UIColor darkGrayColor];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [button addTarget:self action:@selector(lookMoreInfo) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:button atIndex:0];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 64+16+20, kScreenWidth/2 -30, kScreenWidth/2 -30)];
    image1.layer.cornerRadius = 5;
    image1.backgroundColor = [UIColor blackColor];
    NSString *str = firstPIC;
    [image1 sd_setImageWithURL:[NSURL URLWithString:str]];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(15+kScreenWidth/2, 64+16+20, kScreenWidth/2 -30, kScreenWidth/2 -30)];
    image2.layer.cornerRadius = 5;
    image2.backgroundColor = [UIColor redColor];
    NSString *str2 = sePIC;
    [image2 sd_setImageWithURL:[NSURL URLWithString:str2]];
    
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 64+16+20+kScreenWidth/2 -30+15, kScreenWidth/2 -30, kScreenWidth/2 -30)];
    image3.layer.cornerRadius = 5;
    image3.backgroundColor = [UIColor greenColor];
    NSString *str3 = THpic;
    [image3 sd_setImageWithURL:[NSURL URLWithString:str3]];
    
    UIImageView *image4 = [[UIImageView alloc]initWithFrame:CGRectMake(15+kScreenWidth/2, 64+16+20+kScreenWidth/2 -30+15, kScreenWidth/2 -30, kScreenWidth/2 -30)];
    image4.layer.cornerRadius = 5;
    image4.backgroundColor = [UIColor blackColor];
    NSString *str4 = firstPIC;
    [image4 sd_setImageWithURL:[NSURL URLWithString:str4]];

    [self addSubview:image2];
    [self addSubview:image1];
    [self addSubview:image3];
    [self addSubview:image4];
}
-(void)lookMoreInfo{

    NSLog(@"进行页面跳转");



}
//查找下一个响应者  并且进行页面跳转
-(UIViewController*)viewController:(UIView*)view{
    
    UIResponder *responder =view;
    
    while ((responder = [responder nextResponder])) {
        
        if([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        
    }
    return nil;
    
}
-(void)createButton{

    //图片
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [image sd_setImageWithURL:self.onethingmodel.cover_image_url];
    image.layer.cornerRadius = 5;
    image.layer.masksToBounds = YES;
    [self addSubview:image];
    //名字
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 105, 100, 10)];
//    lable1.text = self.onethingmodel.name;
    lable1.textColor = [UIColor brownColor];
    lable1.font = [UIFont systemFontOfSize:14];
    [self addSubview:lable1];
    //价格
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 70, 10)];
//    label2.text = [NSString stringWithFormat:@"￥%.2f", self.onethingmodel.price];
    label2.textColor = [UIColor redColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:14];
    [self addSubview:label2];

}
@end
