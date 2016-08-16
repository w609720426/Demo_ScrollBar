//
//  LQHeaderScrollView.m
//  Demo_ScrollBar
//
//  Created by Liuquan on 16/8/15.
//  Copyright © 2016年 Liuquan. All rights reserved.
//

#import "LQHeaderScrollView.h"


#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#define SHOW_COUNT     5  // 一个屏幕展现的个数

@interface LQHeaderScrollView ()
{
    UIView *_bgView;
    UIButton *_selectedBtn;
}
@end


@implementation LQHeaderScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _header_scroll = [[UIScrollView alloc] init];
        _header_scroll.showsHorizontalScrollIndicator = NO;
        _header_scroll.bounces = YES;
        [self addSubview:_header_scroll];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _header_scroll.frame = self.bounds;
    _header_scroll.contentSize = CGSizeMake(self.dataArray.count * SCREEN_WIDTH / SHOW_COUNT, 0);
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dataArray.count * SCREEN_WIDTH / SHOW_COUNT, 40)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.header_scroll addSubview:_bgView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 37, SCREEN_WIDTH / SHOW_COUNT, 3)];
    _underLine = line;
    line.backgroundColor = self.underLine_color;
    [self.header_scroll insertSubview:line aboveSubview:_bgView];
    
    for (NSInteger option = 0; option < dataArray.count; option ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(option * SCREEN_WIDTH / SHOW_COUNT, 0, SCREEN_WIDTH / SHOW_COUNT, 40);
        [btn setTitle:[dataArray objectAtIndex:option] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(headerClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = option + 100;
        [_bgView addSubview:btn];
        
        if (option == 0){
            _selectedBtn = btn;
            btn.selected = YES;
        }
    }
}

- (void)setNormal_color:(UIColor *)normal_color
{
    for (int btnTag = 100; btnTag < self.dataArray.count + 100; btnTag ++) {
        UIButton *btn = (UIButton *)[self.header_scroll viewWithTag:btnTag];
        [btn setTitleColor:normal_color forState:UIControlStateNormal];
    }
}

- (void)setSelected_color:(UIColor *)selected_color
{
    for (int btnTag = 100; btnTag < self.dataArray.count + 100; btnTag ++) {
        UIButton *btn = (UIButton *)[self.header_scroll viewWithTag:btnTag];
        [btn setTitleColor:selected_color forState:UIControlStateSelected];
    }
}

- (void)setUnder_Sign:(NSInteger)under_Sign
{
    _under_Sign = under_Sign;
    UIButton *btn = (UIButton *)[self.header_scroll viewWithTag:under_Sign + 100];
    [self headerClickAction:btn];
}

- (void)headerClickAction:(UIButton *)sender
{
    // 用一个UIButton类型的来保存上一次点击的button的地址，下一次比较
    if (_selectedBtn == sender) {
        // 两次点击都是同一个button
    } else {
        sender.selected = YES;
        _selectedBtn.selected = NO;
    }
    _selectedBtn = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        _underLine.frame = CGRectMake(sender.frame.origin.x, 37, SCREEN_WIDTH / SHOW_COUNT, 3);
    }];
    
    // 让选中按钮居中算法
    NSInteger btnCount = self.dataArray.count;  // 总的个数
    NSInteger showCount = SHOW_COUNT; // 一个屏幕个数
    NSInteger min = showCount / 2;
    NSInteger count;
    if (showCount % 2 == 0){
        count = 0;
    } else {
        count = 1;
    }
    NSInteger selectedX = sender.frame.origin.x / (SCREEN_WIDTH / SHOW_COUNT);
    if (selectedX >= btnCount - min && btnCount > 3) {
        UIButton *tempBtn = [self viewWithTag:btnCount - min - count + 100];
        CGFloat btnX = (showCount % 2) ? tempBtn.center.x : (tempBtn.center.x - sender.frame.size.width / 2);
        CGFloat offsetX = self.header_scroll.center.x - btnX;
        [UIView animateWithDuration:0.25 animations:^{
            self.header_scroll.contentOffset = CGPointMake(- offsetX, 0);
        }];
    } else if (selectedX > min && selectedX < btnCount - min && btnCount > showCount) {
        CGFloat btnX  = (showCount % 2 ) ? sender.center.x : (sender.center.x - sender.frame.size.width * 0.5) ;
        CGFloat offsetX = self.header_scroll.center.x - btnX;
        [UIView animateWithDuration:0.25 animations:^{
            self.header_scroll.contentOffset = CGPointMake( - offsetX, 0);
        }];
    } else if (selectedX <= min)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.header_scroll.contentOffset = CGPointMake(0, 0);
        }];
    }
    
    if (self.headerBlock) {
        self.headerBlock(sender.tag);
    }
}
@end
