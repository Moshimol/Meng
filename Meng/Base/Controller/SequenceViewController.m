//
//  SequenceViewController.m
//  Meng
//
//  Created by lushitong on 16/9/15.
//  Copyright © 2016年 mac04. All rights reserved.
//
/**
 *这个是排序的相关东西   排序的相关网页
 */
#import "SequenceViewController.h"

#import "MenuView.h"
@interface SequenceViewController ()
@property (nonatomic,strong) MenuView * menuView;
@property (nonatomic,assign) BOOL flag;
@end

@implementation SequenceViewController

- (MenuView *)menuView{
    if (!_menuView) {
        
        /**
         *  这些数据是菜单显示的图片和文字，小弟写在这里，不知合不合理，请各位大牛指教
         *  e-mail : KongPro@163.com
         */
        NSDictionary *dict1 = @{@"imageName" : @"icon_button_affirm",
                                @"itemName" : @"默认排序"
                                };
        NSDictionary *dict2 = @{@"imageName" : @"icon_button_recall",
                                @"itemName" : @"按热度排序"
                                };
        //icon_button_record
        NSDictionary *dict3 = @{@"imageName" : @"icon_button_record",
                                @"itemName" : @"价格从低到高"
                                };
        NSDictionary *dict4 = @{@"imageName" : @"icon_button_record",
                                @"itemName" : @"价格从高到低"
                                };
        NSArray *dataArray = @[dict1,dict2,dict3,dict4];
        
        CGFloat x = self.view.bounds.size.width / 3 * 2;
        CGFloat y = 64 - 10;
        CGFloat width = self.view.bounds.size.width * 0.3;
        CGFloat height = dataArray.count * 44;
        __weak __typeof(&*self)weakSelf = self;
        /**
         *  创建menu
         */
        _menuView = [MenuView createMenuWithFrame:CGRectMake(x, y, width, height) target:self.navigationController dataArray:dataArray itemsClickBlock:^(NSString *str, NSInteger tag) {
            
            // do something
            [weakSelf doSomething:(NSString *)str tag:(NSInteger)tag];
            
        } backViewTap:^{
            // 点击背景遮罩view后的block，可自定义事件
            // 这里的目的是，让rightButton点击，可再次pop出menu
            weakSelf.flag = YES;
            _menuView = nil;
            
        }];
    }
    return _menuView;
}
- (void)doSomething:(NSString *)str tag:(NSInteger)tag{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:str message:[NSString stringWithFormat:@"点击了第%ld个菜单项",tag + 1] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.menuView showMenuWithAnimation:NO];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBackButton];
    self.flag = YES;
    
    
}
-(void)SelsctIndex{
    
    
    if (self.flag) {
        [self.menuView showMenuWithAnimation:YES];
        self.flag = NO;
    }else{
        [self.menuView showMenuWithAnimation:NO];
        self.flag = YES;
        self.menuView = nil;
    }
}

//创建返回和分享按钮
//创建返回按钮
- (void)createBackButton{
    if (self.navigationController.viewControllers.count >= 2) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 43, 42);
        [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        //热度排序按钮
        UIButton *rightBUtton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBUtton.frame = CGRectMake(0, 0, 43, 42);
        [rightBUtton setBackgroundImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
        
        //添加点击事件
        
        [rightBUtton addTarget:self action:@selector(SelsctIndex) forControlEvents:(UIControlEventTouchUpInside)];
        UIBarButtonItem *navrightButton = [[UIBarButtonItem alloc]initWithCustomView:rightBUtton];
        
        
        self.navigationItem.leftBarButtonItem = leftButton;
        self.navigationItem.rightBarButtonItem = navrightButton;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_back"] forBarMetrics:UIBarMetricsDefault];
        
        
        
        
        
    }
}

- (void)shareAction{
    
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
