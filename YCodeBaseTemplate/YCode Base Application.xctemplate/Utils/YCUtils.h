//
//  YCUtils.h
//  matro_ecommerce_ios
//
//  Created by 徐章 on 16/2/29.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YCUtils : NSObject
#pragma mark - Common Methods
/**
 *  自适应label的size
 *
 *  @param label     自适应的label
 *  @param width     给定一个宽度
 *  @param lineSpace 行间距，没有填0
 *  @param font      字体大小
 *
 *  @return size
 */
+ (CGSize)stringAdaptive:(NSString *)content width:(CGFloat)width lineSpace:(CGFloat)lineSpace font:(CGFloat)font mode:(NSLineBreakMode)lineBrekMode;

/**
 *  自适应label的size
 *
 *  @param label     自适应的label
 *  @param width     给定一个高度
 *  @param lineSpace 行间距，没有填0
 *  @param font      字体大小
 *
 *  @return size
 */
+ (CGSize)stringAdaptive:(NSString *)content height:(CGFloat)height lineSpace:(CGFloat)lineSpace font:(CGFloat)font mode:(NSLineBreakMode)lineBrekMode;

/**
 *  获得当前的ViewController
 *
 *  @return UIViewController
 */
+ (UIViewController *)getCurrentViewController;

#pragma mark - About Empty Object
/**
 *  判断是否为nil、NSNull
 *
 *  @param object 被判断的对象
 *
 *  @return BOOL
 */
+ (BOOL)judgeIsEmptyObject:(id)object;

/**
 *  将是为nil、NSNull进行转换
 *
 *  @param object   被判断对象
 *  @param toObject 转换后对象
 *
 *  @return toObject
 */
+ (id)changeEmptyObject:(id)object to:(id)toObject;

#pragma mark - About Local Data
/**
 *  将数据存到NSUserDefault
 *
 *  @param content 保存的内容
 *  @param key     键值
 */
+ (void)saveDataToLocal:(id)data key:(NSString *)key;

/**
 *  从NSUserDefault读取数据
 *
 *  @param key 键值
 *
 *  @return 数据
 */
+ (id)getDataFromLocal:(NSString *)key;
#pragma mark - About UI
/**
 *  提示框
 *
 *  @param message 内容
 */
+ (void)showAlertView:(NSString *)message;
@end
