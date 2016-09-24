//
//  MYSegmentView.h
//  Meng
//
//  Created by imac on 16/8/20.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSegmentView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong)NSArray * nameArray;
@property (nonatomic,strong)NSArray *controllers;
@property (nonatomic,strong)UIView * segmentView;
@property (nonatomic,strong)UIScrollView * segmentScrollV;
@property (nonatomic,strong)UILabel * line;
@property (nonatomic ,strong)UIButton * seleBtn;
@property (nonatomic,strong)UILabel * down;
@property (nonatomic,strong)UIImage *buttonImage;


- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers titleArray:(NSArray *)titleArray ParentController:(UIViewController *)parentC  lineWidth:(float)lineW lineHeight:(float)lineH buttonImage:(NSString*)imageName;

@end

