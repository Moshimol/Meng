//
//  LanmuTableViewCell.m
//  Meng
//
//  Created by imac on 16/9/9.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "LanmuTableViewCell.h"

@implementation LanmuTableViewCell{
    
    
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
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 20)];
        titleLabel.text =@"栏目专区";
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLabel];
        for (int i = 0; i < 5; i++) {
            UIButton *button  = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceWidth, kSpaceWidth*3 + 120*i + kSpaceWidth*i, kScreenWidth - 2*kSpaceWidth, 120)];
            NSString *picString = [NSString stringWithFormat:@"lan0%i.jpg",i+1];
            button.backgroundColor = [UIColor redColor];
            [button setBackgroundImage:[UIImage imageNamed:picString] forState:UIControlStateNormal];
            button.tag = 100+i;
            button.layer.cornerRadius = 8;
            button.layer.masksToBounds = YES;
            [button addTarget: self action:@selector(picButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
        }
        
        
    }
    
    return  self;
    
}
-(void)picButtonAction:(UIButton *)button{
    if (button.tag == 100) {
        NSLog(@"lanmuyi");
    }
    else if (button.tag == 101){
        NSLog(@"lanmu er ");
    }
}
@end
