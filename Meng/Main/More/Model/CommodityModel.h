//
//  CommodityModel.h
//  Meng
//
//  Created by imac on 16/8/22.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubcategoriesModel.h"
//商品界面  第三界面
/*"icon_url":"http://7xkwn3.com1.z0.glb.clouddn.com/image/160530/r8p3zc3pv.png-w640",
 "id":4,
 "name":"学生党文具",
 "order":11,
 "status":0,
 "subcategories":[
 {
 "icon_url":null,
 "id":7,
 "items_count":116,
 "name":"笔",
 "order":20,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":8,
 "items_count":39,
 "name":"文具盒",
 "order":19,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":9,
 "items_count":187,
 "name":"本子",
 "order":18,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":10,
 "items_count":20,
 "name":"橡皮涂改",
 "order":17,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":11,
 "items_count":32,
 "name":"书签",
 "order":16,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":12,
 "items_count":39,
 "name":"贺卡／明信片",
 "order":15,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":14,
 "items_count":14,
 "name":"日历／台历",
 "order":13,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":16,
 "items_count":22,
 "name":"便利贴",
 "order":11,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":17,
 "items_count":15,
 "name":"胶带",
 "order":10,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":18,
 "items_count":53,
 "name":"办公收纳",
 "order":9,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":19,
 "items_count":36,
 "name":"手帐相关",
 "order":8,
 "parent_id":4,
 "status":0
 },
 {
 "icon_url":null,
 "id":187,
 "items_count":12,
 "name":"文具礼盒",
 "order":7,
 "parent_id":4,
 "status":0
 }
 ]
 },
  */
@interface CommodityModel : NSObject
@property (nonatomic, strong) NSString *icon_url;
@property (nonatomic, assign) NSUInteger myID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger order;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) SubcategoriesModel *subcategories;

@end
