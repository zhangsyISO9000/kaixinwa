//
//  QKVersionInfoTool.h
//  kaixinwa
//
//  Created by dc-macbook on 16/3/2.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QKVersionInfo.h"
@interface QKVersionInfoTool : NSObject
+(void)save:(QKVersionInfo *)versionInfo;
+(QKVersionInfo *)versionInfo;
@end
