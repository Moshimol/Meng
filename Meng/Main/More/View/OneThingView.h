//
//  OneThingView.h
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneThingModel.h"
@interface OneThingView : UIView
@property (nonatomic, strong)OneThingModel *onethingmodel;
- (instancetype)initWithFrame:(CGRect)frame;
@end
