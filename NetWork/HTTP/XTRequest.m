//
//  XTRequest.m
//  NetWork
//
//  Created by 李昆 on 2018/6/12.
//  Copyright © 2018年 NG. All rights reserved.
//

#import "XTRequest.h"

@implementation XTRequest

+(NSURLSessionDataTask *)POSTAllUrl:(NSString *)url param:(id)param isCache:(BOOL) isCache progress:(XTProgressHandle)progressHandle success:(XTCompleteHandle)completeHandle{
    return [XTRequest POST:url parameters:param isCache:isCache progress:progressHandle success:completeHandle];
}


+(NSURLSessionDataTask *)GETAllUrl:(NSString *)url param:(id)param isCache:(BOOL) isCache progress:(XTProgressHandle)progressHandle success:(XTCompleteHandle)completeHandle{
    return [XTRequest GET:url parameters:param isCache:isCache progress:progressHandle success:completeHandle];
}

+(NSURLSessionDataTask *)POSTUrl:(NSString *)url param:(id)param isCache:(BOOL) isCache progress:(XTProgressHandle)progressHandle success:(XTCompleteHandle)completeHandle{
    NSString * urlStr = [BASE_URL stringByAppendingString:url];
    return [XTRequest POST:urlStr parameters:param isCache:isCache progress:progressHandle success:completeHandle];

}

+(NSURLSessionDataTask *)GETUrl:(NSString *)url param:(id)param isCache:(BOOL) isCache progress:(XTProgressHandle)progressHandle success:(XTCompleteHandle)completeHandle{
    NSString * urlStr = [BASE_URL stringByAppendingString:url];
    return [XTRequest GET:urlStr parameters:param isCache:isCache progress:progressHandle success:completeHandle];

}

@end
