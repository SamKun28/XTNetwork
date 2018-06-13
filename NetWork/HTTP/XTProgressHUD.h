//
//  XTProgressHUD.h
//  NetWork
//
//  Created by 李昆 on 2018/6/13.
//  Copyright © 2018年 NG. All rights reserved.
//  HUD封装

#import <Foundation/Foundation.h>

@interface XTProgressHUD : NSObject
+(void)show;

+(void)dismiss;

+(void)showSuccessWithStr:(NSString *)successStr;

+(void)showFailWithStr:(NSString *)failStr;

+(void)showInfoWithStr:(NSString *)infoStr;


@end
