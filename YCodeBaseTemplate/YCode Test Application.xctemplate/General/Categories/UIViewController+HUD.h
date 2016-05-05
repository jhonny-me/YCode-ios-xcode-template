//
//  UIViewController+HUD.h
//  test1
//
//  Created by YCode on 16/2/10.
//  Copyright © 2016年 com.ycode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)
/**
 *  在self.view中间显示小菊花
 *
 *  @param hint 提示信息
 */
- (void)showHUDInSelfViewWithHint:(NSString *)hint;
/**
 *  在距离屏幕底部100的位置显示一行字
 *
 *  @param hint 提示信息
 */
- (void)showHint:(NSString *)hint;
/**
 *  在距离屏幕中间的偏移offset的位置显示一行字，向下为正
 *
 *  @param hint   提示信息
 *  @param offset 偏移量
 */
- (void)showHint:(NSString *)hint yOffset:(CGFloat) offset;
/**
 *  隐藏self.view的HUD
 */
- (void)hideHUD;
/**
 *  显示alertView
 *
 *  @param hint 提示信息
 */
- (void)showAlertViewWithHint:(NSString *)hint;

@end
