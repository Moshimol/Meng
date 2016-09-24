//
//  ChangeNameViewController.m
//  Meng
//
//  Created by ios on 16/8/25.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "ChangeNameViewController.h"

@interface ChangeNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UIButton *wanchengButton;

@end

@implementation ChangeNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    _textFiled.delegate = self;
    //设置字体颜色
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attribute;
    self.navigationController.navigationBar.translucent = YES;
    //创建返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 35, 35);
    [backButton setBackgroundImage:[UIImage imageNamed:@"btnBack"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)buttonAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kIconAndNameNotifitionName object:nil userInfo:@{@"name" : self.textFiled.text}];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - textfiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:kIconAndNameNotifitionName object:nil userInfo:@{@"name" : self.textFiled.text}];
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
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
