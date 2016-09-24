//
//  ThingsModel.h
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneThingModel.h"
@class OneThingModel;
/*
 comments_count	:	47
 
 content_url	:	http://www.maimenghuo.com/posts/26532/content
 
 cover_image_url	:	http://7xkwn3.com1.z0.glb.clouddn.com/image/160810/2j7ry0hvr.jpg-w720
 
 created_at	:	1470954606
 
 id	:	26532
 
	label_ids		[0]
 
 liked	:	false
 
 likes_count	:	160
 
	post_items		[7]
 
 published_at	:	1468289140
 
 share_msg	:	相信很多人都听说过性冷淡风吧，啊咧，不是性冷淡啦！！性冷淡风由normcore一词而来，是Normal+Hardcore的组合单词，可意译为看似普通却有自己的特殊之处。确实，&ld...
 
 shares_count	:	44
 
 short_title	:	None
 
 status	:	0
 
 title	:	Normcore！性冷淡风潮流～
 
 title_status	:	0
 
 updated_at	:	1470117851
 
 url	:	http://www.maimenghuo.com/posts/26532

 */
@interface ThingsModel : NSObject
@property (nonatomic, strong) NSURL *content_url;//点击进入webview的URL
@property (nonatomic, strong) NSURL *cover_image_url;//图片的URL
@property (nonatomic, assign) NSInteger likes_count;//喜欢的数量
@property (nonatomic, assign) NSInteger comments_count;//评论的数量
@property (nonatomic, assign) NSInteger shares_count;//分享的数量
@property (nonatomic, strong) NSArray *post_items;//包含的7个商品
@property (nonatomic, copy) NSString *title;//图片的上的字
@property (nonatomic, copy) NSString *liked;//是否喜欢
@property (nonatomic, assign) NSUInteger myID;//商品ID

@end
