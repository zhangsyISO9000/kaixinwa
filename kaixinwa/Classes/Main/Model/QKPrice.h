//
//  QKPrice.h
//  kaixinwa
//
//  Created by dc-macbook on 16/3/4.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKPrice : NSObject
//价格字符串 单位：元
@property(nonatomic,copy)NSString *price;

+(instancetype)sharePrice;
@end
