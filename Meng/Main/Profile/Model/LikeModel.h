//
//  LikeModel.h
//  Meng
//
//  Created by ios on 16/9/19.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LikeModel : NSObject
@property (nonatomic, strong) NSURL *content_url;
@property (nonatomic, strong) NSURL *cover_image_url;
@property (nonatomic, copy) NSString *title;
@end
