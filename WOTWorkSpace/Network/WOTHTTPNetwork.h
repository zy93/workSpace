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
/**
 * 登录接口
 @param telOrEmail  登录账号手机号或邮箱
 @param pwd         登录密码 md5加密
 @param response    回调数据到上层
 */
+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd response:(response)response;

/**
 * 发送手机验证码
 @param tel  验证码
 @param response    回调数据到上层
 */
+(void)userGetVerifyWitTel:(NSString *)tel response:(response)response;
/**
 * 注册接口
 @param code 验证码
 @param tel  手机号注册
 @param pass 用户密码
 @param response    回调数据到上层
 */
+(void)userRegisterWitVerifyCode:(NSString *)code tel:(NSString *)tel password:(NSString *)pass response:(response)response;

/**
 * 根据城市获取所有空间接口
 @param city  城市名称 传入城市名称根据城市筛选，不传查询全部
 @param response    回调数据到上层
 */
+(void)getAllSpaceWithCity:(NSString *)city block:(response)response;
/**
 * 无参数获取全部空间
 */
+(void)getSpaceSitationBlock:(response)response;

/**
 *根据集团获取所有空间接口
 *
 */
+(void)getSapaceFromGroupBlock:(response)response;

/**
 根据空间id获取空间

 @param spaceId 空间id
 @param response spaceModel
 */
+(void)getSpaceFromSpaceID:(NSNumber *)spaceId bolock:(response)response;

/**
 获取定位最近的空间

 @param lat 纬度
 @param lon 经度
 */
+(void)getSpaceWithLocation:(CGFloat)lat lon:(CGFloat)lon response:(response)response;

/**
 通过空间id获取所有工位

 @param spaceID spaceId
 @param response
 */
+(void)getBookStationWithSpaceId:(NSNumber *)spaceId response:(response)response;


//+(void)getSpaceWith

/**
 *  根据空间id 和状态请求筛选 获取活动列表
 * @param spaceid  空间id
   @param spaceState 空间状态
   @param response 回调数据返回上层
 */
+(void)getActivitiesWithSpaceId:(NSNumber *)spaceid spaceState:(NSNumber *)spaceState response:(response)response;
/**
 *获取空间下的友邻企业
 *@param spaceid  空间id
 *@param response  对象返回上层，错误返回error
 */
+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response;

/**
 *获取全部资讯列表
 */
+(void)getAllNewInformation:(response)response;

/**
 *获取首页页面轮播图资源数据
 */

+(void)getHomeSliderSouceInfo:(response)response;

/**
 *获取服务页面轮播图资源数据
 */
+(void)getServeSliderSouceInfo:(response)response;
/**
 *获取我的历史--反馈列表数据
 @param userId  登录者用户id
 @param response 回调数据返回到上层
 */

+(void)getMyHistoryFeedBackData:(NSNumber *)userId response:(response)response;
/**
 *注册成为平台服务商
 @param userId  用户id
 
 */

+(void)registerServiceBusiness:(NSNumber *)userId firmName:(NSString *)firmName businessScope:(NSString *)businessScope contatcts:(NSString *)contatcts tel:(NSString *)tel facilitatorType:(NSString *)facilitatorType facilitatorState:(NSNumber *)facilitatorState firmLogo:(NSArray<UIImage *> *)firmLogo     response:(response)response;

/**
 *提交意见反馈
 */

+(void)postFeedBackInfoWithContent:(NSString *)opinionContent spaceId:(NSNumber *)spaceId userId:(NSNumber *)userId userName:(NSString *)userName tel:(NSString *)   tel response:(response)response;

/**
 *服务--发布需求页面
 */

+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSString *)spaceId userId:(NSString *)userId facilitatorType:(NSString *)facilitatorType facilitatorLabel:(NSString *)facilitatorLabel  response:(response)response;
/**
 *服务--获取服务商类别
 */
+(void)getAllServiceTypes:(response)response;

+(void)getFlexSliderSouceInfo:(response)response;


/**
 *  访客预约
 */
+(void)visitorAppointmentWithVisitorName:(NSString *)name headPortrait:(UIImage *)head sex:(NSString *)sex papersType:(NSNumber *)papersType papersNumber:(NSString *)papersNumber tel:(NSString *)tel spaceId:(NSNumber *)spaceId accessType:(NSNumber*)accessType userName:(NSString *)userName visitorInfo:(NSString*)visitorInfo peopleNum:(NSNumber*)peopleNum visitTime:(NSString*)time response:(response)response;
/**
 *  添加企业
 */
