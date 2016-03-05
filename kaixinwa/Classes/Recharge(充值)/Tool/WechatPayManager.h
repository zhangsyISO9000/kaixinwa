//
//  WechatPayManager.h
//  testWechatPay
//
//  Created by 张思源 on 15/11/18.
//  Copyright © 2015年 乾坤翰林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXUtil.h"
#import "ApiXml.h"


// 账号帐户资料
// 更改商户把相关参数后可测试
#define APP_ID          @"wxe3c788b2f83a1b51"        //APPID
#define APP_SECRET      @"63cbfa0bc45f0864fcb46ce5a54d6ce0"                          //appsecret,看起来好像没用
//商户号，填写商户对应参数
#define MCH_ID          @"1261611901"
//商户API密钥，填写相应参数
#define PARTNER_ID      @"41891dee82e453260224246b667d6154"
//支付结果回调页面--------和安卓统一
#define NOTIFY_URL      @"http://101.200.173.111/kaixinwa2.0/mall.php/Index/success_top"
//获取服务器端支付数据地址（商户自定义）(在小吉这里，签名算法直接放在APP端，故不需要自定义)
#define SP_URL          @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php"


@interface WechatPayManager : NSObject
{
}


//预支付网关url地址
@property (nonatomic,strong) NSString* payUrl;

//debug信息
@property (nonatomic,strong) NSMutableString *debugInfo;
@property (nonatomic,assign) NSInteger lastErrCode;//返回的错误码

//商户关键信息
@property (nonatomic,strong) NSString *appId,*mchId,*spKey;


//初始化函数
-(id)initWithAppID:(NSString*)appID
             mchID:(NSString*)mchID
             spKey:(NSString*)key;

//获取当前的debug信息
-(NSString *) getDebugInfo;

//获取预支付订单信息（核心是一个prepayID）
- (NSMutableDictionary*)getPrepayWithOrderName:(NSString*)name
                                         price:(NSString*)price
                                        device:(NSString*)device
                                       orderNo:(NSString *)orderNo;

@end
