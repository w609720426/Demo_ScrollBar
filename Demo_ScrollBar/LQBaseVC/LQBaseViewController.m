//
//  LQBaseViewController.m
//  Demo_ScrollBar
//
//  Created by Liuquan on 16/8/15.
//  Copyright © 2016年 Liuquan. All rights reserved.
//

/*-----------------------------------------------------------------------------------------------
/
/                           这个就是用来展示的控制器，业务逻辑写这里
/
/----------------------------------------------------------------------------------------------*/


#import "LQBaseViewController.h"

@interface LQBaseViewController ()

@end

@implementation LQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 200, 30);
    label.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16.0f];
    label.text = self.dataArray[self.seletedIndex];
    [self.view addSubview:label];
}

@end
