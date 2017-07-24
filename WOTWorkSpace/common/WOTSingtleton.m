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

- (NSMutableArray *)spaceCityArray {
    if (_spaceCityArray == nil) {
        _spaceCityArray = [NSMutableArray array];
    }
    return _spaceCityArray;
}
-(NSArray *)ballTitle{
    if (_ballTitle ==  nil) {
        _ballTitle = @[@"资讯",@"友邻",@"订工位",@"订会议室",@"开门",@"活动",@"访客",@"一键报修",@"意见反馈"];
    }
    return _ballTitle;
}
-(NSArray *)ballImage{
    if (_ballImage == nil) {
        _ballImage = @[@"zixun",@"youlin",@"dinggongwei",@"dinghuiyishi",@"kaimen",@"huodong",@"yudingchangdi",@"qiyejieshao",@"fangke",@"jingxuan",@"baoxiu",@"yijianfankui",@"jishi",@"",@"",@"",@"",@"",@""];
    }
    return _ballImage;
}



-(bool)isuserLogin{
    if (_isuserLogin == nil) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:LOGIN_STATE_USERDEFAULT]) {
            return [[NSUserDefaults standardUserDefaults] boolForKey:LOGIN_STATE_USERDEFAULT];
        } else {
            return NO;
        }
     
    }
    return _isuserLogin;
}

@end
