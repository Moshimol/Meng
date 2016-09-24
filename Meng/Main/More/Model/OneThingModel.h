//
//  OneThingModel.h
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneThingModel : NSObject


@property (nonatomic, strong) NSURL *cover_image_url;//图片
@property (nonatomic, strong) NSURL *url;//点击图片的链接
@property (nonatomic, copy) NSString *name;//商品名字
@property (nonatomic, assign) double price;//商品价格
@property (nonatomic, strong) NSURL *purchase_url;//淘宝界面的URL
@end
