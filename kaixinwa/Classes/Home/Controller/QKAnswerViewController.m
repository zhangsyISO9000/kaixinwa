//
//  QKAnswerViewController.m
//  kaixinwa
//
//  Created by 张思源 on 15/8/17.
//  Copyright (c) 2015年 郭庆宇. All rights reserved.
//

#import "QKAnswerViewController.h"
#import "QKTitleScrollView.h"

@interface QKAnswerViewController ()
@property(nonatomic,weak)UIButton * zsBtn;
@property(nonatomic,weak)UIButton * xlBtn;
@property(nonatomic,weak)UIButton * ygBtn;
@property(nonatomic,weak)UIWebView * webView;

@property(nonatomic,weak)QKTitleScrollView * tsc;
@end

@implementation QKAnswerViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"开心蛙答案";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"fanhui" highImageName:@"jiantousel" target:self action:@selector(toBack)];
//    [self creatUI];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 64;
    frame.size.height = SCREEN_HEIGHT - 64;
    QKTitleScrollView * tsc = [[QKTitleScrollView alloc]initWithFrame:frame];
    tsc.unique_code = self.unique_code;
    [self.view addSubview:tsc];
    self.tsc = tsc;
    
    self.title = [self getTitleWithUniqueCode:self.unique_code];
    
}
-(void)toBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  获得中文标题方法
 *
 *  @param unique_code 网络请求关键参数
 *
 *  @return 标题
 */
-(NSString *)getTitleWithUniqueCode:(NSString *)unique_code
{
    NSString * xq;
    NSString * kemu;
    NSRange range;
    range.location = unique_code.length - 3;
    range.length = 1;
    NSString * xqNum = [unique_code substringWithRange:range];
    if ([xqNum isEqualToString:@"a"]) {
        xq = @"上学期";
    }else{
        xq = @"下学期";
    }
    
    if ([unique_code containsString:@"chinese"]) {
        kemu = @"语文";
    }else if([unique_code containsString:@"english"]){
        kemu = @"英语";
    }else{
        kemu = @"数学";
    }
    
    range.location = unique_code.length - 6;
    range.length = 1;
    NSString * yearStr;
    int year = [unique_code substringWithRange:range].intValue;
    yearStr = [NSString stringWithFormat:@"%d年级",year];
    
    range.location = unique_code.length-5;
    range.length = 2;
    NSString * unitStr;
    int unit = [unique_code substringWithRange:range].intValue;
    unitStr = [NSString stringWithFormat:@"%d单元",unit];
    
    range.location = unique_code.length -2;
    range.length = 2;
    NSString * classStr;
    int classNum = [unique_code substringWithRange:range].intValue;
    classStr = [NSString stringWithFormat:@"第%d课",classNum];
    NSString * title = [NSString stringWithFormat:@"%@%@%@%@%@",xq,kemu,yearStr,unitStr,classStr];
    
    return title;
}



@end
