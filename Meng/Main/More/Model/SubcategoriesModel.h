//
//  SubcategoriesModel.h
//  Meng
//
//  Created by imac on 16/9/11.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubcategoriesModel : NSObject
/*
 "icon_url":null,
 "id":187,
 "items_count":12,
 "name":"文具礼盒",
 "order":7,
 "parent_id":4,
 "status":0
 */
/*
 @property (nonatomic, strong) NSURL *icon_url;
 @property (nonatomic, assign) NSUInteger myID;
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, assign) NSUInteger order;
 @property (nonatomic, assign) NSInteger status;
 */
@property (nonatomic, strong) NSURL *icon_url;//这个是空的
@property (nonatomic, assign) NSUInteger myID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger parent_id;
@end
