//
//  QKRechargeViewController.m
//  kaixinwa
//
//  Created by 张思源 on 15/11/26.
//  Copyright © 2015年 乾坤翰林. All rights reserved.
//

#import "QKRechargeViewController.h"
#import "QKHttpTool.h"
#import "QKAccount.h"
#import "QKAccountTool.h"
#import "MBProgressHUD+MJ.h"
#import "WechatPayManager.h"
#import "WXApi.h"
#import "OpenUDID.h"
#import "QKPrice.h"

#define BuyVerifyHttps @"https://buy.itunes.apple.com/verifyReceipt"
#define SandboxVerifyHttps @"https://sandbox.itunes.apple.com/verifyReceipt"

@interface QKRechargeViewController ()
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * tradeNumber;

@property(nonatomic,strong)NSArray *products;


@end

@implementation QKRechargeViewController
-(NSArray *)products
{
    if (!_products) {
        _products = [NSArray array];
    }
    return _products;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

//充豆方法
-(void)recharge
{
    QKPrice* price = [QKPrice sharePrice];
    price.price = self.price;
    if([WXApi isWXAppInstalled]){
        int price = [self.price intValue];
        int realPrice = price * 100;
        NSString * realPriceStr = [NSString stringWithFormat:@"%d",realPrice];
        [self wxPayWithOrderName:@"开心豆充值" price:realPriceStr orderNo:self.tradeNumber];
    }else{
        UIAlertController * alc =[UIAlertController alertControllerWithTitle:@"通知" message:@"还没有安装微信" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alc addAction:action1];
        [self presentViewController:alc animated:YES completion:nil
         ];
        
    }
}

#pragma mark - 微信支付
- (void)wxPayWithOrderName:(NSString*)name price:(NSString*)price orderNo:(NSString*)orderNo
{
    //创建支付签名对象 && 初始化支付签名对象
    WechatPayManager* wxpayManager = [[WechatPayManager alloc]initWithAppID:APP_ID mchID:MCH_ID spKey:PARTNER_ID];
    
    //获取到实际调起微信支付的参数后，在app端调起支付
    //生成预支付订单，实际上就是把关键参数进行第一次加密。
    NSString* device = [OpenUDID value];
    
    NSMutableDictionary *dict = [wxpayManager getPrepayWithOrderName:name
                                                               price:price
                                                              device:device
                                                             orderNo:orderNo];
    
    //    if(dict == nil){
    //        //错误提示
    //        NSString *debug = [wxpayManager getDebugInfo];
    //        return;
    //    }
    
    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
    
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = [dict objectForKey:@"appid"];
    req.partnerId          = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp          = stamp.intValue;
    req.package            = [dict objectForKey:@"package"];
    req.sign                = [dict objectForKey:@"sign"];
    
    [WXApi sendReq:req];
}


#pragma mark - webviewDelegate 
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * str = request.URL.absoluteString;
    DCLog(@"%@",str);
    if ([str hasPrefix:@"ios://recharge"]) {
        NSArray * array= [str componentsSeparatedByString:@"://"];
        NSString * str1 = array.lastObject;
        NSArray * str1Array = [str1 componentsSeparatedByString:@"/price/"];
        NSString * ocMethod = str1Array.firstObject;
        NSString * str2 = str1Array.lastObject;
        NSArray * priceAndTradeNo = [str2 componentsSeparatedByString:@"/out_trade_no/"];
        self.price = priceAndTradeNo.firstObject;
        self.tradeNumber = priceAndTradeNo.lastObject;
        //js通过方法名调用oc方法
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(ocMethod)];
#pragma clang diagnostic pop
        return NO;
    }
    return YES;
    
}



//#pragma mark 验证票据方法
////服务器验证
//-(void)finishPurchasedWithTransaction
//{
//    //    @"http://101.200.173.111/kaixinwa2.0/mall.php/Index/ios_pay"
//    NSURL * url = [[NSBundle mainBundle] appStoreReceiptURL];
//    NSData *receiptData = [NSData dataWithContentsOfURL:url];
//    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    //
//    [QKHttpTool postJSON:@"http://101.200.173.111/kaixinwa2.0/mall.php/Index/ios_pay" params:@{@"receipt-data":encodeStr,@"uid":[QKAccountTool readAccount].uid,@"out_trade_no":self.tradeNumber} success:^(id responseObj) {
////        DCLog(@"%@",responseObj);
//        if ([responseObj[@"code"] isEqualToNumber:@0]) {
//            DCLog(@"充值成功");
//            [[NSNotificationCenter defaultCenter] postNotificationName:NotifacationSuccessForRecharge object:nil userInfo:@{@"price":self.price}];
//        }
//        [self.myWebView reload];
//        
//    } failure:^(NSError *error) {
//        DCLog(@"%@",error);
//    }];
//}



@end
