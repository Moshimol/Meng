//
//  ProfileViewController.m
//  Meng
//
//  Created by lushitong on 16/8/8.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "ProfileViewController.h"
#import "CustomHeaderView.h"
#import "SettingTableViewController.h"
#import "BaseWebViewController.h"
#import "MyIntegralViewController.h"
#import "UIView+ZYDraggable.h"
#import "LikeModel.h"
#import "MyCollectionViewCell.h"
#define kButtonWidth kScreenWidth / 4
@class CustomHeaderView;
@interface ProfileViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSDictionary *myFavoriteListDic;
    NSDictionary *myDataDic;
    UIImageView *selectImage;//两个button选中下面的红线
    float buttonWidth;//布局之后button的宽度
    CustomHeaderView *header;
    BOOL flag;
    NSArray *likeArray;//喜欢的攻略
    UICollectionView *_collcetion;
    
}
@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic)  UIButton *button1;
@property (strong, nonatomic)  UIButton *button2;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = NO;
    [self createNavButton];
    //加载数据
    [self loadData];
    header = [[CustomHeaderView alloc] init];
    header.icon.userInteractionEnabled = YES;
    [header.icon makeDraggable];
    NSString *str = myDataDic[@"avatar_url"];
    NSURL *url = [NSURL URLWithString:str];
    [header.icon sd_setImageWithURL:url];
    NSString *nameStr = myDataDic[@"nickname"];
    header.name.text = nameStr;
    self.table.tableHeaderView = header;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changIcon:) name:@"sendimage" object:nil];
    
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)changIcon:(NSNotification *)not{
    NSDictionary *dic = not.userInfo;
    header.icon.image = dic[@"image"];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button1.frame = CGRectMake(kButtonWidth / 2, 0, kButtonWidth, 42);
        [_button1 setTitle:@"喜欢的商品" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(button1Action:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_button1];
        
        self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.frame = CGRectMake(kButtonWidth / 2 * 5, 0, kButtonWidth, 42);
        [_button2 setTitle:@"喜欢的攻略" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_button2 addTarget:self action:@selector(button2Action:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:_button2];
        
        selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _button1.width, 2)];
        selectImage.image = [UIImage imageNamed:@"navbar_back"];
        selectImage.mj_x = _button1.mj_x;
        selectImage.mj_y = _button1.bottom;
        
        [cell addSubview:selectImage];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一组第一行跳转到分享界面 通过HTML语言来加载的WebView
    if (indexPath.section == 0 && indexPath.row == 1) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"邀请好友" withExtension:@"html"];
        BaseWebViewController *web = [[BaseWebViewController alloc] initWithURL:url];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 0){
        MyIntegralViewController *Ctr = [[MyIntegralViewController alloc] init];
        Ctr.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Ctr animated:YES];
    }
}
#pragma mark - 创建导航栏按钮
- (void)createNavButton{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 35, 35);
    [backButton setBackgroundImage:[UIImage imageNamed:@"iconMessage@3x"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 35, 35);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"me_settings@3x"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_back"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}
- (void)messageAction{
    
    
}
- (void)settingAction{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Setting" bundle:[NSBundle mainBundle]];
    SettingTableViewController *tableViewCtr = [story instantiateInitialViewController];
    [self.navigationController pushViewController:tableViewCtr animated:YES];
}
- (void)loadData{
    //喜欢列表数据加载
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"个人数据" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:pathStr];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = dic[@"data"];
    NSArray *array = dataDic[@"favorite_lists"];
    NSDictionary *myData = [array firstObject];
    myFavoriteListDic = myData;
    
    //个人数据加载，本地加载，因为做不了登陆操作
    NSString *path = [[NSBundle mainBundle] pathForResource:@"个人信息" ofType:@"json"];
    NSData *data2 = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic2 = dic2[@"data"];
    NSDictionary *userDic = dataDic2[@"user"];
    myDataDic = userDic;
    
    //请求地址
    NSString *url = @"http://api.maimenghuo.com/v2/users/137896/post_likes?limit=20&offset=0";
    NSMutableURLRequest *requset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [requset setHTTPMethod:@"GET"];
    [requset setValue:@"session=54baebe5-bbbb-46e3-8c31-358b9db97e9e" forHTTPHeaderField:@"Cookie"];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:requset];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *resDic = responseObject;
        NSDictionary *dataDic3 = resDic[@"data"];
        NSArray *postsArray = dataDic3[@"posts"];
        NSMutableArray *mutArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic123 in postsArray) {
            LikeModel *model = [LikeModel yy_modelWithJSON:dic123];
            [mutArray addObject:model];
        }
        likeArray = [mutArray copy];
    }
    failure:nil];
    
    
    [operation start];
}


- (void)button1Action:(UIButton *)button{
    _collcetion.hidden = YES;
    [UIView animateWithDuration:0.6 animations:^{
        selectImage.mj_x = _button1.mj_x;
        selectImage.mj_y = _button1.bottom;
    }];
 //   UIView *view = button.superview;
    
    
    
    

}

- (void)button2Action:(UIButton *)button{
    _collcetion.hidden = NO;
    [UIView animateWithDuration:0.6 animations:^{
        selectImage.mj_x = _button2.mj_x;
        selectImage.mj_y = _button2.bottom;
    }];
    UIView *view = button.superview;
    if (flag == NO) {
        flag = YES;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(kScreenWidth, 80);
        _collcetion = [[UICollectionView alloc] initWithFrame:CGRectMake(view.mj_x, view.bottom, kScreenWidth, kScreenHeight - 273 - 44 - 49 - 64) collectionViewLayout:layout];
        _collcetion.delegate = self;
        _collcetion.dataSource = self;
        _collcetion.backgroundColor = [UIColor whiteColor];
        [self.table addSubview:_collcetion];
        [_collcetion registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellID"];
        
        
    }

}
#pragma mark - UICollectionViewDateSourse
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return likeArray.count;
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    LikeModel *model = likeArray[indexPath.row];
    [cell.image sd_setImageWithURL:model.cover_image_url];
    cell.tiele.text = model.title;
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LikeModel *model = likeArray[indexPath.row];
    
    BaseWebViewController *web = [[BaseWebViewController alloc] init];
    web.url = model.content_url;
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];
    [header.icon updateSnapPoint];
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
