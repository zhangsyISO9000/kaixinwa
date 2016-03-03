//
//  QKLunbo.m
//  kaixinwa
//
//  Created by 张思源 on 15/11/3.
//  Copyright © 2015年 乾坤翰林. All rights reserved.
//

#import "QKLunbo.h"
#import "MJExtension.h"
@implementation QKLunbo
-(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"lid": @"id"};
}
//重写getter方法 加上版本号
-(NSString *)lunbo_des_url
{
    NSString * str =[_lunbo_des_url componentsSeparatedByString:@"kaixinwa2.0/"].lastObject;
    NSString * newDesUrl = [NSString stringWithFormat:@"%@%@/%@",kInterfaceStart,kVersion,str];
    return newDesUrl;
}
@end
