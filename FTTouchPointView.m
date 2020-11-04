//
//  FTTouchPointView.m
//  Example
//
//  Created by wuzhikun on 2020/11/4.
//

#import "FTTouchPointView.h"

#define HideInterval    20/// 20秒后自动隐藏

NSTimeInterval ft_lastShowInterval;
NSInteger ft_pointShowCount;

@interface FTTouchPointView ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger alphaIndex;
@end

@implementation FTTouchPointView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        
        NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
        if (now-ft_lastShowInterval > 20) {
            ft_pointShowCount = 0;
            ft_lastShowInterval = now;
        }
        ft_pointShowCount ++;
        NSInteger redValue = labs(255-ft_pointShowCount*5);
        self.backgroundColor = [UIColor colorWithRed:redValue/255.0 green:0 blue:0 alpha:0.7];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self startAutoHideTimer];
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self stopAutoHideTimer];
}


#pragma mark - Timer
- (void)startAutoHideTimer {
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        weakSelf.alphaIndex ++;
        if (weakSelf.alphaIndex >= HideInterval) {
            [weakSelf removeFromSuperview];
        } else {
            weakSelf.alpha = (1-weakSelf.alphaIndex/(CGFloat)HideInterval);
        }
    }];
}

- (void)stopAutoHideTimer {
    if (_timer) {
        [_timer invalidate];
    }
}

@end
