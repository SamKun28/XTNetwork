//
//  XTProgressHUD.m
//  NetWork
//
//  Created by 李昆 on 2018/6/13.
//  Copyright © 2018年 NG. All rights reserved.
//

#import "XTProgressHUD.h"

@implementation XTProgressHUD

+(void)show{
    [SVProgressHUD show];
}

+(void)dismiss{
    [SVProgressHUD dismiss];
}

+(void)showSuccessWithStr:(NSString *)successStr{
    [SVProgressHUD showSuccessWithStatus:successStr];
}


+(void)showFailWithStr:(NSString *)failStr{
    [SVProgressHUD showErrorWithStatus:failStr];
}


+(void)showInfoWithStr:(NSString *)infoStr{
    [SVProgressHUD showInfoWithStatus:infoStr];
}

@end
