//
//  OneThingView.m
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "OneThingView.h"
@interface OneThingView()
{
    UIImageView *image;
    UILabel *lable1;
    UILabel *label2;
    
}

@end
@implementation OneThingView


- (void)setOnethingmodel:(OneThingModel *)onethingmodel{
    _onethingmodel = onethingmodel;
    self.userInteractionEnabled = YES;
    [image sd_setImageWithURL:self.onethingmodel.cover_image_url];
    lable1.text = self.onethingmodel.name;
    label2.text = [NSString stringWithFormat:@"￥%.2f", self.onethingmodel.price];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //图片
        image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        image.layer.cornerRadius = 8;
        image.layer.masksToBounds = YES;
        [self addSubview:image];
        //名字
        lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 105, 100, 10)];
        lable1.textColor = [UIColor brownColor];
        lable1.textAlignment = NSTextAlignmentCenter;
        lable1.font = [UIFont systemFontOfSize:10];
        [self addSubview:lable1];
        //价格
        label2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 70, 10)];
        label2.textColor = [UIColor colorWithRed:0.8 green:0 blue:0 alpha:0.8];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = [UIFont systemFontOfSize:14];
        [self addSubview:label2];
    }
    return self;
    
    
}
@end
