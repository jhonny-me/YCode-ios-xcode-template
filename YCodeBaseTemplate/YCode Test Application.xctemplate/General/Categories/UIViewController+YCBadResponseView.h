//
//  UIViewController+YCBadResponseView.h
//  ToDoiOS
//
//  Created by 顾强 on 16/2/24.
//  Copyright © 2016年 jhonny.copper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCBadResponseView : UIButton
/**
 *  初始化方法
 *
 *  @param frame frame，一般就用self.view.frame,不过有个bug,origin强制用的(0,0)
 *  @param title 标题，目前没有卵用，传了也不设置
 *
 *  @return self
 */
- (instancetype _Nonnull)initWithFrame:(CGRect)frame title:(NSString * _Nonnull)title;

@end

@interface UIViewController (YCBadResponseView)
/**
 *  显示错误连接的view
 *
 *  @param hint   提示语，目前没有卵用，传了也不设置
 *  @param action 用来设置点击事件，一般是重新发送请求
 */
- (void)showBadResponseViewWithHint:(NSString * _Nonnull)hint tapAction:(SEL _Nonnull)action;
/**
 *  隐藏错误连接的view
 */
- (void)hideBadResponseView;

@end
