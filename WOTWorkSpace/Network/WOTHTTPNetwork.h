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


+(void)getAllSpace:(response)response;
+(void)getActivitiesWithSpaceId:(NSNumber *)spaceid spaceState:(NSNumber *)spaceState response:(response)response;
+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response;
+(void)getAllNewInformation:(response)response;
@end
