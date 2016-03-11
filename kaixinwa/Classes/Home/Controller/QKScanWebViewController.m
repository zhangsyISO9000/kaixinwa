//
//  QKScanWebViewController.m
//  kaixinwa
//
//  Created by dc-macbook on 16/3/11.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKScanWebViewController.h"

@interface QKScanWebViewController ()

@end

@implementation QKScanWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"fanhui" highImageName:@"jiantousel" target:self action:@selector(back)];
}


-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
