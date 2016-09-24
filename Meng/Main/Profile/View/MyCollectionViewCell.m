//
//  MyCollectionViewCell.m
//  Meng
//
//  Created by ios on 16/9/19.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.image.layer.cornerRadius = 8;
    self.image.layer.masksToBounds = YES;
}

@end
