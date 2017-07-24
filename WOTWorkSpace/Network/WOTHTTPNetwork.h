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
+(void)getSpaceSitationBlock:(response)response;
+(void)getActivitiesWithSpaceId:(NSNumber *)spaceid spaceState:(NSNumber *)spaceState response:(response)response;
+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response;
+(void)getAllNewInformation:(response)response;
+(void)getHomeSliderSouceInfo:(response)response;
+(void)getMyHistoryFeedBackData:(NSNumber *)userId response:(response)response;
+(void)registerServiceBusiness:(NSString *)userId firmName:(NSString *)firmName businessScope:(NSString *)businessScope contatcts:(NSString *)contatcts tel:(NSString *)tel facilitatorType:(NSString *)facilitatorType facilitatorState:(NSNumber *)facilitatorState firmLogo:(NSArray<UIImage *> *)firmLogo     response:(response)response;
+(void)postFeedBackInfoWithContent:(NSString *)opinionContent spaceId:(NSNumber *)spaceId userId:(NSNumber *)userId userName:(NSString *)userName tel:(NSString *)   tel response:(response)response;
+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSNumber *)spaceId userId:(NSNumber *)userId facilitator_type:(NSString *)facilitator_type time:(NSDate   *)time  response:(response)response;
+(void)getAllServiceTypes:(response)response;
+(void)getFlexSliderSouceInfo:(response)response;



+(void)visitorAppointmentWithVisitorName:(NSString *)name headPortrait:(UIImage *)head sex:(NSString *)sex papersType:(NSNumber *)papersType papersNumber:(NSString *)papersNumber tel:(NSString *)tel spaceId:(NSNumber *)spaceId accessType:(NSNumber*)accessType userName:(NSString *)userName visitorInfo:(NSString*)visitorInfo peopleNum:(NSNumber*)peopleNum visitTime:(NSString*)time response:(response)response;



/****************           Service        ****************************/

//TODO: 会议室

/**
 获取会议室列表

 @param spaceid 空间id
 @param response 响应回调
 */
+(void)getMeetingRoomListWithSpaceId:(NSNumber *)spaceid response:(response)response;

/**
 获取某个会议室预定情况

 @param spaceid 空间id
 @param confid 会议室id
 @param strTime 查询时间
 @param response 回调
 */
+(void)getMeetingReservationsTimeWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)strTime response:(response)response;

/**
 预定会议室

 @param spaceid 空间id
 @param confid 会议室id
 @param startTime 预约开始时间
 @param endTime 结束时间
 @param response 回调
 */
+(void)meetingReservationsWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)startTime endTime:(NSString *)endTime response:(response)response;

//TODO: 工位

/**
 获取空间工位信息

 @param spaceid 空间id
 @param response 回调
 */
+(void)getBookStationInfoWithSpaceId:(NSNumber *)spaceid response:(response)response;

@end
