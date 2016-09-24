//
//  AllTableViewCell.m
//  Meng
//
//  Created by tenghaojun on 2016/9/21.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "AllTableViewCell.h"

@implementation AllTableViewCell{

    UIImageView *BGimage;
    UIImageView *GrayImageView;
    UILabel *BigLabel;
    UILabel *SmallLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    
    if (self) {
        //创建
        BGimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 2*kSpaceWidth, (kScreenWidth - 2*kSpaceWidth)/1.9)];
        NSLog(@"%lf",BGimage.frame.size.width);
        
        BGimage.layer.cornerRadius = 8;
        BGimage.layer.masksToBounds = YES;
        [self addSubview:BGimage];
        
        GrayImageView = [[UIImageView alloc]initWithFrame:BGimage.frame];
        GrayImageView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0  blue:0/255.0  alpha:0.4];
        GrayImageView.layer.cornerRadius = 8;
        GrayImageView.layer.masksToBounds = YES;
        [self addSubview:GrayImageView];
        

        
        
        UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(2*kSpaceWidth, BGimage.frame.size.height /2+ kSpaceWidth*3/2, kScreenWidth - 4*kSpaceWidth,10)];
        imageView.image = [UIImage imageNamed:@"AllSelect"];
        [self addSubview:imageView];
        
        //创建两个位于上面的label
        
        
        BigLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BGimage.frame.size.height /2 - 20, kScreenWidth, 40)];
        BigLabel.font = [UIFont systemFontOfSize:25.0];
        BigLabel.textColor = [UIColor whiteColor];
        BigLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:BigLabel];
        
        
        SmallLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BGimage.frame.size.height /2+20, kScreenWidth, 20)];
        SmallLabel.font = [UIFont systemFontOfSize:13.0];
        SmallLabel.textColor = [UIColor whiteColor];
        SmallLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:SmallLabel];
        
        
    }
    
    return self;

}
-(void)setModel:(StrategyModel *)model{

    _model = model;
    [BGimage sd_setImageWithURL:[NSURL URLWithString:_model.cover_image_url]];
    BigLabel.text = _model.title;
    SmallLabel.text = _model.subtitle;
}

@end
