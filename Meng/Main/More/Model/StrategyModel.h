//
//  StrategyModel.h
//  Meng
//
//  Created by imac on 16/8/22.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <Foundation/Foundation.h>
//攻略界面  第二界面
@interface StrategyModel : NSObject
/*
 "banner_image_url":"http://7xkwn3.com1.z0.glb.clouddn.com/image/160823/bewlin4s2.jpg-w300",
 "cover_image_url":"http://7xkwn3.com1.z0.glb.clouddn.com/image/160823/jwyvrqb4f.jpg-w720",
 "created_at":1471919614,
 "id":122,
 "posts_count":5,
 "status":0,
 "subtitle":"打响军训保卫战",
 "title":"共同的回忆",
 "updated_at":1471919614
 */
@property (nonatomic, strong) NSString *banner_image_url;//页面的URl地址
@property (nonatomic, strong) NSString *cover_image_url;//
@property (nonatomic, assign) NSInteger created_at;//创建的ID
@property (nonatomic, assign) NSUInteger myID;//商品ID
@property (nonatomic, copy) NSString *subtitle;//进去页面的title
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger updated_at;


@end
