//
//  SearchBarView.m
//  Meng
//
//  Created by imac on 16/8/18.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "SearchBarView.h"
#import "SearchViewController.h"
#import "MoreViewController.h"
@class SearchViewController;

@implementation SearchBarView{
    
    UIViewController *seVC;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-30, 30)];
        [search setSearchBarStyle:UISearchBarStyleMinimal];
        search.backgroundColor = [UIColor whiteColor];
        search.layer.cornerRadius = 10;
        search.placeholder =@"天下萌物";
        [search setUserInteractionEnabled:YES];
        search.delegate=self;
        [self addSubview:search];
        //        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
        //        button.frame = CGRectMake(search.frame.size.width-30, 0, 50, 30);
        //        [button setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        //        [self addSubview:button];
        //        [button addTarget:search action:@selector(GotoSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return  self;
}
- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"跳转到另外一个页面");
    //这里进行页面的跳转
    
    seVC = [self viewController:self];
    
    
    SearchViewController *seachVC = [[SearchViewController alloc]init];
    [seVC presentViewController:seachVC animated:YES completion:^{
        NSLog(@"跳转了");
    }];
    
    
}
//查找下一个响应者  并且进行页面跳转
-(UIViewController*)viewController:(SearchBarView*)view{
    
    UIResponder *responder =view;
    
    while ((responder = [responder nextResponder])) {
        
        if([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        
    }
    return nil;
    
}

@end
