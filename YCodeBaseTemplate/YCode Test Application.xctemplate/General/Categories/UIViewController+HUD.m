//
//  UIViewController+HUD.m
//  test1
//
//  Created by YCode on 16/2/10.
//  Copyright © 2016年 com.ycode. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "MBProgressHUD.h"
#import "YCDEFINE.h"

@implementation UIViewController (HUD)

- (void)showHUDInSelfViewWithHint:(NSString *)hint{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = hint;
    
}

- (void)hideHUD{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showHint:(NSString *)hint{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.yOffset = YC_SCREEN_HEIGHT/2 -100;
    
    [hud hide:YES afterDelay:2.f];
}

- (void)showHint:(NSString *)hint yOffset:(CGFloat)offset{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.yOffset = offset;
    
    [hud hide:YES afterDelay:2.f];
}

- (void)showAlertViewWithHint:(NSString *)hint{
    
    if (YC_DEVICE_VERSION >= 8.f) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:hint preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:hint delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
#pragma clang diagnostic pop
    }
}
@end
