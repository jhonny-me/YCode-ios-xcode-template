//
//  NSTimer+Convenience.m
//  NSTimerBlock
//
//  Created by 杨权 on 16/3/23.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "NSTimer+Convenience.h"

@implementation NSTimer (Convenience)


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    repeats:(BOOL)repeats
                                   callback:(YCVoidBlock)callback {
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(onTimerUpdateBlock:)
                                          userInfo:[callback copy]
                                           repeats:repeats];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      count:(NSInteger)count
                                   callback:(YCVoidBlock)callback {
    NSDictionary *userInfo = @{@"callback"     : [callback copy],
                               @"count"        : @(count)};
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(onTimerUpdateCountBlock:)
                                          userInfo:userInfo
                                           repeats:YES];
}

+ (void)onTimerUpdateBlock:(NSTimer *)timer {
    YCVoidBlock block = timer.userInfo;
    
    if (block) {
        block();
    }
}

+ (void)onTimerUpdateCountBlock:(NSTimer *)timer {
    static NSUInteger currentCount = 0;
    
    NSDictionary *userInfo = timer.userInfo;
    YCVoidBlock callback = userInfo[@"callback"];
    NSNumber *count = userInfo[@"count"];
    
    if (count.integerValue <= 0) {
        if (callback) {
            callback();
        }
    } else {
        if (currentCount < count.integerValue) {
            currentCount++;
            if (callback) {
                callback();
            }
        } else {
            currentCount = 0;
            
            [timer unfireTimer];
            [timer invalidate];
            timer = nil;
        }
    }
}

- (void)fireTimer {
    [self setFireDate:[NSDate distantPast]];
}

- (void)unfireTimer {
    [self setFireDate:[NSDate distantFuture]];
}

@end
