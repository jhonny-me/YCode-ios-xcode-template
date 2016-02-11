//
//  YCDEFINE.h
//  YCCommonUseManager
//
//  Created by YCode on 15/7/31.
//  Copyright (c) 2015年 com.ycode. All rights reserved.
//

#import <UIKit/UIKit.h>
// 各种尺寸
// 屏幕宽度
#define YC_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define YC_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// keyWindow,用于计算坐标
#define YC_KEYWINDOW [UIApplication sharedApplication].keyWindow
//获取键盘的高度
/*
 iphone 6:
 中文
 2014-12-31 11:16:23.643 Demo[686:41289] 键盘高度是  258
 2014-12-31 11:16:23.644 Demo[686:41289] 键盘宽度是  375
 英文
 2014-12-31 11:55:21.417 Demo[1102:58972] 键盘高度是  216
 2014-12-31 11:55:21.417 Demo[1102:58972] 键盘宽度是  375
 
 iphone  6 plus：
 英文：
 2014-12-31 11:31:14.669 Demo[928:50593] 键盘高度是  226
 2014-12-31 11:31:14.669 Demo[928:50593] 键盘宽度是  414
 中文：
 2015-01-07 09:22:49.438 Demo[622:14908] 键盘高度是  271
 2015-01-07 09:22:49.439 Demo[622:14908] 键盘宽度是  414
 
 iphone 5 :
 2014-12-31 11:19:36.452 Demo[755:43233] 键盘高度是  216
 2014-12-31 11:19:36.452 Demo[755:43233] 键盘宽度是  320
 
 ipad Air：
 2014-12-31 11:28:32.178 Demo[851:48085] 键盘高度是  264
 2014-12-31 11:28:32.178 Demo[851:48085] 键盘宽度是  768
 
 ipad2 ：
 2014-12-31 11:33:57.258 Demo[1014:53043] 键盘高度是  264
 2014-12-31 11:33:57.258 Demo[1014:53043] 键盘宽度是  768
 */
// 键盘高度
#define YC_KEYBOARD_HEIGHT 216.f
#define YC_KEYBOARD_ANIMATE_DURATION 0.3f
// 宏定义判断系统
#define YC_DEVICE_VERSION [[[UIDevice currentDevice] systemVersion] integerValue]
// 是否是ipad
#define YC_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define YC_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define YC_IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define YC_SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define YC_SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define YC_IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define YC_IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define YC_IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define YC_IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
