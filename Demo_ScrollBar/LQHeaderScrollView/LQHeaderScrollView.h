//
//  LQHeaderScrollView.h
//  Demo_ScrollBar
//
//  Created by Liuquan on 16/8/15.
//  Copyright © 2016年 Liuquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^headerBlock)(NSInteger selectedIndex);

@interface LQHeaderScrollView : UIView
/**< 数据源数组*/
@property (nonatomic, strong) NSArray *dataArray;

/**< 按钮文字选中颜色*/
@property (nonatomic, strong) UIColor *selected_color;

/**< 按钮文字默认颜色*/
@property (nonatomic, strong) UIColor *normal_color;

/**< 下划线颜色*/
@property (nonatomic, strong) UIColor *underLine_color;

/**< 顶部scrollView */
@property (nonatomic, strong) UIScrollView *header_scroll;

/**< 下划线 */
@property (nonatomic, strong) UIView *underLine;

/**< 选中的下标 */
@property (nonatomic, assign) NSInteger under_Sign;

@property (nonatomic, copy) headerBlock headerBlock;

@end
