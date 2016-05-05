//
//  YCURLConfig.h
//  test1
//
//  Created by YCode on 16/2/11.
//  Copyright © 2016年 com.ycode. All rights reserved.
//

#ifndef YCURLConfig_h
#define YCURLConfig_h

#define Dev_BaseURL @"<#测试环境URL#>"
#define Pro_BaseURL @"<#生产环境URL#>"

#define API_BASE_URL Dev_BaseURL

#define API_AUTH_LOGIN      API_BASE_URL @"<#login_URL#>"
#define API_AUTH_SINGUP     API_BASE_URL @"<#singup_URL#>"
#define API_RESET_PASSWORD  API_BASE_URL @"<#reset password#>"

#endif /* YCURLConfig_h */
