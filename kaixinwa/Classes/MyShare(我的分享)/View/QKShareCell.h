//
//  QKShareCell.h
//  kaixinwa
//
//  Created by 张思源 on 15/8/21.
//  Copyright (c) 2015年 乾坤翰林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKMyShareObj.h"

@interface QKShareCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)QKMyShareObj * myShare;
@end
