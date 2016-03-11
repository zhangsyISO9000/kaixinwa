//
//  QKMessageContent.m
//  kaixinwa
//
//  Created by 张思源 on 15/9/6.
//  Copyright (c) 2015年 乾坤翰林. All rights reserved.
//

#import "QKMessageContent.h"

@implementation QKMessageContent
-(NSString *)timeStr
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    NSTimeInterval time = _timeStr.doubleValue;
    // 获得收藏的具体时间
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:time];
    
    if (createDate.isThisYear) {
        fmt.dateFormat = @"MM-dd HH:mm";
    }else{
        fmt.dateFormat = @"yyyy-MM-dd";
    }
    
    return [fmt stringFromDate:createDate];
}
@end
