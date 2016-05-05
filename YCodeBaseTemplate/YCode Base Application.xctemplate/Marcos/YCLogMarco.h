//
//  YCLogMarco.h
//  
//
//  Created by 顾强 on 16/5/5.
//
//

#ifndef YCLogMarco_h
#define YCLogMarco_h

#ifdef DEBUG
/***************原始log******************/
#define YCLog(...) NSLog(__VA_ARGS__)

/***************log，同时打印出参数**********************/
#define YCSLog(aParam) NSLog(@"\n %@:%@\n",[NSString stringWithFormat:@"%s",#aParam],aParam)

#define YCSRectLog(aParam) NSLog(@"%@:%@",[NSString stringWithFormat:@"%s",#aParam],NSStringFromCGRect(aParam))

#define YCSPointLog(aParam) NSLog(@"%@:%@",[NSString stringWithFormat:@"%s",#aParam],NSStringFromCGPoint(aParam))

/***************功能log*********************/
#define YCFLog(...) NSLog(@"%s %d \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])

#else
#define YCLog(...)
#define YCSLog(aParam)
#define YCSRectLog(aParam)
#define YCSPointLog(aParam)
#define YCFLog(...)
#endif


#endif /* YCLogMarco_h */
