//
//  WOTHTTPNetwork.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTHTTPNetwork.h"

@implementation WOTHTTPNetwork

+(void)userLoginWithPhone:(NSString *)phone password:(NSString *)pwd response:(response)response
{
    NSDictionary *dic = @{@"phone" :phone, @"phone":pwd};
    //afn
    id sss;
    if (response) {
        response(sss);
    }
}

@end
