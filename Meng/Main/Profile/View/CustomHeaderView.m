//
//  CustomHeaderView.m
//  Meng
//
//  Created by ios on 16/8/23.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "CustomHeaderView.h"
#import "MyInformationTableViewController.h"

@implementation CustomHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, 150);
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navbar_back"]];
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews{
    UIImageView *bgImg= [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 45, 0, 90, 120)];
    bgImg.image = [UIImage imageNamed:@"bg_headshot_96e7987"];
    bgImg.userInteractionEnabled = YES;
    
    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 40, 37.5, 80, 80)];
    self.icon.layer.cornerRadius = 40;
    self.icon.layer.masksToBounds = YES;
    self.icon.image = [UIImage imageNamed:@"message"];
    self.icon.userInteractionEnabled = YES;
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.icon addGestureRecognizer:tap];
    [self addSubview:_icon];
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 45, 120, 90, 25)];
    _name.textColor = [UIColor whiteColor];
    _name.textAlignment = NSTextAlignmentCenter;
    _name.text = @"拖动头像试试";
    [self addSubview:_name];


}
- (void)tapAction{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MyInformation" bundle:[NSBundle mainBundle]];
    
    MyInformationTableViewController *inforCtr = [story instantiateInitialViewController];
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)nextResponder;
            [nav pushViewController:inforCtr animated:YES];
            break;
        }else{
            nextResponder = nextResponder.nextResponder;
        }
        
    }
}
@end
