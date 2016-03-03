//
//  QKVersionInfo.h
//  kaixinwa
//
//  Created by dc-macbook on 16/3/2.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKVersionInfo : NSObject<NSCoding>
@property(nonatomic,copy)NSString * message;
@property(nonatomic,copy)NSString * data;
@property(nonatomic,copy)NSString * code;
@end
