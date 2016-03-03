//
//  QKVersionInfo.m
//  kaixinwa
//
//  Created by dc-macbook on 16/3/2.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKVersionInfo.h"

@implementation QKVersionInfo
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.data = [aDecoder decodeObjectForKey:@"data"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeObject:self.code forKey:@"code"];
}


@end
