//
//  XTHttpManager.h
//  NetWork
//
//  Created by 李昆 on 2018/6/12.
//  Copyright © 2018年 NG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "YYCache.h"
#import "XTResponseObject.h"
#import "XTHttpCache.h"

extern NSString * const moc_http_request_operation_manager_response_server_error_message;
extern NSString * const moc_http_request_operation_manager_response_server_error_code;
extern NSString * const moc_http_request_operation_manager_response_network_error_message;
extern NSString * const moc_http_request_operation_manager_response_network_error_code;
extern NSString * const moc_http_request_operation_manager_response_token_error_message;
extern NSString * const moc_http_request_operation_manager_response_token_error_code;
extern NSString * const moc_http_request_operation_manager_response_other_error_message;
extern NSString * const moc_http_request_operation_manager_response_other_error_code;


typedef void(^XTProgressHandle)(NSProgress * progress);
typedef void(^XTCompleteHandle)(XTResponseObject * result);
//typedef void(^XTFailureHandle)(NSError *error,XTResponseObject * cacheData);
@interface XTHttpManager : NSObject

@property (nonatomic ,strong) NSMutableArray * taskArray;

+(instancetype)manager;


-(void)setTimeOut:(float) time;




/**
 设置请求头部分

 @param dict 配置请求头的字典
 */
-(void)setHttpHeaders:(NSDictionary *)dict;



/**
 添加单个请求头

 @param key key
 @param value value
 */
-(void)addHttpHeader:(NSString *)key andValue:(NSString *)value;





/**
 设置参数

 @param resultKey 返回结果key
 @param successCode 成功code
 @param dataKey 数据部分key
 @param messageKey 返回提示信息key
 */
+ (void)setupRequestOperationManager:(NSString *)resultKey successCode:(NSString *)successCode dataKey:(NSString *)dataKey messageKey:(NSString *)messageKey;



/**
 POST请求需要完整的url，不建议直接调用，建议使用子类（XTRequset调用）POST

 @param URLString 完整的url连接
 @param parameters 请求参数
 @param progressHandle 进程
 @param completeHandle 完成回调
 @return 返回task
 */
+(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters isCache:(BOOL)isCahe progress:(XTProgressHandle)progressHandle success:(XTCompleteHandle) completeHandle;



/**
 GET请求需要完整的url 不建议直接调用，建议使用子类（XTRequset调用）GET
 
 @param URLString 完整的url连接
 @param parameters 请求参数
 @param progressHandle 进程
 @param completeHandle 完成回调
 @return 返回task
 */
+(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters isCache:(BOOL)isCahe progress:(XTProgressHandle)progressHandle success:(XTCompleteHandle) completeHandle;


/**
 取消当前所有任务
 */
+(void)cancelAllTask;
@end
