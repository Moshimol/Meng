//
//  MainTouchTableTableView.m
//  Meng
//
//  Created by imac on 16/8/20.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "MainTouchTableTableView.h"

@implementation MainTouchTableTableView


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
