//
//  GonglueTableViewCell.m
//  Meng
//
//  Created by imac on 16/9/9.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "GonglueTableViewCell.h"

@implementation GonglueTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        /*
         创建8个按钮 以及一个label
         */
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 20)];
        titleLabel.text =@"攻略详情";
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLabel];
        //两个for循环 创建两列的按钮图片
        
        for (int i = 0; i < 4; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kSpaceWidth, kSpaceWidth*3 + 110*i + kSpaceWidth*i, (kScreenWidth - 3*kSpaceWidth)/2, 110)];
            button.layer.cornerRadius = 8;
            button.layer.masksToBounds =YES;
            button.backgroundColor = [UIColor redColor];
            button.tag = 50+i;
            NSString *picString = [NSString stringWithFormat:@"gong0%i.jpg",(i+1)*2-1];
            [button setBackgroundImage:[UIImage imageNamed:picString] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(picButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
        for (int i = 0; i < 4; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(2*kSpaceWidth+(kScreenWidth - 3*kSpaceWidth)/2, kSpaceWidth*3 + 110*i + kSpaceWidth*i,  (kScreenWidth - 3*kSpaceWidth)/2, 110)];
            NSString *picString = [NSString stringWithFormat:@"gong0%i.jpg",(i+1)*2];
            button.layer.cornerRadius = 8;
            button.layer.masksToBounds = YES;
            [button setBackgroundImage:[UIImage imageNamed:picString] forState:UIControlStateNormal];
            button.tag = 100+i;
            [button addTarget:self action:@selector(picButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = [UIColor blueColor];
            [self addSubview:button];
        }
        
        
        
        
    }
    
    return self;
    
}
-(void)picButtonAction:(UIButton *)button{
    
    if (button.tag == 50) {
        NSLog(@"点击了攻略1");
    }
    else if (button.tag == 51) {
        NSLog(@"点击了攻略3");
        
    }
    else if (button.tag == 52) {
        NSLog(@"点击了攻略5");
    }
    else if (button.tag == 53) {
        NSLog(@"点击了攻略7");
    }
    else if (button.tag == 100) {
        NSLog(@"点击了攻略2");
        
    }
    
    else if (button.tag == 101) {
        NSLog(@"点击了攻略4");
    }
    else if (button.tag == 102) {
        NSLog(@"点击了攻略6");
    }
    else if (button.tag == 103) {
        NSLog(@"点击了攻略8");
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
