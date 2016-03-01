//
//  QKTitleScrollView.m
//  KXWSaoDaAn
//
//  Created by 张思源 on 16/2/2.
//  Copyright © 2016年 乾坤翰林. All rights reserved.
//

#import "QKTitleScrollView.h"
#import "MBProgressHUD+MJ.h"

#define TOPHEIGHT 64

@interface QKTitleScrollView()<UIScrollViewDelegate,UIWebViewDelegate>
/**
 *  内容滚动图
 */
@property(nonatomic,weak)UIScrollView * scrollView;
/**
 *  视图的frame
 */
@property(nonatomic,assign)CGRect myFrame;

@property(nonatomic,weak)UIView * topMainView;
@property(nonatomic,weak)UIScrollView * topScrollView;

@property(nonatomic,weak)UIView * slideView;

///@brife 当前选中页数
@property (assign) NSInteger currentPage;

@property(nonatomic,strong)NSMutableArray * tabButtons;

@property(nonatomic,strong)NSMutableArray * webViews;

@property(nonatomic,strong)NSMutableArray * aivs;
@end

@implementation QKTitleScrollView

-(void)setUnique_code:(NSString *)unique_code
{
    _unique_code = unique_code;
    
    for (UIWebView * webView in self.webViews) {
        NSString * urlStr = [NSString stringWithFormat:@"http://101.200.173.111/kaixinwa2.0/index.php/Phone/Answer/getanswer?unique_code=%@&tab=%zd",unique_code,webView.tag];
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [webView loadRequest:request];
    }
    
}
-(NSMutableArray *)webViews{
    if (_webViews == nil) {
        _webViews = [NSMutableArray array];
    }
    return _webViews;
}

-(NSMutableArray *)tabButtons{
    if (_tabButtons == nil) {
        _tabButtons = [NSMutableArray array];
    }
    return _tabButtons;
}
-(NSMutableArray *)aivs{
    if (_aivs == nil) {
        _aivs = [NSMutableArray array];
    }
    return _aivs;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myFrame = frame;
        
        [self initScrollView];
        [self initTopTabs];
        [self initDownTables];
        
        UIButton * btn = self.tabButtons[0];
        btn.selected = YES;
    }
    return self;
}

-(void)initScrollView
{
    CGRect frame = CGRectMake(0, TOPHEIGHT, self.myFrame.size.width, SCREEN_HEIGHT-TOPHEIGHT);
    UIScrollView* scrollView = [[UIScrollView alloc]initWithFrame:frame];
    scrollView.contentSize = CGSizeMake(frame.size.width * 3, 0);
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

-(void)initTopTabs
{
    CGFloat width = self.myFrame.size.width/3;
    CGRect topFrame = CGRectMake(0, 0, self.myFrame.size.width, TOPHEIGHT);
    UIView * topMainView = [[UIView alloc]initWithFrame:topFrame];
    [self addSubview:topMainView];
    self.topMainView = topMainView;
    
    UIScrollView * topScrollView = [[UIScrollView alloc]initWithFrame:topFrame];
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.showsVerticalScrollIndicator = NO;
    topScrollView.bounces = NO;
    topScrollView.delegate = self;
    topScrollView.contentSize = CGSizeMake(width * 3, 0);
    [topMainView addSubview:topScrollView];
    self.topScrollView = topScrollView;
    /**
     *  添加按钮
     */
    for (int i = 0; i< 3; i++) {
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i * width, 0, width, TOPHEIGHT)];
        button.tag = i;
        
        NSString * title = @"知识月亮泉";
        if (i == 1) {
            title = @"心路浪花滩";
        }else if(i == 2){
            title = @"阳光绿野洲";
        }else{
            title = @"知识月亮泉";
        }
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"tabbar_background"] forState:UIControlStateSelected];
        
        
        
        [button addTarget:self action:@selector(clickTabButton:) forControlEvents:UIControlEventTouchUpInside];

        [self.topScrollView addSubview:button];
        [self.tabButtons addObject:button];
    }
    /**
     添加指示条
     */
    UIView * slideView = [[UIView alloc]initWithFrame:CGRectMake(0, TOPHEIGHT - 2, width, 2)];
    slideView.backgroundColor = [UIColor greenColor];
    [self.topScrollView addSubview:slideView];
    self.slideView = slideView;
}
/**
 *  topView 按钮点击事件
 *
 *  @param sender 按钮
 */
-(void)clickTabButton:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    btn.selected = !btn.isSelected;
    [self.scrollView setContentOffset:CGPointMake(btn.tag * self.myFrame.size.width, 0) animated:YES];
}

-(void) initDownTables{
    
    for (int i = 0; i < 3; i++) {
        
        UIWebView *contentView = [[UIWebView alloc] init];
        contentView.frame = CGRectMake(QKScreenWidth * i, 0, QKScreenWidth, self.myFrame.size.height-TOPHEIGHT);
        contentView.delegate = self;
        contentView.tag = i+1;
        [self.scrollView addSubview:contentView];
        [self.webViews addObject:contentView];
        
    }
    
    for (int i = 0; i < 3; i++) {
        UIActivityIndicatorView * aiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        aiv.color = [UIColor greenColor];
        aiv.tag = i;
        aiv.centerX = self.centerX + i * SCREEN_WIDTH;
        aiv.centerY = self.centerY - 2 * TOPHEIGHT;
        aiv.width = 50;
        aiv.height = 50;
        [aiv startAnimating];
        [aiv hidesWhenStopped];
        [self.scrollView addSubview:aiv];
        
        [self.aivs addObject:aiv];
    }
}

#pragma mark -- scrollView的代理方法
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scrollView]) {
        NSInteger lastIndex = self.currentPage;
        self.currentPage = self.scrollView.contentOffset.x/self.myFrame.size.width;
        UIButton * lastBtn = (UIButton *)self.tabButtons[lastIndex];
        UIButton * button = (UIButton *)self.tabButtons[self.currentPage];
        lastBtn.selected = NO;
        button.selected = YES;
        return;
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if ([self.scrollView isEqual:scrollView]) {
        scrollView.y = 0;
        CGRect frame = _slideView.frame;
        frame.origin.x = scrollView.contentOffset.x/3;
        _slideView.frame = frame;
    }
}

#pragma mark -UIWebviewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    for (UIActivityIndicatorView * aiv in self.aivs) {
        [aiv stopAnimating];
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    for (UIActivityIndicatorView * aiv in self.aivs) {
        [aiv stopAnimating];
    }
}

@end
