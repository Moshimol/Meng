//
//  PersonalInformationController.m
//  Meng
//
//  Created by ios on 16/8/24.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "PersonalInformationController.h"

@interface PersonalInformationController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *man;
@property (weak, nonatomic) IBOutlet UIButton *woman;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIButton *queren;
@property (nonatomic, strong) NSArray *array;//pickerview里面的内容，发送通知的时候需要用到
@property (nonatomic, strong)UIImageView *image;//男女选中的时候覆盖的视图

@property (nonatomic, copy)NSString *sex;//性别
@end

@implementation PersonalInformationController
- (void)viewWillAppear:(BOOL)animated{
    self.sex = @"男";
    [[NSNotificationCenter defaultCenter] postNotificationName:kSexChangeNotifitionName object:nil userInfo:@{@"sex" : _sex}];
    NSString *time = @"00后";
    [[NSNotificationCenter defaultCenter] postNotificationName:kTimeChangeNotifitionName object:nil userInfo:@{@"time" : time}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
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
    
    //默认是男性
    self.sex = @"男";
    
//    self.navigationController.navigationBar.hidden = YES;
    [_man setBackgroundImage:[UIImage imageNamed:@"man"] forState:UIControlStateNormal];
    [_woman setBackgroundImage:[UIImage imageNamed:@"woman"] forState:UIControlStateNormal];
    _queren.layer.cornerRadius = 15;
    _queren.layer.masksToBounds = YES;
    
    _image = [[UIImageView alloc] init];
    _image.image = [UIImage imageNamed:@"man_helight"];
    _image.frame = CGRectMake(0, 0 , 100, 100);
    [self.view addSubview:_image];
    _picker.delegate = self;
    _picker.dataSource = self;
    
}
- (void)viewDidLayoutSubviews{
    _image.center = _man.center;
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)buttonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)manButtonAction:(id)sender {
    _image.image = [UIImage imageNamed:@"man_helight"];
    _image.frame = CGRectMake(_man.frame.origin.x, _man.frame.origin.y, 100, 100);
    self.sex = @"男";
    [[NSNotificationCenter defaultCenter] postNotificationName:kSexChangeNotifitionName object:nil userInfo:@{@"sex" : _sex}];
    
}
- (IBAction)womanButtonAction:(id)sender {
    _image.image = [UIImage imageNamed:@"woman_helight"];
    _image.frame = CGRectMake(_woman.frame.origin.x, _woman.frame.origin.y, 100, 100);
    self.sex = @"女";
    [[NSNotificationCenter defaultCenter] postNotificationName:kSexChangeNotifitionName object:nil userInfo:@{@"sex" : _sex}];
}
#pragma mark - <UIPickerViewDelegate,UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    _array = @[        @"00后",
                       @"90后",
                       @"80后",
                       @"70后",
                       @"其他"];
    return _array[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *time = _array[row];
    [[NSNotificationCenter defaultCenter] postNotificationName:kTimeChangeNotifitionName object:nil userInfo:@{@"time" : time}];
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
