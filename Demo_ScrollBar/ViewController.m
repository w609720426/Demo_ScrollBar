//
//  ViewController.m
//  Demo_ScrollBar
//
//  Created by Liuquan on 16/8/12.
//  Copyright © 2016年 Liuquan. All rights reserved.
//
/*-----------------------------------------------------------------------------------------------
/
/                                       封装一个滚动列表
/
/ ---------------------------------------------------------------------------------------------*/
#import "ViewController.h"
#import "LQHeaderScrollView.h"
#import "LQBaseViewController.h"

#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
{
    UIButton *_selectedBtn;
    UIView *_lineView;
    NSArray *_titles;
}

@property (nonatomic, strong) UIScrollView *mainScro;
@property (nonatomic, strong) LQHeaderScrollView *header;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSArray *header_title = @[@"推荐",@"热门",@"视频",@"搞笑",@"社会",@"奥运会",@"星座",@"动漫",@"电影",@"天气",@"科技"];
    LQHeaderScrollView *header = [[LQHeaderScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    _header = header;
    header.underLine_color = [UIColor redColor];
    header.dataArray = header_title;
    header.selected_color = [UIColor blueColor];
    header.normal_color = [UIColor lightGrayColor];
    [self.view addSubview:header];
    
    [self header_handleBack];
    
    [self setMainUI:header_title];
}

- (void)header_handleBack
{
    __weak typeof(self)weakSelf = self;
    _header.headerBlock = ^(NSInteger selecteIndex){
        [weakSelf.mainScro setContentOffset:CGPointMake((selecteIndex - 100) * SCREEN_WIDTH, 0) animated:YES];
    };
}

- (void)setMainUI:(NSArray *)array
{
    self.mainScro = [[UIScrollView alloc] init];
    self.mainScro.frame = CGRectMake(0, 109, SCREEN_WIDTH, SCREEN_HEIGHT - 109);
    self.mainScro.showsHorizontalScrollIndicator = NO;
    self.mainScro.contentSize = CGSizeMake(SCREEN_WIDTH * array.count, 0);
    self.mainScro.backgroundColor = [UIColor purpleColor];
    self.mainScro.pagingEnabled = YES;
    self.mainScro.delegate = self;
    [self.view addSubview:self.mainScro];
    
    for (int vcCount = 0; vcCount < array.count; vcCount ++) {
        LQBaseViewController *baseVC = [[LQBaseViewController alloc] init];
        baseVC.dataArray = array;
        baseVC.seletedIndex = 0;
        [self addChildViewController:baseVC];
    }
    
    LQBaseViewController *baseVC = [self.childViewControllers firstObject];
    baseVC.view.frame = self.mainScro.bounds;
    [self.mainScro addSubview:baseVC.view];
}
#pragma mark - 滚动视图的代理
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == self.mainScro) {
        NSInteger x = scrollView.contentOffset.x / SCREEN_WIDTH;
        LQBaseViewController *baseVC = self.childViewControllers[x];
        baseVC.seletedIndex = x;
        self.header.under_Sign = x;
        if (baseVC.view.superview) return;
        baseVC.view.frame = scrollView.bounds;
        [self.mainScro addSubview:baseVC.view];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
@end
