//
//  WOTHTTPNetwork.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^response)(id bean);

@interface WOTHTTPNetwork : NSObject


+(void)userLoginWithPhone:(NSString *)phone password:(NSString *)pwd response:(response)response;

@end
