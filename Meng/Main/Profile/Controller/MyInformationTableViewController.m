//
//  MyInformationTableViewController.m
//  Meng
//
//  Created by ios on 16/8/25.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "MyInformationTableViewController.h"

@interface MyInformationTableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSDictionary *myDataDic;
    UIImage *iconImage;
    NSString *iconName;
    
}
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UITableView *table;


@end

@implementation MyInformationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self getImageFromSandBox];
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveNotAction:) name:kIconAndNameNotifitionName object:nil];
    self.title = @"我的资料";
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
    //改变头像和名字
    NSString *str = myDataDic[@"avatar_url"];
    NSURL *url = [NSURL URLWithString:str];
    if (iconImage != nil) {
        self.icon.image = iconImage;
    }else{
    [_icon sd_setImageWithURL:url];
    }
    _icon.layer.cornerRadius = 20;
    _icon.layer.masksToBounds = YES;
    NSString *nameStr = myDataDic[@"nickname"];
    if (iconName != nil) {
        _name.text = iconName;
    }else{
    _name.text = nameStr;
    }
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)saveNotAction:(NSNotification *)not{
    NSDictionary *dic = not.userInfo;
    _name.text = dic[@"name"];
    iconName = dic[@"name"];
    [self saveImageInSandBox];
    [_table reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData{
    //个人数据加载，本地加载，因为做不了登陆操作
    NSString *path = [[NSBundle mainBundle] pathForResource:@"个人信息" ofType:@"json"];
    NSData *data2 = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic2 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic2 = dic2[@"data"];
    NSDictionary *userDic = dataDic2[@"user"];
    myDataDic = userDic;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 1.创建一个UIAlertController，注意用类方法创建的形式创建，选择AlertControllerStyle为ActionSheet
        UIAlertController * sheet = [UIAlertController alertControllerWithTitle:@"更换头像" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        // 2.给 ActionSheet 添加动作，可以在回调的block中写相关代码
        [sheet addAction:[UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            //获取图片源 -> 弹出相册 -> 选择图片 -> 配置图片到界面
            //获取图片源 拍照
            if ([ UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            UIImagePickerControllerSourceType sourceType  = UIImagePickerControllerSourceTypeCamera;
            //弹出相册
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = sourceType;
            picker.delegate = self;
            
            [self presentViewController:picker animated:YES completion:NULL];
              }

        }]];
        [sheet addAction:[UIAlertAction actionWithTitle:@"选择已有照片" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if ([ UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
                UIImagePickerControllerSourceType sourceType  = UIImagePickerControllerSourceTypePhotoLibrary;
                //弹出相册
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = sourceType;
                picker.delegate = self;
                
                [self presentViewController:picker animated:YES completion:NULL];
            }
        }]];
        // 注意：如果选择UIAlertActionStyleCancel这个款式，则该action是取消按钮，独立于其它的action。而其他的action都是黏在一起的。
        [sheet addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:sheet animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _icon.image = image;
    iconImage = image;
    [self saveImageInSandBox];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendimage" object:nil userInfo:@{@"image" : iconImage}];
    
}
- (void)saveImageInSandBox
{
    //1、plist 2、归档 （NSKeyedArchiver 深拷贝） 3、sqlite 4、CoreData
    if (iconImage != nil || iconName != nil) {
        [[NSUserDefaults standardUserDefaults] setObject:iconName forKey:@"iconName"];
        //进行同步操作
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSData *data = UIImageJPEGRepresentation(iconImage, 0.8);
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"iconImage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

- (void)getImageFromSandBox
{
    iconName = [[NSUserDefaults standardUserDefaults] objectForKey:@"iconName"];
    iconImage = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"iconImage"]];
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
