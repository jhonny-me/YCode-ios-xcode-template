//
//  YCBannerScrollView.h
//  YCBannerScrollView
//
//  Created by 杨权 on 16/3/14.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AutoScrollTime 2.0f

@class YCPageControl;
@class YCBannerScrollView;

@protocol YCBannerScrollViewDelegate <NSObject>

- (void)YCBannerScrollView:(YCBannerScrollView *)scrollView didSelectAtIndex:(NSUInteger) index;

@end

/**
 *  YCBannerScrollView依赖SDWebImage
 */
@interface YCBannerScrollView : UIView <UIScrollViewDelegate>
    
@property (assign, nonatomic) NSInteger lastIndex;

/**
 *  代理
 */
@property (nonatomic, weak) id<YCBannerScrollViewDelegate> delegate;
/**
 *  baseImageUrl
 *  当imageUrlArr中存放完整的URL时，请勿给该属性赋值
 */
@property (nonatomic, copy) NSString *baseImageUrl;
/**
 *  Banner图集
 *  imageUrlArr内的元素必须是以下两种格式
 *  1.完整的URL
 *  2.图片名（baseImageUrl不为空）
 *  3.UIImage
 */
@property (nonatomic, strong) NSArray *imageArr;
/**
 *  是否自动滚动
 */
@property (nonatomic, assign) BOOL autoScroll;

@end
