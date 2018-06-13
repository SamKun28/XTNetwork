//
//  XTHttpManager.m
//  NetWork
//
//  Created by 李昆 on 2018/6/12.
//  Copyright © 2018年 NG. All rights reserved.
//

#import "XTHttpManager.h"
#import "AFNetworkActivityIndicatorManager.h"

NSString * const moc_http_request_operation_manager_response_server_error_message = @"系统开小差,请稍后重试";
NSString * const moc_http_request_operation_manager_response_server_error_code = @"9989";
NSString * const moc_http_request_operation_manager_response_network_error_message = @"网络异常,请检查网络是否正常";
NSString * const moc_http_request_operation_manager_response_network_error_code = @"9998";
NSString * const moc_http_request_operation_manager_response_token_error_message = @"登录失效,请重新登录";
NSString * const moc_http_request_operation_manager_response_token_error_code = @"9899";
NSString * const moc_http_request_operation_manager_response_other_error_message = @"9899";
NSString * const moc_http_request_operation_manager_response_other_error_code = @"9899";
//NSString * const moc_http_request_operation_manager_base_url_string ;//base URL

//http返回的结果key
static NSString *moc_http_request_operation_manager_base_request_success_code;//请求成功码
static NSString *moc_http_request_operation_manager_base_request_result_key;//请求结果code的key
static NSString *moc_http_request_operation_manager_base_request_data_key;//数据部分
static NSString *moc_http_request_operation_manager_base_request_message_key;//错误信息部分




@interface XTHttpManager()
@property (nonatomic ,strong) AFHTTPSessionManager * httpManager;

@end


@implementation XTHttpManager

