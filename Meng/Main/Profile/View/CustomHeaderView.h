//
//  CustomHeaderView.h
//  Meng
//
//  Created by ios on 16/8/23.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomHeaderView : UIView
@property (nonatomic, strong)UIImageView *icon;//头像
@property (nonatomic, strong)UILabel *name;//昵称
- (instancetype)initWithFrame:(CGRect)frame;
@end
