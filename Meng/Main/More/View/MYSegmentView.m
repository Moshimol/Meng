//
//  MYSegmentView.m
//  Meng
//
//  Created by imac on 16/8/20.
//  Copyright © 2016年 mac04. All rights reserved.
//



#import "MYSegmentView.h"

@implementation MYSegmentView{

    UIImageView *leftButtonImage;
    UIImageView *rightButonImage;
}

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC  lineWidth:(float)lineW lineHeight:(float)lineH buttonImage:(NSString*)imageName
{
    if ( self=[super initWithFrame:frame  ])
    {
        float avgWidth = (frame.size.width/controllers.count);
        
        self.controllers=controllers;
        self.nameArray=titleArray;
        
        self.segmentView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 41)];
        self.segmentView.tag=50;
        [self addSubview:self.segmentView];
        self.segmentScrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 41, frame.size.width, frame.size.height -41)];
        self.segmentScrollV.contentSize=CGSizeMake(frame.size.width*self.controllers.count, 0);
        self.segmentScrollV.delegate=self;
        self.segmentScrollV.showsHorizontalScrollIndicator=NO;
        self.segmentScrollV.pagingEnabled=YES;
        self.segmentScrollV.bounces=NO;
        [self addSubview:self.segmentScrollV];
        
        for (int i=0;i<self.controllers.count;i++)
        {
            UIViewController * contr=self.controllers[i];
            [self.segmentScrollV addSubview:contr.view];
            contr.view.frame=CGRectMake(i*frame.size.width, 0, frame.size.width,frame.size.height);
            [parentC addChildViewController:contr];
            [contr didMoveToParentViewController:parentC];
        }
        for (int i=0;i<self.controllers.count;i++)
        {
            UIButton * btn=[ UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(i*(frame.size.width/self.controllers.count), 0, frame.size.width/self.controllers.count, 41);
            btn.tag=i;
            [btn setTitle:self.nameArray[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorWithRed:77/255.0 green:77/255.0 blue:77/255.0 alpha:1] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor colorWithRed:233/255.0 green:59/255.0 blue:74/255.0 alpha:1] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(Click:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.titleLabel.font=[UIFont systemFontOfSize:17.];
            [self.segmentView addSubview:btn];
            
        }
        //RGB 233 59 74  上面的文字以及下面的字体颜色的RGB三色
    
        
        self.down=[[UILabel alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, 1)];
        self.down.backgroundColor = [UIColor colorWithRed:179/255. green:179/255. blue:179/255. alpha:1.0];
        [self.segmentView addSubview:self.down];
        
        self.line=[[UILabel alloc]initWithFrame:CGRectMake((avgWidth-lineW)/2,41-lineH, lineW, lineH)];
        self.line.backgroundColor = [UIColor colorWithRed:233/255.0 green:59/255.0 blue:74/255.0 alpha:1];
        self.line.tag=100;
        [self.segmentView addSubview:self.line];
    }
    
    
    return self;
}

- (void)Click:(UIButton*)sender
{
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:17.];;
    self.seleBtn.selected=NO;
    self.seleBtn=sender;
    self.seleBtn.selected=YES;
    self.seleBtn.titleLabel.font= [UIFont systemFontOfSize:17.];;
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)* (sender.tag);
        self.line.center=frame;
    }];
    [self.segmentScrollV setContentOffset:CGPointMake((sender.tag)*self.frame.size.width, 0) animated:YES ];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectVC" object:sender userInfo:nil];
#warning 注意一下这里  必需要先点击才能出现  我觉得应该把图片的创建和显示放到其他的方法里 
    if (sender.tag ==0) {
        /*
         现在写的是点击的时候图片显示 还没想好怎么滑动的时候图片消失和出现
         */
        rightButonImage.hidden = YES;
        leftButtonImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30,30)];
        leftButtonImage.image = [UIImage imageNamed:@"icon_search_item"];
        [self.segmentView addSubview:leftButtonImage];
    }
    else if (sender.tag == 1){
        leftButtonImage.hidden = YES;
        rightButonImage = [[UIImageView alloc]initWithFrame:CGRectMake(15+kScreenWidth/2, 10, 30, 30)];
        rightButonImage.image = [UIImage imageNamed:@"icon_search_post"];
        [self.segmentView addSubview:rightButonImage];
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //我觉得应该是在这里进行互动图片的实现
    [UIView animateWithDuration:0.2 animations:^{
        CGPoint  frame=self.line.center;
        frame.x=self.frame.size.width/(self.controllers.count*2) +(self.frame.size.width/self.controllers.count)*(self.segmentScrollV.contentOffset.x/self.frame.size.width);
        self.line.center=frame;
#warning 这里有问题 你注意一下  滑动和点击必需先点击 滑动才能形成相应的东西
        /*
         */
        rightButonImage.hidden = !rightButonImage.hidden;
        leftButtonImage.hidden = !leftButtonImage.hidden;
        
    }];
    UIButton * btn=(UIButton*)[self.segmentView viewWithTag:(self.segmentScrollV.contentOffset.x/self.frame.size.width)];
    self.seleBtn.selected=NO;
    self.seleBtn=btn;
    self.seleBtn.selected=YES;
}

@end