//
//  CountDown.m
//  Aiparking
//
//  Created by 王春平 on 15/9/15.
//  Copyright (c) 2015年 王春平. All rights reserved.
//

#import "CountDown.h"

@implementation CountDown

- (void)startTimer:(NSInteger)totalTime {
    __block NSInteger timeout = totalTime - 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                /**
                 *  @"status":定时器开关状态，计时到0时关闭定时器
                    @"timer":定时器当前显示的数值
                 */
                if ([self.delegate respondsToSelector:@selector(getTimerParam:)]) {
                    [self.delegate getTimerParam:@{@"status": @(NO), @"timer":@""}];
                }
            });
        } else {
            NSInteger second = timeout % totalTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.delegate respondsToSelector:@selector(getTimerParam:)]) {
                    [self.delegate getTimerParam:@{@"status": @(YES), @"timer":[NSString stringWithFormat:@"%ld", (long)second]}];
                }
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
