//
//  MyCell.h
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThingsModel.h"

@interface MyCell : UITableViewCell
@property (nonatomic, strong)ThingsModel *thingsmodel;
@property (nonatomic, strong)NSArray *sevenThingsModel;//7个商品的model
@property (nonatomic, strong)NSArray *sevenSmallImage;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
