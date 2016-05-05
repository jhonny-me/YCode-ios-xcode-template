//
//  NSTimer+Convenience.h
//  NSTimerBlock
//
//  Created by 杨权 on 16/3/23.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Convenience)

/**
 *  无参无返回值Block
 */
typedef void (^YCVoidBlock)(void);


/**
 *  NSTimer - Block1
 *
 *  @param interval 定时器时间间隔
 *  @param repeats  是否重复
 *  @param callback 回调Block
 *
 *  @return NSTimer
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    repeats:(BOOL)repeats
                                   callback:(YCVoidBlock)callback;


/**
 *  NSTimer - Block2
 *
 *  @param interval 定时器时间间隔
 *  @param count    循坏次数
 *  @param callback 回调Block
 *
 *  @return NSTimer
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      count:(NSInteger)count
                                   callback:(YCVoidBlock)callback;


/**
 *  开始启动定时器
 */
- (void)fireTimer;

/**
 *  暂停定时器
 */
- (void)unfireTimer;


@end
