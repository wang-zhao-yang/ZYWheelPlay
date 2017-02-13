//
//  ZYCirclePlayView.m
//  ZYWheelPlay
//
//  Created by chuanglong03 on 2017/2/13.
//  Copyright © 2017年 chuanglong. All rights reserved.
//

#import "ZYCirclePlayView.h"

@interface ZYCirclePlayView ()

@property (nonatomic, weak)   UIImageView *imgView; // 图片容器
@property (nonatomic, weak)   UIPageControl *pageControl; // 索引指示
@property (nonatomic, assign) NSInteger index; // 图片索引
@property (nonatomic, assign) NSInteger imageCount; // 图片数量
@property (nonatomic, strong) NSTimer *timer; // 定时器
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGesture; // 左滑手势
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGesture; // 右滑手势

@end

@implementation ZYCirclePlayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createdUI];
        [self addGuesture];
    }
    return self;
}

/**
 *  UI界面
 */
- (void)createdUI {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imgView];
    self.imgView = imgView;
    
    CGFloat height = self.bounds.size.height;
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2.0-100, height-50, 200, 50)];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

/**
 *  添加手势
 */
- (void)addGuesture {
    // 1.添加左滑动手势
    _leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureMethod:)];
    _leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:_leftSwipeGesture];
    
    // 2.添加右滑动手势
    _rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gestureMethod:)];
    _rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:_rightSwipeGesture];
}

/**
 *  手势响应方法
 *
 *  @param swipeGesture 响应的手势
 */
- (void)gestureMethod:(UISwipeGestureRecognizer *)swipeGesture {
    [_timer invalidate];
    switch (swipeGesture.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            _index++;
            [self setImageWithIndex:_index];
            [self animationTransitionWithSwipeGestureRecognizerDirection:swipeGesture.direction];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            _index--;
            [self setImageWithIndex:_index];
            [self animationTransitionWithSwipeGestureRecognizerDirection:swipeGesture.direction];
            break;
        default:
            break;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
}

/**
 *  添加转场动画
 *
 *  @param direction 手势方向
 */
- (void)animationTransitionWithSwipeGestureRecognizerDirection:(UISwipeGestureRecognizerDirection)direction {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    // 设置动画的样式
    transition.type = kCATransitionPush;
    if (direction == UISwipeGestureRecognizerDirectionRight) {
        transition.subtype = @"fromLeft";
    } else {
        transition.subtype = @"fromRight";
    }
    [_imgView.layer addAnimation:transition forKey:nil];
}

/**
 *  根据图片数组设置图片
 *
 *  @param imageArray 图片数组
 */
- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    _imageCount = imageArray.count;
    _pageControl.numberOfPages = _imageCount;
    _index = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    [self setImage];
}

/**
 *  定时器响应方法
 */
- (void)timerMethod {
    _index++;
    [self setImageWithIndex:_index];
    [self animationTransitionWithSwipeGestureRecognizerDirection:_leftSwipeGesture.direction];
}

/**
 *  根据手势设置图片
 */
- (void)setImageWithIndex:(NSInteger)index {
    if (index > _imageCount - 1) {
        _index = 0;
    } else if (index < 0) {
        _index = _imageCount - 1;
    }
    [self setImage];
}

/**
 *  设置图片
 */
- (void)setImage {
    self.pageControl.currentPage = self.index;
    _imgView.image = _imageArray[_index];
}

@end
