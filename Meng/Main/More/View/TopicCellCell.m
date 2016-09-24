//
//  TopicCellCell.m
//  Meng
//
//  Created by imac on 16/8/21.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "TopicCellCell.h"
#import "WebViewController.h"
#import "StrategyModel.h"
#import "AllSearchResultViewController.h"
@class AllSearchResultViewController;
@class StrategyModel;
@class WebViewController;
#define kButtonSpace 10
@implementation TopicCellCell{
    
    UILabel *leftLabel;
    UIButton *righrButton;
    
    UIImageView *imageView1;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    
    UIViewController *CellVC;
    
    NSArray *IDArray;
    NSArray *Subtitle;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    [self loadIDandSubtitle];
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //左右的两边的按钮和label
        leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 20)];
        leftLabel.text = @"热门攻略";
        leftLabel.font = [UIFont systemFontOfSize:12];
        leftLabel.textColor = [UIColor blackColor];
        [self addSubview:leftLabel];
        
        
        righrButton = [[UIButton  alloc]initWithFrame:CGRectMake(kScreenWidth - 70 -kSpaceWidth, kSpaceWidth, 70, 15)];
        
        [righrButton setTitle:@"查看全部>" forState:UIControlStateNormal];
        [righrButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [righrButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        righrButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:righrButton];
        
        //四个button的布局
        button1  = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceWidth, kSpaceWidth*3, kScreenWidth /2 - 30, kScreenWidth /2 - 30)];
        //        button1.backgroundColor = [UIColor yellowColor];
        [button1 addTarget:self action:@selector(picButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button1.layer.cornerRadius = 8;
        button1.layer.masksToBounds = YES;
        button1.tag = 101;
        
        [button1 setBackgroundImage:[UIImage imageNamed:@"button1.jpg"] forState:UIControlStateNormal];
        [self addSubview:button1];
        
        
        button2 = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceWidth+(kScreenWidth/2), kSpaceWidth*3, kScreenWidth /2 - 30, kScreenWidth /2 - 30)];
        button2.tag = 102;
        [button2 addTarget:self action:@selector(picButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setBackgroundImage:[UIImage imageNamed:@"buton2.jpg"] forState:UIControlStateNormal];
        button2.layer.cornerRadius=8;
        button2.layer.masksToBounds = YES;
        [self addSubview:button2];
        
        button3 =[[UIButton alloc]initWithFrame:CGRectMake(kSpaceWidth*2- kSpaceWidth, kSpaceWidth*3+kScreenWidth /2 - 20, kScreenWidth /2 - 30, kScreenWidth /2 - 30)];
        [button3 setBackgroundImage:[UIImage imageNamed:@"button3.jpg"] forState:UIControlStateNormal];
        button3.tag = 103;
        [button3 addTarget:self action:@selector(picButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button3.layer.cornerRadius=8;
        button3.layer.masksToBounds = YES;
        [self addSubview:button3];
        
        button4 =[[UIButton alloc]initWithFrame:CGRectMake(kSpaceWidth*2+kScreenWidth /2- kSpaceWidth, kSpaceWidth*3+kScreenWidth /2 - 20, kScreenWidth /2 - 30, kScreenWidth /2 - 30)];
        [button4 setBackgroundImage:[UIImage imageNamed:@"button4.jpg"] forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(picButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button4.tag = 104;
        button4.layer.cornerRadius=8;
        button4.layer.masksToBounds = YES;
        [self addSubview:button4];
        
        
    }
    return self;
    
}
-(void)picButtonAction:(UIButton *)button{
    
    if (button.tag == 101) {
        [self pushViewController:IDArray[0] htmlTitle:Subtitle[0]];
    }
    if (button.tag == 102) {
        [self pushViewController:IDArray[1] htmlTitle:Subtitle[1]];
    }
    if ( button.tag == 103) {
       [self pushViewController:IDArray[2] htmlTitle:Subtitle[2]];
    }
    if (button.tag == 104) {
        [self pushViewController:IDArray[3] htmlTitle:Subtitle[3]];
        NSLog(@"%f",kScreenWidth);
    }
    
}
//事件的点击
-(void)pushViewController :(NSString *)stringNumber htmlTitle:(NSString *)title{

    WebViewController *web = [[WebViewController alloc]init];
    NSString *strUrl =[NSString stringWithFormat:@"%@%@",kSecondWebAPI,stringNumber];
    
    web.url =[NSURL URLWithString:strUrl];
    web.hidesBottomBarWhenPushed = YES;
    web.title = title;
    CellVC = [self viewController:self];
    [CellVC.navigationController pushViewController:web animated:YES];
}
//数据的加载

//查找下一个响应者  并且进行页面跳转
-(UIViewController*)viewController:(TopicCellCell*)view{
    
    UIResponder *responder =view;
    
    while ((responder = [responder nextResponder])) {
        
        if([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        
    }
    return nil;
    
}
-(void)rightButtonAction{
    
    NSLog(@"点击了右边的按钮");
    AllSearchResultViewController *allSearch = [[AllSearchResultViewController alloc]init];
    allSearch.hidesBottomBarWhenPushed = YES;
    CellVC = [self viewController: self];
    [CellVC.navigationController pushViewController:allSearch animated:YES];
    
}
-(void)loadIDandSubtitle{
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:kSecondStrategy];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            NSDictionary *oldArray = responseObject[@"data"];
            NSArray *array = oldArray[@"collections"];
            
            NSMutableArray *mArray  = [[NSMutableArray alloc]init];
            
            NSMutableArray *IDnumber = [[NSMutableArray alloc]init];//ID的数组
            NSMutableArray *SubtitleString = [[NSMutableArray alloc]init];
            
            for (NSDictionary *dic in array) {
                StrategyModel *model = [StrategyModel yy_modelWithJSON:dic];
                
                
                [IDnumber addObject:[[NSNumber numberWithInteger:model.myID]stringValue]];
                [SubtitleString addObject:model.subtitle];
                
                [mArray addObject:model];
            }
            IDArray = [IDnumber mutableCopy];
            NSLog(@"%@",IDArray);
            Subtitle = [SubtitleString mutableCopy];
        }];
        [dataTask resume];
    

    
}
@end
