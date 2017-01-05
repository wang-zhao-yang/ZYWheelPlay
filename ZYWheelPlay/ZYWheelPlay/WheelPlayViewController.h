//
//  WheelPlayViewController.h
//  ZYWheelPlay
//
//  Created by chuanglong03 on 2017/1/3.
//  Copyright © 2017年 chuanglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelPlayViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) NSArray       *imageAry;

- (void)setupScrollView;
- (void)setupTimer;
- (void)stopTimer;
- (void)autoPlay;

@end
