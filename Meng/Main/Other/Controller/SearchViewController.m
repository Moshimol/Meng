//
//  SearchViewController.m
//  Meng
//
//  Created by imac on 16/8/21.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchBarView.h"
@interface SearchViewController (){
    
    NSArray *_hotWorld;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self createdBackButton];
    [self createdButton];
    // Do any additional setup after loading the view from its nib.
}
-(void)createdBackButton{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 16, 43, 42);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    imageView.image = [UIImage imageNamed:@"navbar_back"];
    [self.view addSubview:imageView];
    [self.view addSubview:backButton];
    
}
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@" 返回上一个页面");
    }];
}

-(void)createdButton{
    
    //    for (int i = 0; i < _hotWorld.count; i++) {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(64, kScreenWidth/5, 60, 30)];
    [button setTitle:_hotWorld[3] forState:UIControlStateNormal];
    //        button.backgroundColor = [UIColor greenColor];
    button.tag = 100;
    [self.view addSubview:button];
    //    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -热词显示
-(void)loadHotWorld{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"第二个界面点击搜索出来的热词" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *dicData = dic[@"data"];
    NSArray *array = dicData[@"hot_words"];
    
    _hotWorld = [array copy];
    //热词的解析
    NSLog(@"%@",_hotWorld);
    
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
