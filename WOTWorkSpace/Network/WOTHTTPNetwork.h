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
+(void)getAllSpaceWithCity:(NSString *)city block:(response)response;
+(void)getActivitiesWithSpaceId:(NSNumber *)spaceid spaceState:(NSNumber *)spaceState response:(response)response;
+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response;
+(void)getAllNewInformation:(response)response;
+(void)getHomeSliderSouceInfo:(response)response;
+(void)getMyHistoryFeedBackData:(NSNumber *)userId response:(response)response;
+(void)registerServiceBusiness:(NSString *)userId firmName:(NSString *)firmName businessScope:(NSString *)businessScope contatcts:(NSString *)contatcts tel:(NSString *)tel facilitatorType:(NSString *)facilitatorType facilitatorState:(NSNumber *)facilitatorState firmLogo:(NSArray<UIImage *> *)firmLogo     response:(response)response;
+(void)postFeedBackInfoWithContent:(NSString *)opinionContent spaceId:(NSNumber *)spaceId userId:(NSNumber *)userId userName:(NSString *)userName tel:(NSString *)   tel response:(response)response;
+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSNumber *)spaceId userId:(NSNumber *)userId facilitator_type:(NSString *)facilitator_type time:(NSDate   *)time  response:(response)response;
+(void)getAllServiceTypes:(response)response;
@end
