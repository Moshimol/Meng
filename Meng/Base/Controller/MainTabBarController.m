//
//  MainTabBarController.m
//  Meng
//
//  Created by lushitong on 16/8/8.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController (){
    
    
    UIImageView *_selectImage;
    
}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma -mark 初始化
-(instancetype)init{
    
    self = [super init];
    if (self) {
        [self createSubViewController];
        [self customTabBar];
        
    }
    
    return self;
}
//创建子控制器
-(void)createSubViewController{
    
    NSArray *storyboardNames = @[@"Home",
                                 @"More",
                                 @"Profile"
                                 ];
    
    
    NSMutableArray *mArray = [[NSMutableArray alloc]init] ;
    
    for (NSString *sbName in storyboardNames) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbName bundle:[NSBundle mainBundle]];
        
        
        UINavigationController *navi = [storyboard instantiateInitialViewController];
        [mArray addObject:navi];
        
    }
    self.viewControllers = [mArray copy];
    
    
    
}
//自定义标签栏
-(void)customTabBar{
    
    UIImageView *bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -5, self.tabBar.frame.size.width, 54)];
    //设置图片名
    //    bgimageView.imageName = @"mask_navbar";
    bgimageView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:bgimageView atIndex:0];
    
    //    self.tabBar.backgroundImage = [UIImage imageNamed:@"Skins/cat/mask_navbar"];
    
    
    for (UIView *subView in self.tabBar.subviews) {
        Class buttonClass = NSClassFromString(@"UITabBarButton");
        if ([subView isKindOfClass:buttonClass]) {
            [subView removeFromSuperview];
        }
        
    }
    
    //选中视图frame
    _selectImage = [[UIImageView alloc] init];
    _selectImage.frame = CGRectMake(kScreenWidth / 6 - 20, 4.5, 40, 40);
    
//    CGFloat Buttonwidth = kScreenWidth / 3;
    //自定义按钮
    for (int i = 0; i<3; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame =CGRectMake((kScreenWidth / 6) * (2 * i + 1) - 20, 4.5, 40, 40);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabbarbutton%i", i + 1]] forState:UIControlStateNormal];
        
        _selectImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbarbutton_gaoliang1"]];
        
        
        [self.tabBar addSubview:button];
        [self.tabBar addSubview:_selectImage ];
        button.tag= i + 1;
        [button addTarget:self action:@selector(tabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    self.tabBar.shadowImage = [[UIImage alloc]init];
    
}
-(void)tabBarButtonAction:(UIButton *) button{
    
    self.selectedIndex = button.tag - 1;
    _selectImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"tabbarbutton_gaoliang%ld", button.tag]];
    [UIView animateWithDuration:0.25 animations:^{
        _selectImage.center = button.center;
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
