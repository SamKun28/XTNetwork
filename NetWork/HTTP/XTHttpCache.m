//
//  XTHttpCache.m
//  NetWork
//
//  Created by 李昆 on 2018/6/13.
//  Copyright © 2018年 NG. All rights reserved.
//

#import "XTHttpCache.h"
static NSString *const XTHTTPResponseCache = @"XTHTTPResponseCache";
static YYCache *_dataCache;
@implementation XTHttpCache
+ (void)initialize {
    _dataCache = [YYCache cacheWithName:XTHTTPResponseCache];
}
+(void)cacheWithData:(id)httpData URL:(NSString *)URL parameters:(id)parameters{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:httpData forKey:cacheKey withBlock:nil];
}
+(id)getCacheForURL:(NSString *)URL parameters:(id)parameters{
    NSString *cacheKey = [self cacheKeyWithURL:URL parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}


+(NSInteger)getAllHttpCacheSize{
    return [_dataCache.diskCache totalCost];
}

+(void)removeAllCache{
    [_dataCache.diskCache removeAllObjects];
}

+(void)setCacheMaxSize:(NSInteger) maxSize{
    [_dataCache.diskCache  setCostLimit:1024*1024*maxSize];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    if(!parameters || parameters.count == 0){return URL;};
    // 将参数字典转换成字符串
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}
@end
