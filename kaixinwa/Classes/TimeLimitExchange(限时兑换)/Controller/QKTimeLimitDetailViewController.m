//
//  QKTimeLimitDetailViewController.m
//  kaixinwa
//
//  Created by 张思源 on 15/11/30.
//  Copyright © 2015年 乾坤翰林. All rights reserved.
//

#import "QKTimeLimitDetailViewController.h"
#import "QKLoginViewController.h"
#import "QKAccount.h"
#import "QKAccountTool.h"
#import "QKRechargeViewController.h"

@interface QKTimeLimitDetailViewController ()

@end

@implementation QKTimeLimitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * str = request.URL.absoluteString;
    if ([str hasPrefix:@"ios://ios//"]) {
        NSArray * array= [str componentsSeparatedByString:@"//ios//"];
        NSString * ocMethod = array.lastObject;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(ocMethod)];
#pragma clang diagnostic pop
        return NO;
    }else if([str hasPrefix:@"ios://push"]){
        NSArray * array = [str componentsSeparatedByString:@"://"];
        NSString * ocMethod = array.lastObject;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(ocMethod)];
#pragma clang diagnostic pop
        return NO;
    }
    return YES;
}
//触发登录事件，不要见名之意。
-(void)removeAccount
{
    QKLoginViewController* loginVc = [[QKLoginViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
    [nav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)pushRechargeViewController
{
    NSString * str = [NSString stringWithFormat:@"%@%@/mall.php/Index/recharge?uid=%@",kInterfaceStart,kVersion,[QKAccountTool readAccount].uid];
    if(![kVersion containsString:@"r"]){
        QKRechargeViewController * recharge = [[QKRechargeViewController alloc]init];
        recharge.urlStr = str;
        [self.navigationController pushViewController:recharge animated:YES];
    }
}

@end
