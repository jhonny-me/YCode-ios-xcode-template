//
//  UIViewController+YCBadResponseView.m
//  ToDoiOS
//
//  Created by 顾强 on 16/2/24.
//  Copyright © 2016年 jhonny.copper. All rights reserved.
//

#import "UIViewController+YCBadResponseView.h"

#define YCBadResponseHintString @"请求超时,请点击重试"
#define YCBadResponseImageName  @"logo"

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
    [badResponseView addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:badResponseView];
}

- (void)hideBadResponseView{
    for (UIView *view in self.view.subviews) {
        if ([view isMemberOfClass:[YCBadResponseView class]]) {
            YCBadResponseView *badView = (YCBadResponseView *)view;
            [badView removeFromSuperview];
            badView = nil;
        }
    }
}

@end
