//
//  SSeconndDetailsTableViewCell.m
//  Meng
//
//  Created by imac on 16/9/10.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "SSeconndDetailsTableViewCell.h"
@implementation SSeconndDetailsTableViewCell{
    
    UIImageView *bigView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        bigView  = [[UIImageView alloc]initWithFrame:CGRectMake(kSpaceWidth, kSpaceWidth * 3, kScreenWidth - 2*kSpaceWidth, 140)];
        bigView.layer.cornerRadius = 8;
        bigView.layer.masksToBounds= YES;
        [self addSubview:bigView];
        for (int i = 0; i < 10 ; i++) {
            UIButton *button = [[UIButton alloc]init];
            button.tag = i+100;
            [self addSubview:button];
        }
        
    }
    
    return self;
    
}
-(void)setModel:(CommodityModel *)model{

    _model = model;
    [bigView sd_setImageWithURL:[NSURL URLWithString:_model.icon_url]];
    
}


@end
