//
//  LQBaseViewController.h
//  Demo_ScrollBar
//
//  Created by Liuquan on 16/8/15.
//  Copyright © 2016年 Liuquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQBaseViewController : UIViewController

/**< 数据源数组 */
@property (nonatomic, strong) NSArray *dataArray;

/**< 选中的下标 */
@property (nonatomic, assign) NSInteger seletedIndex;

@end
