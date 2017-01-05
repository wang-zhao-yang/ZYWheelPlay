//
//  WheelPlayByThreeImageViewVC.m
//  ZYWheelPlay
//
//  Created by chuanglong03 on 2017/1/3.
//  Copyright © 2017年 chuanglong. All rights reserved.
//

#import "WheelPlayByThreeImageViewVC.h"

@interface WheelPlayByThreeImageViewVC ()

@end

@implementation WheelPlayByThreeImageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3 张 ImageView";
}

- (void)setupScrollView {
    [super setupScrollView];
    NSInteger count = self.imageAry.count;
    self.scrollView.contentSize = CGSizeMake(3 * DEVICE_WIDTH, 500);
    self.scrollView.delegate = self;
    for (NSInteger i = 0; i < 3; i++) {
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
    if (offsetX == 0) {
        [self currentPageDown];
        [self resetImagesAndContentOffset];
    } else if (offsetX == 2 * DEVICE_WIDTH) {
        [self currentPageUp];
        [self resetImagesAndContentOffset];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setupTimer];
}

- (void)currentPageDown {
    NSInteger count = self.imageAry.count;
    NSInteger currentIndex = (self.pageControl.currentPage - 1 + count) % count;
    self.pageControl.currentPage = currentIndex;
}

- (void)currentPageUp {
    NSInteger currentIndex = (self.pageControl.currentPage + 1) % self.imageAry.count;
    self.pageControl.currentPage = currentIndex;
}

- (void)resetImagesAndContentOffset {
    NSInteger currentPage = self.pageControl.currentPage;
    NSInteger count = self.imageAry.count;
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        NSInteger imageIndex = 0;
        switch (i) {
            case 0:
                imageIndex = currentPage - 1;
                if (imageIndex < 0) {
                    imageIndex = count - 1;
                }
                break;
            case 1:
                imageIndex = currentPage;
                break;
            case 2:
                imageIndex = currentPage + 1;
                if (imageIndex > count - 1) {
                    imageIndex = 0;
                }
                break;
        }
        imageView.image = [UIImage imageNamed:self.imageAry[imageIndex]];
    }
    [self.scrollView setContentOffset:CGPointMake(DEVICE_WIDTH, 0) animated:NO];
}

- (void)autoPlay {
    [super autoPlay];
    [self.scrollView setContentOffset:CGPointMake(2 * DEVICE_WIDTH, 0) animated:YES];
}

@end
