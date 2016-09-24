//
//  SettingTableViewController.m
//  Meng
//
//  Created by ios on 16/8/23.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "SettingTableViewController.h"
#import "BaseWebViewController.h"
@interface SettingTableViewController ()<UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (weak, nonatomic) IBOutlet UILabel *sexAndTimeLabel;
@property (nonatomic, copy)NSString *sexStr;//保存性别
@property (nonatomic, copy)NSString *timeStr;//保存出生时代
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;//缓存
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更多";
    //设置字体颜色
    NSDictionary *attribute = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes = attribute;
    self.navigationController.navigationBar.translucent = YES;
    //给初始值
    _sexStr = @"男";
    _timeStr = @"00后";
    _myTable.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sexChangeAction:) name:kSexChangeNotifitionName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeChangeAction:) name:kTimeChangeNotifitionName object:nil];
    self.sexAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", _sexStr, _timeStr];

    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)sexChangeAction: (NSNotification *)not{
    NSDictionary *dic = not.userInfo;
    _sexStr = dic[@"sex"];
    [self changSexAndTimeLabelText];
    
}
- (void)timeChangeAction:(NSNotification *)not{
    NSDictionary *dic = not.userInfo;
    _timeStr = dic[@"time"];
    [self changSexAndTimeLabelText];
}

- (void)changSexAndTimeLabelText{
    self.sexAndTimeLabel.text = [NSString stringWithFormat:@"%@ %@", _sexStr, _timeStr];
    [_myTable reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //第一组第一行跳转到分享界面 通过HTML语言来加载的WebView
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"邀请好友" withExtension:@"html"];
        BaseWebViewController *web = [[BaseWebViewController alloc] initWithURL:url];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 2) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"确定清除缓存%@", self.sizeLabel.text]preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            [self clearCache];
            [self readCacheSize];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL]];
        
        [self presentViewController:alert animated:YES completion:NULL];
        
    }
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
    //创建返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 35, 35);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;

}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 清除缓存操作
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self readCacheSize];
    
}

- (void)clearCache
{
//    NSString *cache = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
//    [[NSFileManager defaultManager] removeItemAtPath:cache error:NULL];
    NSString *cachesPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *subFilePaths = [fileManager subpathsAtPath:cachesPath];
    
    for (NSString *subFilePath in subFilePaths) {
        
        NSString *path = [cachesPath stringByAppendingPathComponent:subFilePath];
        
        [fileManager removeItemAtPath:path error:nil];
        
    }

    
}

- (void)readCacheSize
{
    NSUInteger size = [self getCacheDate];
    double mbSize = size / 1024.0 / 1024.0;
    _sizeLabel.text = [NSString stringWithFormat:@"%.2fMB", mbSize];
    NSLog(@"%@", _sizeLabel.text);
}

- (NSUInteger)getCacheDate
{
    NSUInteger size = 0;
    //找到缓存路径
    NSString *cache = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
    //文件枚举，获取当前路径下的所有文件的属性
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cache];
    //拿到文件夹所有的文件
    for (NSString *fileName in fileEnumerator) {
        //获取所有文件的路径
        NSString *filePath = [cache stringByAppendingPathComponent:fileName];
        //获取所有文件的属性
        NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL];
        //计算每个文件的大小，然后相加
        size += [dic fileSize];
    }
    return size;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
