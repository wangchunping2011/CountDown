//
//  CountDown.h
//  Aiparking
//
//  Created by 王春平 on 15/9/15.
//  Copyright (c) 2015年 王春平. All rights reserved.
//

#import <Foundation/Foundation.h>
//倒计时
@protocol CountDownDelegate <NSObject>

@optional
//parameter存放计时器的启动状态和当前记录的时间
- (void)getTimerParam:(NSDictionary *)parameter;

@end

@interface CountDown : NSObject

@property (nonatomic, weak) id<CountDownDelegate>delegate;

- (void)startTimer:(NSInteger)totalTime;//totalTime：倒计时的开始时间

@end
