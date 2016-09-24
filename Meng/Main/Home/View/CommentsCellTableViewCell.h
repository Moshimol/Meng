//
//  CommentsCellTableViewCell.h
//  Meng
//
//  Created by ios on 16/8/19.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
