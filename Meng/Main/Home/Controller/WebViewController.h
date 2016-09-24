//
//  WebViewController.h
//  Meng
//
//  Created by ios on 16/8/17.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "BaseViewController.h"
#import "ThingsModel.h"
@interface WebViewController : BaseViewController

@property (nonatomic, strong)ThingsModel *thingsModel;
- (instancetype)initWithURL:(NSURL *)url thingModel:(ThingsModel *)thingsModel;
@end
