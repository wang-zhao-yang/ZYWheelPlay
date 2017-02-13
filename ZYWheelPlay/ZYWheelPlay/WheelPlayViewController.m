//
//  WheelPlayViewController.m
//  ZYWheelPlay
//
//  Created by chuanglong03 on 2017/1/3.
//  Copyright © 2017年 chuanglong. All rights reserved.
//

#import "WheelPlayViewController.h"

@interface WheelPlayViewController ()

@end

@implementation WheelPlayViewController

@synthesize scrollView, pageControl, timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self setupTimer];
}

- (void)setupUI {
    [self setupScrollView];
    [self setupPageControl];
}

- (void)setupScrollView {
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, DEVICE_WIDTH, 500)];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = YES;
    scrollView.contentOffset = CGPointMake(DEVICE_WIDTH, 0);
    [self.view addSubview:scrollView];
}

- (void)setupPageControl {
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2.0-100, CGRectGetMaxY(scrollView.frame)-50, 200, 50)];
    pageControl.numberOfPages = self.imageAry.count;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:pageControl];
}

- (void)setupTimer {
    timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [timer invalidate];
    timer = nil;
}

- (void)autoPlay {
    
}

- (NSArray *)imageAry {
    if(_imageAry == nil) {
        _imageAry = [[NSArray alloc] initWithObjects:@"pic0", @"pic1", @"pic2", @"pic3", @"pic4", nil];
    }
    return _imageAry;
}

@end
