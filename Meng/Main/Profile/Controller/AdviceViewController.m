//
//  AdviceViewController.m
//  Meng
//
//  Created by ios on 16/8/23.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "AdviceViewController.h"
#import "MyTextView.h"
@interface AdviceViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet MyTextView *text1;

@property (weak, nonatomic) IBOutlet MyTextView *text2;
@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    _text1.delegate = self;
    _text2.delegate = self;
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
    
    //创建完成按钮
    UIButton *wanchengButton = [UIButton buttonWithType:UIButtonTypeCustom];
    wanchengButton.frame = CGRectMake(0, 0, 50, 35);
    [wanchengButton setTitle:@"完成" forState:UIControlStateNormal];
    [wanchengButton addTarget:self action:@selector(wanchengAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:wanchengButton];
    self.navigationItem.rightBarButtonItem = right;
    
    
    
    self.text1.myPlaceholder = @"我们很需要你的建议";
    self.text1.myPlaceholderColor = [UIColor lightGrayColor];
    self.text1.layer.borderColor = [UIColor grayColor].CGColor;
    self.text1.layer.borderWidth = 1;
    
    self.text2.myPlaceholder = @"电话/邮箱/QQ";
    self.text2.myPlaceholderColor = [UIColor lightGrayColor];
    self.text2.layer.borderColor = [UIColor grayColor].CGColor;
    self.text2.layer.borderWidth = 1;
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]){
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)wanchengAction{
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
