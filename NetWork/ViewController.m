//
//  ViewController.m
//  NetWork
//
//  Created by 李昆 on 2018/6/12.
//  Copyright © 2018年 NG. All rights reserved.
//

#import "ViewController.h"
#import "XTRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * urlStr = @"";
    [XTRequest GETAllUrl:urlStr param:@{} isCache:NO progress:nil success:^(XTResponseObject *result) {
        NSLog(@"%@",result);
    }];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
