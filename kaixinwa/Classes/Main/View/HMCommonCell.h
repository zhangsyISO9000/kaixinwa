//
//  HMCommonCell.h
//  黑马微博
//
//  Created by apple on 14-7-21.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMCommonItem;

@interface HMCommonCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;

/** cell对应的item数据 */
@property (nonatomic, strong) HMCommonItem *item;
/** 显示开心豆的图片*/
@property (nonatomic,strong) UIImageView * detailView;
@end
