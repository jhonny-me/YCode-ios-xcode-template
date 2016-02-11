//
//  YCThirdPartKeyConfig.h
//  test1
//
//  Created by YCode on 16/2/11.
//  Copyright © 2016年 com.ycode. All rights reserved.
//

#ifndef YCThirdPartKeyConfig_h
#define YCThirdPartKeyConfig_h
// 通过注释下面一句来切换到测试环境
//#define YC_PRODUCTION_SWITCH 1

#ifdef YC_PRODUCTION_SWITCH

#define YC_EaseMob_KEY          @"<#环信生产环境APPkey#>"
#define YC_EaseMob_apnsCertName @"<#环信后台上传推送证书时起的名字#>"

#define YC_BMKMap_KEY           @"<#百度地图生产环境key#>"

#define YC_ShareSDK_KEY         @"<#shareSDK生产环境的appkey#>"
#define YC_SinaWeibo_KEY        @"<#新浪微博生产环境key#>"
#define YC_QZone_KEY            @"<#QQ及QQ空间生产环境key#>"
#define YC_QZone_appSecret      @"<#QQ空间appSecret#>"
#define YC_WeChat_Id            @"<#微信生产环境APPId#>"

#define YC_PgyManager_Id        @"<#蒲公英APPID#>"

#else

#define YC_EaseMob_KEY @"<#环信测试环境APPkey#>"
#define YC_EaseMob_apnsCertName @"<#环信后台上传推送证书时起的名字#>"

#define YC_BMKMap_KEY           @"<#百度地图测试环境key#>"

#define YC_ShareSDK_KEY         @"<#shareSDK测试环境的appkey#>"
#define YC_SinaWeibo_KEY        @"<#新浪微博测试环境key#>"
#define YC_QZone_KEY            @"<#QQ及QQ空间测试环境key#>"
#define YC_QZone_appSecret      @"<#QQ空间测试appSecret#>"
#define YC_WeChat_Id            @"<#微信测试环境APPId#>"

#define YC_PgyManager_Id        @"<#蒲公英测试环境APPID#>"

#endif

#endif /* YCThirdPartKeyConfig_h */