static XTHttpManager *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+(instancetype)manager
{
    return [[self alloc]init];
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        self.httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.httpManager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
        //[self.httpManager.requestSerializer.HTTPRequestHeaders setValue:@"" forKey:@""];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        [XTHttpManager AFNReachability];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

-(void)setTimeOut:(float)time{
    self.httpManager.requestSerializer.timeoutInterval = time;
}

-(void)setHttpHeaders:(NSDictionary *)dict{
    NSArray * keys = [dict allKeys];
    for (NSString * key in keys) {
        NSString * value = dict[key];
        [self.httpManager.requestSerializer.HTTPRequestHeaders setValue:value forKey:key];
    }
}

-(void)addHttpHeader:(NSString *)key andValue:(NSString *)value{
    [self.httpManager.requestSerializer.HTTPRequestHeaders setValue:value forKey:key];
}


+ (void)setupRequestOperationManager:(NSString *)resultKey successCode:(NSString *)successCode dataKey:(NSString *)dataKey messageKey:(NSString *)messageKey{
    NSAssert(!IsStrEmpty(resultKey), @"结果key不能为空");
    NSAssert(!IsStrEmpty(successCode), @"成功码不能为空");
    NSAssert(!IsStrEmpty(dataKey), @"数据key不能为空");
    NSAssert(!IsStrEmpty(messageKey), @"信息key不能为空");
    moc_http_request_operation_manager_base_request_success_code = successCode;
    moc_http_request_operation_manager_base_request_result_key   = resultKey;
    moc_http_request_operation_manager_base_request_data_key     = dataKey;
    moc_http_request_operation_manager_base_request_message_key  = messageKey;
}

+(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters isCache:(BOOL)isCahe progress:(XTProgressHandle)progressHandle success:(XTCompleteHandle)completeHandle{
    XTHttpManager * manager = [XTHttpManager manager];
    [XTProgressHUD show];
    NSURLSessionDataTask * task = [manager.httpManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if(progressHandle){
            progressHandle(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [XTProgressHUD dismiss];
        [manager.taskArray removeObject:task];
        //缓存数据，当无网络请求失败后才会加载缓存数据
        if(isCahe == YES && responseObject != nil){
            [XTHttpCache cacheWithData:responseObject URL:URLString parameters:parameters];
        }
        
        XTResponseObject * object = [manager objectForJson:responseObject];
        if(completeHandle){
            completeHandle(object);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [XTProgressHUD dismiss];
        [manager.taskArray removeObject:task];
        //数据请求失败当此接口有缓存则取缓存数据返回
        if(isCahe == YES){
            XTResponseObject * object = [XTHttpCache getCacheForURL:URLString parameters:parameters];
            if(completeHandle){
                completeHandle(object);
            }
        }
        
        XTResponseErroeObject * errObj = [manager failData:@""];
        [SVProgressHUD showErrorWithStatus:errObj.errorMessage];
        
    }];
    [manager.taskArray addObject:task];
    return task;
    
}

+(NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(id)parameters isCache:(BOOL)isCahe progress:(XTProgressHandle)progressHandle success:(XTCompleteHandle)completeHandle{
    XTHttpManager * manager = [XTHttpManager manager];
    [XTProgressHUD show];
    NSURLSessionDataTask * task = [manager.httpManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        if(progressHandle){
            progressHandle(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [XTProgressHUD dismiss];
        [manager.taskArray removeObject:task];
        //成功回调
        //缓存数据，当无网络请求失败后才会加载缓存数据
        if(isCahe == YES && responseObject != nil){
            [XTHttpCache cacheWithData:responseObject URL:URLString parameters:parameters];
        }
        
        XTResponseObject * object = [manager objectForJson:responseObject];
        if(completeHandle){
            completeHandle(object);
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [XTProgressHUD dismiss];
        [manager.taskArray removeObject:task];
        //
        if(isCahe == YES){
            XTResponseObject * object = [XTHttpCache getCacheForURL:URLString parameters:parameters];
            if(completeHandle){
                completeHandle(object);
            }
        }
        XTResponseErroeObject * errObj = [manager failData:@""];
        [SVProgressHUD showErrorWithStatus:errObj.errorMessage];
        
    }];
    [manager.taskArray addObject:task];
    return task;
}


-(XTResponseObject *)objectForJson:(id) responseObject{
    XTResponseObject * object = [[XTResponseObject alloc] init];
    object.data = responseObject;
    NSString *code = [responseObject valueForKey:moc_http_request_operation_manager_base_request_result_key];
    //如果code is null
    if(IsStrEmpty(code)){
        code=@"99999";
    }
    if ([code isEqualToString:moc_http_request_operation_manager_base_request_success_code]) {
        //请求成功
        id data = [responseObject objectForKey:moc_http_request_operation_manager_base_request_data_key];
        if([data isKindOfClass:[NSDictionary class]]){
            object.dataDictionary = data;
        }else if ([data isKindOfClass:[NSArray class]]){
            object.dataArray = data;
        }else{
            
        }
        
    }else{
        
        XTResponseErroeObject * errObj = [self failData:responseObject];
        [SVProgressHUD showErrorWithStatus:errObj.errorMessage];
    }
    return object;
}

-(XTResponseErroeObject *)failData:(id)responseData{
    //网络链接失败
    XTResponseErroeObject * object = [[XTResponseErroeObject alloc] init];
    AFNetworkReachabilityStatus statu = [XTHttpManager AFNReachability];
    if(statu == AFNetworkReachabilityStatusUnknown || statu == AFNetworkReachabilityStatusNotReachable){
        object.errorCode = moc_http_request_operation_manager_response_network_error_code;
        object.errorMessage = moc_http_request_operation_manager_response_network_error_message;
    }else{
        if ([responseData isKindOfClass:[NSError class]]){
            //服务器返回Null
            object.error = responseData;
            object.errorCode = [NSString stringWithFormat:@"%@",@([(NSError *)responseData code])];
            object.errorMessage = [responseData localizedDescription];
        }else{
            if ([responseData isKindOfClass:[NSDictionary class]]){
                //显示系统返回的失败信息
                object.errorMessage = [responseData objectForKey:moc_http_request_operation_manager_base_request_message_key] ;
                object.errorCode = [responseData objectForKey:moc_http_request_operation_manager_base_request_result_key];
            }else{
                //服务器返回的数据不是dictionary
                object.errorMessage = moc_http_request_operation_manager_response_other_error_message;
                object.errorCode = moc_http_request_operation_manager_response_other_error_code;
            }
        }
    }
    
    return object;
    
}

-(NSMutableArray *)taskArray{
    if(!_taskArray){
        _taskArray = [[NSMutableArray alloc] init];
    }
    return _taskArray;
}

+(AFNetworkReachabilityStatus)AFNReachability
{
    //1.创建网络监听管理者
    __block AFNetworkReachabilityStatus returnSatau = AFNetworkReachabilityStatusUnknown;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        returnSatau = status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                [SVProgressHUD showErrorWithStatus:@"失去连接"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
            default:
                break;
        }
    }];
    
    //3.开始监听
    [manager startMonitoring];
    return returnSatau;
}


+(void)cancelAllTask{
    XTHttpManager * manager = [XTHttpManager manager];
    for (NSURLSessionDataTask * task in manager.taskArray) {
        [task cancel];
    }
}

@end