+(void)addBusinessWithLogo:(UIImage*)logo name:(NSString*)name type:(NSString *)type contactName:(NSString*)contactName contactTel:(NSString *)contactTel contactEmail:(NSString*)email response:(response)response;

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
//+(void)meetingReservationsWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)startTime endTime:(NSString *)endTime response:(response)response;
+(void)meetingReservationsWithSpaceId:(NSNumber *)spaceid
                         conferenceId:(NSNumber *)confid
                            startTime:(NSString *)startTime
                              endTime:(NSString *)endTime
                            spaceName:(NSString *)spaceName
                          meetingName:(NSString *) meetingName
                             response:(response)response;
//TODO: 场地
+(void)getAllSiteResponse:(response)response;
+(void)getSiteListWithSpaceId:(NSNumber *)spaceid response:(response)response;
+(void)getSiteReservationsTimeWithSpaceId:(NSNumber *)spaceid siteId:(NSNumber *)siteid startTime:(NSString *)strTime response:(response)response;
+(void)siteReservationsWithSpaceId:(NSNumber *)spaceid
                            siteId:(NSNumber *)siteid
                         startTime:(NSString *)startTime
                           endTime:(NSString *)endTime
                         spaceName:(NSString *)sapceName
                          siteName:(NSString *)siteName
                          response:(response)response;

//TODO: 工位

/**
 获取空间工位信息

 @param spaceid 空间id
 @param response 回调
 */
//+(void)getBookStationInfoWithSpaceId:(NSNumber *)spaceid response:(response)response;//2017 废弃
//+(void)getBook
/**
 *我的--我的活动
 */
+(void)getUserActivitiseWithUserId:(NSNumber *)userId state:(NSString *)state response:(response)response;
/**
*我的--我的企业
 @param companyId  企业id 登录接口返回用户的companyId,字符串
*/
+(void)getUserEnterpriseWithCompanyId:(NSString *)companyId  response:(response)response;


/**
 *我的--我的历史获取提交的历史服务需求
 */


+(void)getDemandsWithUserId:(NSNumber *)userId response:(response)response;

/**
 *服务--提交保修申请
 @param userId  用户id
 @param type 维修类型
 @param info 维修描述
 @param appointmentTime 时间
 @param address 报修的位置
 @param file 上传报修的图片
 @param alias  *接口返回，未知*
 @param response 回调数据到上层
 */
+(void)postRepairApplyWithUserId:(NSString *)userId type:(NSString *)type info:(NSString *)info appointmentTime:(NSString *)appointmentTime address:(NSString *)address file:(NSArray<UIImage *> *)file alias:(NSString *)alias  response:(response)response;


/**
 *我的历史--我的预约
 */


+(void)getMyAppointmentWithUserId:(NSNumber *)userId   response:(response)response;


#pragma mark - 订单

/**
 预定会议室、场地、工位订单

 @param spaceId 空间id
 @param commNum 商品编号 会议室id、场地id、工位传0
 @param commKind 商品对象 0工位，1会议室，2场地·
 @param productNum 商品数量 会议室、场地传1，工位传预定的工位数量
 @param startTime 预定开始日期
 @param endTime 预定结束日期
 @param money 订单总金额（元）
 @param dealMode 交易方式 strin（支付宝、微信）
 @param payType 支付类型 个人、企业
 @param payObject 支付对象 个人传用户名，企业传企业名
 @param payMode 支付方式 0线下，1线上
 @param contractMode 合同方式 0纸质，1电子
 @param response 结果回调
 */
+(void)generateOrderWithSpaceId:(NSNumber *)spaceId commodityNum:(NSNumber *)commNum commodityKind:(NSNumber *)commKind productNum:(NSNumber *)productNum startTime:(NSString *)startTime endTime:(NSString *)endTime money:(CGFloat)money dealMode:(NSString *)dealMode  payType:(NSNumber *)payType payObject:(NSString *)payObject payMode:(NSNumber *)payMode contractMode:(NSNumber *)contractMode response:(response)response;


#pragma mark - 社交

+(void)sendMessageToSapceWithSpaceId:(NSNumber *)spaceId text:(NSString *)text images:(NSArray *)images response:(response)response;
+(void)getMessageBySapceIdWithSpaceId:(NSNumber *)spaceId response:(response)response;
@end
