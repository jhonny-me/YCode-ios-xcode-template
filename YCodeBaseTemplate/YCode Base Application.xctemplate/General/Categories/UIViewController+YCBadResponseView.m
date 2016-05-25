//
//  UIViewController+YCBadResponseView.m
//  ToDoiOS
//
//  Created by 顾强 on 16/2/24.
//  Copyright © 2016年 jhonny.copper. All rights reserved.
//

#import "UIViewController+YCBadResponseView.h"
#import <objc/runtime.h>

static NSString *const YCBadResponseHintString = @"请求超时,请点击重试";
static NSString *const YCBadResponseImageName = @"logo";

@implementation YCBadResponseView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString * _Nonnull)title{
    self = [super initWithFrame:frame];

    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setImage:[UIImage imageNamed:YCBadResponseImageName] forState:UIControlStateNormal];
        
        [self setTitle:YCBadResponseHintString forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake((contentRect.size.width - 80)/2, contentRect.size.height/2 -80, 80, 80);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height/2 +10, contentRect.size.width, 44);
}

@end

@implementation UIViewController (YCBadResponseView)

- (void)showBadResponseViewWithHint:(NSString *)hint tapAction:(SEL)action{
    
    [self hideBadResponseView];
    
    CGRect fixedRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    YCBadResponseView *badResponseView = [[YCBadResponseView alloc] initWithFrame:fixedRect title:hint];
    [badResponseView addTarget:[YCAPIHelper helper] action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:badResponseView];
}

- (void)hideBadResponseView{
    for (UIView *view in self.view.subviews) {
        if ([view isMemberOfClass:[YCBadResponseView class]]) {
            [view removeFromSuperview];
        }
    }
}

@end

#pragma mark - AFNetworking(BadResponseView)

/**
 *  获得当前的ViewController
 *
 *  @return UIViewController
 */
static inline UIViewController * getCurrentViewController(){
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
            result = window.rootViewController;
    }
    return result;
}


/**
 *  保存最后一次请求
 */
@interface YCAPIRequestStore : NSObject

@property (copy, nonatomic, readonly) NSString *urlString;
@property (strong, nonatomic, readonly) NSMutableDictionary *params;
@property (copy, nonatomic, readonly) YCAPICompletion completion;
/**
 *  GET,POST,HEAD,PUT,DELETE; default is POST
 */
@property (copy, nonatomic, readwrite) NSString *requestMethod;
@property (assign, nonatomic, readwrite) BOOL showAutomatically;//flag for automatic show bad view; default is YES

- (instancetype)initWithURL:(NSString *)urlString params:(NSDictionary *)params completion:(YCAPICompletion)completion;

- (void)setupWithURL:(NSString *)urlString params:(NSDictionary *)params completion:(YCAPICompletion)completion;

- (void)clear;

@end

@implementation YCAPIRequestStore{
    NSString *_urlString;
    NSMutableDictionary *_params;
    YCAPICompletion _completion;
}

- (instancetype)initWithURL:(NSString *)urlString params:(NSDictionary *)params completion:(YCAPICompletion)completion{
    self = [super init];
    if (!self) return nil;
    
    [self setupWithURL:urlString params:params completion:completion];
    _requestMethod = @"POST";
    _showAutomatically = YES;
    return self;
}

- (void)setupWithURL:(NSString *)urlString params:(NSDictionary *)params completion:(YCAPICompletion)completion{
    _urlString = urlString;
    _params = [NSMutableDictionary dictionaryWithDictionary:params];
    _completion = completion;
}

- (void)clear{
    _urlString = nil;
    _params = nil;
    _completion = nil;
    _requestMethod = @"post";
    _showAutomatically = YES;
}
@end

@implementation YCAPIHelper (YCBadResponseView)

- (void)postWithUrl:(NSString *)url params:(NSDictionary *)params callback:(YCAPICompletion)completion showFailureViewAutomatic:(BOOL)automatic{
    [self requestWithHTTPMethod:@"POST" URLString:url params:params completion:completion showFailureViewAutomatic:automatic];
}

- (void)getWithUrl:(NSString *)url params:(NSDictionary *)params callback:(YCAPICompletion)completion showFailureViewAutomatic:(BOOL)automatic{
    [self requestWithHTTPMethod:@"GET" URLString:url params:params completion:completion showFailureViewAutomatic:automatic];
}

- (void)requestWithHTTPMethod:(NSString *)method URLString:(NSString *)url params:(NSDictionary *)params completion:(YCAPICompletion)completion showFailureViewAutomatic:(BOOL)automatic{
    // store request
    YCAPIRequestStore *store = [[YCAPIRequestStore alloc] initWithURL:url params:params completion:completion];
    store.requestMethod = method;
    store.showAutomatically = automatic;
    self.store = store;
    
    YCAPICompletion newCompletion = ^(id response, NSString *err){
        if (!err) {
            [self.store clear];
        }
        
        UIViewController *currentVC = getCurrentViewController();
        if (err && automatic) {
            // show bad response view
            [currentVC showBadResponseViewWithHint:err tapAction:@selector(restartLastRequestWithAdditionalParams:)];
        }else{
            [currentVC hideBadResponseView];
        }
        completion(response, err);
    };
  
    if ([method isEqualToString:@"POST"]) {
        [self postWithUrl:url params:params callback:newCompletion];
    }else if ([method isEqualToString:@"GET"]){
        [self getWithUrl:url params:params callback:newCompletion];
    }
}

- (void)restartLastRequestWithAdditionalParams:(NSDictionary *)params{
    YCAPIRequestStore *store = self.store;
    if ([params isMemberOfClass:[NSDictionary class]]) {
        [store.params addEntriesFromDictionary:params];
    }
    [self requestWithHTTPMethod:store.requestMethod URLString:store.urlString params:store.params completion:store.completion showFailureViewAutomatic:store.showAutomatically];
}

- (YCAPIRequestStore *)store{
    return objc_getAssociatedObject(self, &YCBadResponseHintString);
}

- (void)setStore:(YCAPIRequestStore *)store{
    objc_setAssociatedObject(self, &YCBadResponseHintString, store, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
