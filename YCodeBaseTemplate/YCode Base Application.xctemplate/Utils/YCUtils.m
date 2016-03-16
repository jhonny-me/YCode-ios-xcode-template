//
//  YCUtils.m
//  matro_ecommerce_ios
//
//  Created by 徐章 on 16/2/29.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "YCUtils.h"

@implementation YCUtils
#pragma mark - Common Methods
/**
 *  自适应label的frame
 *
 *  @param label     自适应的label
 *  @param width     如果自适应高度，给定一个宽度，高度填0
 *  @param lineSpace 行间距，没有填0
 *  @param font      字体大小
 */
+ (CGSize)stringAdaptive:(NSString *)content width:(CGFloat)width lineSpace:(CGFloat)lineSpace font:(CGFloat)font mode:(NSLineBreakMode)lineBrekMode{
    
    NSMutableParagraphStyle *paragraphStyle = ({
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];;
        
        [style setLineBreakMode:lineBrekMode];
        
        if (lineSpace != 0) {
            
            style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:lineSpace];//调整行间距
        }
        
        style;
        
    });
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{
                                                  NSFontAttributeName:[UIFont systemFontOfSize:font],
                                                  NSParagraphStyleAttributeName:paragraphStyle
                                                  }
                                        context:nil].size;
    
    return size;
}

+ (CGSize)stringAdaptive:(NSString *)content height:(CGFloat)height lineSpace:(CGFloat)lineSpace font:(CGFloat)font mode:(NSLineBreakMode)lineBrekMode{
    
    NSMutableParagraphStyle *paragraphStyle = ({
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];;
        
        [style setLineBreakMode:lineBrekMode];
        
        if (lineSpace != 0) {
            
            style = [[NSMutableParagraphStyle alloc] init];
            [style setLineSpacing:lineSpace];//调整行间距
        }
        
        style;
        
    });
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{
                                                  NSFontAttributeName:[UIFont systemFontOfSize:font],
                                                  NSParagraphStyleAttributeName:paragraphStyle
                                                  }
                                        context:nil].size;
    
    return size;
    
}

/**
 *  获得当前的ViewController
 *
 *  @return UIViewController
 */
+ (UIViewController *)getCurrentViewController{
    
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
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

#pragma mark - About Empty Object
/**
 *  判断是否为nil、NSNull
 *
 *  @param object 被判断的对象
 *
 *  @return BOOL
 */
+ (BOOL)judgeIsEmptyObject:(id)object{
    
    if (!object)
        return YES;
    if ([object isKindOfClass:[NSNull class]])
        return YES;
    return NO;
}

/**
 *  将是为nil、NSNull进行转换
 *
 *  @param object   被判断对象
 *  @param toObject 转换后对象
 *
 *  @return toObject
 */
+ (id)changeEmptyObject:(id)object to:(id)toObject{
    
    if ([YCUtils judgeIsEmptyObject:object]) {
        
        return toObject;
    }
    return object;
}

#pragma mark - About Local Data
/**
 *  将数据存到NSUserDefault
 *
 *  @param content 保存的内容
 *  @param key     键值
 */
+ (void)saveDataToLocal:(id)data key:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

/**
 *  从NSUserDefault读取数据
 *
 *  @param key 键值
 *
 *  @return 数据
 */
+ (id)getDataFromLocal:(NSString *)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

#pragma mark - About UI
/**
 *  提示框
 *
 *  @param message 内容
 */
+ (void)showAlertView:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"XZToolKit" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

@end
