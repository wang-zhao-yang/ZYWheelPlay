//
//  WheelPlayByOneImageViewVC.m
//  ZYWheelPlay
//
//  Created by chuanglong03 on 2017/2/13.
//  Copyright © 2017年 chuanglong. All rights reserved.
//

#import "WheelPlayByOneImageViewVC.h"
#import "ZYCirclePlayView.h"

@interface WheelPlayByOneImageViewVC ()

@end

@implementation WheelPlayByOneImageViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    ZYCirclePlayView *circlePlayView = [[ZYCirclePlayView alloc] initWithFrame:CGRectMake(0, 50, DEVICE_WIDTH, 500)];
    circlePlayView.imageArray = self.imageAry;
    [self.view addSubview:circlePlayView];
}

- (NSArray *)imageAry {
    if(_imageAry == nil) {
        _imageAry = [NSMutableArray array];
        for (NSInteger i = 0; i < 5; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pic%ld", i]];
            [_imageAry addObject:image];
        }
    }
    return _imageAry;
}

@end
