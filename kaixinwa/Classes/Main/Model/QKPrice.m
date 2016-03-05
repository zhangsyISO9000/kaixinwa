//
//  QKPrice.m
//  kaixinwa
//
//  Created by dc-macbook on 16/3/4.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKPrice.h"

@implementation QKPrice
+(instancetype)sharePrice
{
    static QKPrice * priceInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        priceInstance = [[self alloc]init];
    });
    return priceInstance;
}
@end
