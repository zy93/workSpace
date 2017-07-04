//
//  WOTSingtleton.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSingtleton.h"

@implementation WOTSingtleton
+(instancetype)shared{
    static WOTSingtleton *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc]init];
    });
    return  instance;
}

- (NSMutableArray *)_spaceCityArray {
    if (_spaceCityArray == nil) {
        _spaceCityArray = [NSMutableArray array];
    }
    return _spaceCityArray;
}
@end
