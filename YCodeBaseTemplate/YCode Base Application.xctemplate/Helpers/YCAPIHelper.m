//
//  YCAPIHelper.m
//  test1
//
//  Created by YCode on 16/2/9.
//  Copyright © 2016年 YCode. All rights reserved.
//

#import "YCAPIHelper.h"
#import "AFNetworking.h"

static NSString *const YCNetworkErr = @"网络错误";
static NSString *const YCUploadURL  = @"<#上传URL#>";

@implementation YCAPIHelper{
    AFHTTPSessionManager *_manager;
    
    BOOL _isProcessing;
}

+ (instancetype)helper{
    static YCAPIHelper *helper = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[YCAPIHelper alloc] init];
    });
    
    return helper;
}

- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion{
    
    if (_isProcessing == YES) {
        
        return completion(nil, @"There is another request in process.");
    }
    _isProcessing = YES;
    
    if (!params) {
        params = [NSDictionary dictionary];
    }
    
    [_manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _isProcessing = NO;
        
        if (!responseObject) {
            return completion(nil, YCNetworkErr);
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        NSNumber *statusCode = response[@"code"];
        
        if (statusCode.intValue == 1) {
            return completion(nil, response[@"msg"]);
        }
        
        completion(response[@"data"], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _isProcessing = NO;
        completion(nil, error.localizedDescription);
    }];
}

- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion{

    if (_isProcessing == YES) {
        
        return completion(nil, @"There is another request in process.");
    }
    _isProcessing = YES;
    
    if (!params) {
        params = [NSDictionary dictionary];
    }
    
    [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _isProcessing = NO;
        
        if (!responseObject) {
            return completion(nil, YCNetworkErr);
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        NSNumber *statusCode = response[@"status"];
        
        if (statusCode.intValue == 0) {
            return completion(nil, response[@"msg"]);
        }
        
        completion(response[@"data"], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        _isProcessing = NO;
        completion(nil, error.localizedDescription);
    }];
    
}

- (void)uploadImage:(UIImage *)image withParams:(NSDictionary *)params callback:(void(^)(id response, NSString *error))completion{
    NSData *data = UIImageJPEGRepresentation(image, .6f);
    
    [_manager POST:YCUploadURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data
                                    name:@"file"
                                fileName:@"file.jpeg"
                                mimeType:@"image/jpeg"];
    }progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        if (!responseObject) {
            return completion(nil, YCNetworkErr);
        }
        
        NSDictionary *response = (NSDictionary *)responseObject;
        NSNumber *statusCode = response[@"status"];
        
        if (statusCode.intValue == 0) {
            return completion(nil, response[@"msg"]);
        }
        
        completion(response[@"data"], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error.localizedDescription);
    }];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _isProcessing = NO;
    
    _manager = [AFHTTPSessionManager manager];
    [_manager.requestSerializer setTimeoutInterval:40.f];
    _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/plain",@"text/html"]];
}

@end
