//
//  QKAboutKaixinwaViewController.m
//  kaixinwa
//
//  Created by 张思源 on 15/7/17.
//  Copyright (c) 2015年 郭庆宇. All rights reserved.
//

#import "QKAboutKaixinwaViewController.h"

@interface QKAboutKaixinwaViewController ()
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation QKAboutKaixinwaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于开心蛙";
    NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
    NSString * currentVersion = [bundleDic objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = currentVersion;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
