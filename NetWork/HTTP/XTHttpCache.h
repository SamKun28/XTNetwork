//
//  XTHttpCache.h
//  NetWork
//
//  Created by 李昆 on 2018/6/13.
//  Copyright © 2018年 NG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYCache.h"
@interface XTHttpCache : NSObject

/**
 异步缓存（将url+params作为key）

 @param httpData 请求到的数据
 @param URL url地址
 @param parameters 请求参数
 */
+(void)cacheWithData:(id)httpData URL:(NSString *)URL parameters:(id)parameters;


/**
 取出缓存（通过url连接和参数作为的key）

 @param URL url地址
 @param parameters 请求参数
 @return 返回json
 */
+ (id)getCacheForURL:(NSString *)URL parameters:(id)parameters;


/**
 设置缓存大小

 @param maxSize 最大缓存容量单位（M）
 */
+(void)setCacheMaxSize:(NSInteger) maxSize;

/**
 获取缓存大小

 @return 返回大小单位（byte）
 */
+ (NSInteger)getAllHttpCacheSize;



/**
 删除所有缓存
 */
+(void)removeAllCache;
@end
