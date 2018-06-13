//
//  XTAPIHeader.h
//  NetWork
//
//  Created by 李昆 on 2018/6/13.
//  Copyright © 2018年 NG. All rights reserved.
//

#ifndef XTAPIHeader_h
#define XTAPIHeader_h

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
#define BASE_URL @""


#endif /* XTAPIHeader_h */
