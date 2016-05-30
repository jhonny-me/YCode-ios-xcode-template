//
//  YCAPIHelper.h
//  test1
//
//  Created by YCode on 16/2/9.
//  Copyright © 2016年 YCode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;

typedef void(^YCAPICompletion)(id response, NSString *error);

@interface YCAPIHelper : NSObject
/**
 *  单例创建实例方法
 *
 *  @return 实例
 */
+ (instancetype)helper;
/**
 *  post请求
 *
 *  @param url        请求url
 *  @param params     请求参数
 *  @param completion 请求完成回调
 */
- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params callback:(YCAPICompletion) completion;

/**
 *  get请求
 *
 *  @param url        请求URL
 *  @param params     请求参数
 *  @param completion 请求完成回调
 */
- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params callback:(YCAPICompletion)completion;
/**
 *  上传图片
 *
 *  @param image      上传的图片
 *  @param params     上传额外参数
 *  @param completion 请求完成回调
 */
- (void)uploadImage:(UIImage *)image withParams:(NSDictionary *)params callback:(YCAPICompletion)completion;

@end

