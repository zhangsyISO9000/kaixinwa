//
//  QKVersionInfoTool.m
//  kaixinwa
//
//  Created by dc-macbook on 16/3/2.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKVersionInfoTool.h"

#define QKVersionInfoFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"versionInfo.data"]
@implementation QKVersionInfoTool
+(void)save:(QKVersionInfo*)versionInfo
{
    [NSKeyedArchiver archiveRootObject:versionInfo toFile:QKVersionInfoFilepath];
}

+(QKVersionInfo *)versionInfo
{
    QKVersionInfo * version = [NSKeyedUnarchiver unarchiveObjectWithFile:QKVersionInfoFilepath];
    return version;
}
@end
