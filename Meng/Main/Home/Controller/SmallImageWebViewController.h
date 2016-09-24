//
//  SmallImageWebViewController.h
//  Meng
//
//  Created by ios on 16/8/19.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "BaseViewController.h"
#import <UIKit/UIKit.h>
@interface SmallImageWebViewController : BaseViewController

@property (nonatomic, strong)NSURL *taobaoURL;//taobao的链接
- (instancetype)initWithURL:(NSURL *)url andTaobaoURL:(NSURL *)taobaoURL;
@end
