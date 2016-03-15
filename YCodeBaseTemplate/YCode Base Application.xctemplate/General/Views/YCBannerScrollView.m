//
//  YCBannerScrollView.m
//  YCBannerScrollView
//
//  Created by 杨权 on 16/3/14.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "YCBannerScrollView.h"
#import "YCPageControl.h"
#import "UIImageView+WebCache.h"

@interface YCBannerScrollView () {

    UIScrollView  *_bannerScrollView;
    YCPageControl *_pageControl;
}

@end

@implementation YCBannerScrollView

#pragma mark - Init

//通过纯代码创建View
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        if (_bannerScrollView == nil) {
            _bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, frame.size.width, frame.size.height)];
        }
    }
    
    return self;
}

//通过Xib创建View
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super initWithCoder:aDecoder]) {
        if (_bannerScrollView == nil) {
            _bannerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        }
    }
    
    return self;
}

#pragma mark - Set_Methods
- (void)setImageArr:(NSArray *)imageArr{
    
    _imageArr = imageArr;
    if (_imageArr.count > 0) {
       [self setScrollViewContent];
    }
}

- (void)setAutoScroll:(BOOL)autoScroll{
    
    _autoScroll = autoScroll;
    if (_autoScroll == YES) {
        
        [self createTimer];
    }
}

#pragma mark - Private_Methods

/**
 *  设置_bannerScrollView
 */
- (void)setScrollViewContent {
        
    _bannerScrollView.pagingEnabled = YES;
    _bannerScrollView.showsVerticalScrollIndicator = NO;
    _bannerScrollView.showsHorizontalScrollIndicator = NO;
    _bannerScrollView.scrollEnabled = YES;
    _bannerScrollView.delegate = self;
    [self addSubview:_bannerScrollView];
    
    _bannerScrollView.contentSize = CGSizeMake(_bannerScrollView.frame.size.width * (_imageArr.count+2), _bannerScrollView.frame.size.height);
    
    _bannerScrollView.contentOffset = CGPointMake(_bannerScrollView.frame.size.width, 0);
    
    for (int i=0; i<_imageArr.count; i++) {
        CGRect frame = CGRectMake(_bannerScrollView.frame.size.width * (i+1), 0, _bannerScrollView.frame.size.width, _bannerScrollView.frame.size.height);
        [self setImageViewFrame:frame index:i];
    }
    
    //无限循环--最后一张图
    CGRect lastFrame = CGRectMake(_bannerScrollView.frame.size.width * (_imageArr.count + 1), 0, _bannerScrollView.frame.size.width, _bannerScrollView.frame.size.height);
    [self setImageViewFrame:lastFrame index:_imageArr.count-1];
    
    //无限循环--最前一张图
    CGRect firstframe = CGRectMake(0, 0, _bannerScrollView.frame.size.width, _bannerScrollView.frame.size.height);
    [self setImageViewFrame:firstframe index:0];
    
    [self initPageController];
    [self addTapGesture];
    
}

- (void)setImageViewFrame:(CGRect)frame index:(NSUInteger)index{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    
    if ([_imageArr[index] isKindOfClass:[NSString class]]) {
        //完整的URL
        if (_baseImageUrl == nil) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageArr[index]] placeholderImage:[UIImage imageNamed:@"default"]];
        }
        else {
            //不完整的URL
            NSString *url = [NSString stringWithFormat:@"%@%@",_baseImageUrl,_imageArr[index]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default"]];
        }
    }
    else {
        //UIImage
        [imageView setImage:_imageArr[index]];
    }
    
    [_bannerScrollView addSubview:imageView];
}

/**
 *  创建pageControl
 */
- (void)initPageController{
    
    _pageControl = [[YCPageControl alloc] initWithFrame:CGRectMake(0,_bannerScrollView.frame.origin.y + _bannerScrollView.frame.size.height - 20, _bannerScrollView.frame.size.width, 20)];
    _pageControl.numberOfPages = _imageArr.count;
    _pageControl.currentPage = 0;
    
    [self addSubview:_pageControl];
}

- (void)addTapGesture{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnImageView)];
    [self addGestureRecognizer:tapGesture];
}

- (void)didTapOnImageView{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(YCBannerScrollView:didSelectAtIndex:)]) {
        
        [self.delegate YCBannerScrollView:self didSelectAtIndex:_pageControl.currentPage];
    }
}

/**
 *  创建定时器
 */
- (void)createTimer{
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:AutoScrollTime target:self selector:@selector(changePage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

/**
 *  自动换页
 */
- (void)changePage{
    
    NSInteger index = _pageControl.currentPage;
    index++;
    //无缝切换
    [_bannerScrollView scrollRectToVisible:CGRectMake(_bannerScrollView.frame.size.width* (index + 1), 0, _bannerScrollView.frame.size.width, _bannerScrollView.frame.size.height) animated:YES];
}

#pragma mark UIScrollView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat index = scrollView.contentOffset.x/_bannerScrollView.frame.size.width;
    
    
    if (index == _imageArr.count + 1) {
        
        _bannerScrollView.contentOffset = CGPointMake(_bannerScrollView.frame.size.width,0);
        _pageControl.currentPage = 0;
        return;
    }else if (index == 0){
        
        _bannerScrollView.contentOffset = CGPointMake(_bannerScrollView.frame.size.width * _imageArr.count, 0);
        
        _pageControl.currentPage = _imageArr.count - 1;
        
        return;
    }
    
    _pageControl.currentPage = index - 1;
    
}

@end
