//
//  WOTHTTPNetwork.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^response)(id bean,NSError *error);

@interface WOTHTTPNetwork : NSObject


+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd response:(response)response;
+(void)getActivitiesWithSpace:(NSInteger)workSpaceid activityType:(NSString *)activityType response:(response)response;
@end
