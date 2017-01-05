//
//  WheelPlayByManyImageViewVC.m
//  ZYWheelPlay
//
//  Created by chuanglong03 on 2017/1/3.
//  Copyright © 2017年 chuanglong. All rights reserved.
//

#import "WheelPlayByManyImageViewVC.h"

@interface WheelPlayByManyImageViewVC ()

@end

@implementation WheelPlayByManyImageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多张 ImageView";
}

- (void)setupScrollView {
    [super setupScrollView];
    NSInteger count = self.imageAry.count;
    self.scrollView.contentSize = CGSizeMake((count + 1) * DEVICE_WIDTH, 500);
    self.scrollView.delegate = self;
    for (NSInteger i = 0; i < count + 1; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * DEVICE_WIDTH, 0, DEVICE_WIDTH, 500)];
        NSString *imageName = self.imageAry[count-1];
        if (i != 0) {
            imageName = self.imageAry[i-1];
        }
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger count = self.imageAry.count;
    if (offsetX < 0) {
        [scrollView setContentOffset:CGPointMake(count * DEVICE_WIDTH, 0) animated:NO];
    } else if (offsetX > count * DEVICE_WIDTH) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self changePageControlCurrentPage:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self changePageControlCurrentPage:scrollView];
}

- (void)changePageControlCurrentPage:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/DEVICE_WIDTH;
    NSInteger currentIndex = self.imageAry.count - 1;
    if (index != 0) {
        currentIndex = index - 1;
    }
    self.pageControl.currentPage = currentIndex;
}

- (void)autoPlay {
    [super autoPlay];
    CGFloat offsetX = self.scrollView.contentOffset.x;
    NSInteger count = self.imageAry.count;
    CGFloat imageViewX = DEVICE_WIDTH;
    if (offsetX > (count - 1) * DEVICE_WIDTH) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    } else {
        imageViewX += offsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(imageViewX, 0) animated:YES];
}

@end
