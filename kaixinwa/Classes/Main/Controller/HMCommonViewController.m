
//
//  HMCommonViewController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMCommonViewController.h"
#import "HMCommonCell.h"
#import "QKCommonItemHeader.h"
#import "QKAccountTool.h"
#import "QKAccount.h"
#import "QKLoginViewController.h"

@interface HMCommonViewController ()
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation HMCommonViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

/** 屏蔽tableView的样式 */
- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置tableView属性
    self.tableView.backgroundColor = QKGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = QKCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HMCommonGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMCommonCell *cell = [HMCommonCell cellWithTableView:tableView];
    HMCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    // 设置cell所处的行号 和 所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:(int)group.items.count];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    HMCommonGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HMCommonGroup *group = self.groups[section];
    return group.header;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.取出这行对应的item模型
    HMCommonGroup *group = self.groups[indexPath.section];
    HMCommonItem *item = group.items[indexPath.row];
    
    if (![QKAccountTool readAccount]) {
        QKLoginViewController * loginVc = [[QKLoginViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [nav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        // 2.判断有无需要跳转的控制器
        if (item.destVcClass) {
            UIViewController *destVc = [[item.destVcClass alloc] init];
            destVc.title = item.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
        
        // 3.判断有无想执行的操作
        if (item.operation) {
            item.operation();
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMCommonGroup * group = self.groups[indexPath.section];
    HMCommonItem * item = group.items[indexPath.row];
    if ([item isKindOfClass:[HMCommonAvatarItem class]]) {
        return 80;
    }
    return 44;
}
@end