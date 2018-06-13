//
//  XTRequest.h
//  NetWork
//
//  Created by 李昆 on 2018/6/12.
//  Copyright © 2018年 NG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTHttpManager.h"




@interface XTRequest : XTHttpManager



/**
 POST（需要完整的url）

 @param url 完整的url
 @param param 请求参数
 @param progressHandle 进程回调
 @param completeHandle 完成回调
 @return 返回task
 */
+(NSURLSessionDataTask *)POSTAllUrl:(NSString *)url param:(id) param isCache:(BOOL) isCache progress:(XTProgressHandle) progressHandle success:(XTCompleteHandle) completeHandle;


/**
 GET（需要完整的url）
 
 @param url 完整的url
 @param param 请求参数
 @param progressHandle 进程回调
 @param completeHandle 完成回调
 @return 返回task
 */
+(NSURLSessionDataTask *)GETAllUrl:(NSString *)url param:(id) param isCache:(BOOL) isCache progress:(XTProgressHandle) progressHandle success:(XTCompleteHandle) completeHandle;

/**
 POST（剔除baseUrl部分）

 @param url url字符串（不包含BASE_URL）
 @param param 请求参数
 @param progressHandle 进程回调
 @param completeHandle 完成回调
 @return 返回task
 */
+(NSURLSessionDataTask *)POSTUrl:(NSString *)url param:(id) param isCache:(BOOL) isCache progress:(XTProgressHandle) progressHandle success:(XTCompleteHandle) completeHandle;



/**
 GET （剔除baseUrl部分）
 
 @param url url字符串（不包含BASE_URL）
 @param param 请求参数
 @param progressHandle 进程回调
 @param completeHandle 完成回调
 @return 返回task
 */
+(NSURLSessionDataTask *)GETUrl:(NSString *)url param:(id) param isCache:(BOOL) isCache progress:(XTProgressHandle) progressHandle success:(XTCompleteHandle) completeHandle;

@end
