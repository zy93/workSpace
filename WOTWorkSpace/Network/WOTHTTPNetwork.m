//
//  WOTHTTPNetwork.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTHTTPNetwork.h"
#import "header.h"
#import "WOTLoginModel.h"
#import "WOTSpaceModel.h"
#import "WOTActivityModel.h"
#import "WOTEnterpriseModel.h"
#import "WOTNewInformationModel.h"
#import "WOTSliderModel.h"
#import "WOTMyFeedBackModel.h"
#import "WOTBaseModel.h"
#import "AFURLRequestSerialization.h"
#import "WOTMeetingListModel.h"
#import "WOTMeetingReservationsModel.h"
#import "WOTMyHistoryDemandsModel.h"
#import "WOTBookStationListModel.h"
#import "WOTVisitorsModel.h"
#import "WOTAppointmentModel.h"
#import "WOTGetVerifyModel.h"
#import "WOTRegisterModel.h"
#import "WOTBusinessModel.h"
#import "WOTLocationModel.h"
#import "WOTSiteModel.h"
#import "WOTSiteReservationsModel.h"
#import "WOTServiceCategoryModel.h"
#import "WOTSendFriendsModel.h"
#import "WOTFriendsMessageListModel.h"

#import "WXApi.h"
#import "WOTWXPayModel.h"

#define kMaxRequestCount 3
@interface WOTHTTPNetwork()

@property(nonatomic,assign)NSInteger requestcount;

@end
@implementation WOTHTTPNetwork
-(instancetype)init{
    self = [super init];
    if (self) {
        _requestcount = 0;
    }
    return self;
}
//网络请求
+(void)doRequestWithParameters:(NSDictionary *)parameters
                        useUrl:(NSString *)Url
                      complete:(JSONModel *(^)(id responseobj))complete
                      response:(response)response
{
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                         @"text/html",
                         @"image/jpeg",
                         @"image/png",
                         @"application/octet-stream",
                         @"text/json", nil];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    
    [manager POST:Url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"request URL:%@",task.originalRequest.URL.absoluteString);
        NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"responseStr:%@",responseStr);
        NSError *error = nil;
        NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        NSLog(@"测试：%@",responseDic);
        NSInteger statusCode = [responseDic[@"code"] integerValue];
        if (statusCode == 200) {
            if (response) {
                response(complete(responseDic),nil);
            }
        }
        else {
            if (response) {
                
                response(complete(responseDic), error);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request URL: %@-----error:%@",task.originalRequest.URL.absoluteString,error.userInfo[NSLocalizedDescriptionKey]);
        if (response) {
            response(nil, error);
        }
    }];
}


+(NSDictionary*)paramEncoding:(NSDictionary*)parameters{
    NSMutableDictionary *mutaDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    for (NSString *key in [mutaDic allKeys]) {
        NSString * strEncoding= [mutaDic[key] UrlEncodedString];
        mutaDic[key] = strEncoding;
    }
    return mutaDic;
}

//上传文件网络请求
+(void)doFileRequestWithParameters:(NSDictionary *)parameters
                            useUrl:(NSString *)Url image:(NSArray<UIImage *> *)images
                          complete:(JSONModel *(^)(id responseobj))complete
                          response:(response)response {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    [manager POST:Url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        NSData *data = UIImagePNGRepresentation(images[0]);
//        
//        //上传的参数(上传图片，以文件流的格式)
//        [formData appendPartWithFileData:data
//         
//                                    name:@"file"
//         
//                                fileName:@"gauge.png"
//                                mimeType:@"image/png"];
//        

        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData;
           
            imageData = UIImageJPEGRepresentation(image, 1.0f);
           
            imageData = UIImageJPEGRepresentation(image,1.f);
            if (!imageData) {
                imageData = UIImagePNGRepresentation(image);
            }
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"request URL:%@",task.originalRequest.URL.absoluteString);
        NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"responseStr:%@",responseStr);
        NSError *error = nil;
        NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        
        NSInteger statusCode = [responseDic[@"code"] integerValue];
        if (statusCode == 200) {
            if (response) {
                response(complete(responseDic),nil);
            }
        }
        else {
            if (response) {
                response(nil, error);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"request URL: %@-----error:%@",task.originalRequest.URL.absoluteString,error.userInfo[NSLocalizedDescriptionKey]);
        if (response) {
            response(nil, error);
        }
    }];
  
}


//登录
+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd response:(response)response
{
    NSDictionary *dic = @{@"tel" :telOrEmail, @"password":[WOTUitls md5HexDigestByString:pwd]};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Login/Login"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTLoginModel_msg *model = [[WOTLoginModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)userGetVerifyWitTel:(NSString *)tel response:(response)response
{
    NSDictionary *dic = @{@"tel" :tel};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Login/sendVerify"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTGetVerifyModel *model = [[WOTGetVerifyModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)userRegisterWitVerifyCode:(NSString *)code tel:(NSString *)tel password:(NSString *)pass response:(response)response
{
    NSDictionary *dic = @{@"tel" :tel,
                          @"verifyNumPro": code,
                          @"password":[WOTUitls md5HexDigestByString:pass]};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Login/register"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTRegisterModel *model = [[WOTRegisterModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getAllSpaceWithCity:(NSString *)city block:(response)response{
    
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Space/findAllSpace"];
    NSDictionary *parameters;
    if (city != nil) {
        parameters = @{@"city":city};//原来
    }

    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTSpaceModel_msg * spacemodel = [[WOTSpaceModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  spacemodel;
        
        
    } response:response];
}

/**
 * 无参数获取全部空间
 */
+(void)getSpaceSitationBlock:(response)response{
    
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Space/findAllSpaceToAPP"];
    NSDictionary * parameters =nil;
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTBookStationListModel_msg * spacemodel = [[WOTBookStationListModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  spacemodel;
        
        
    } response:response];
}

+(void)getBookStationWithSpaceId:(NSNumber *)spaceId response:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Space/findStationBySpaceId"];
    NSDictionary * parameters =@{@"":spaceId};
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTBookStationListModel_msg * spacemodel = [[WOTBookStationListModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  spacemodel;
    } response:response];
}

+(void)getSapaceFromGroupBlock:(response)response
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Space/findByAppId"];
    NSDictionary *parameters = @{@"appId":YLGTEST_APPID};
    
    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTSpaceModel_msg * spacemodel = [[WOTSpaceModel_msg alloc]initWithDictionary:responseobj error:nil];
        return  spacemodel;
    } response:response];
}

+(void)getSpaceWithLocation:(CGFloat)lat lon:(CGFloat)lon response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Space/findNearSpace"];
    NSDictionary * parameters = @{@"lng":@(lon),
                                  @"lat":@(lat),
                                  @"appId":YLGTEST_APPID};
    
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        WOTLocationModel_Msg * activitymodel = [[WOTLocationModel_Msg alloc]initWithDictionary:responseobj error:nil];
        NSLog(@"测试%@",activitymodel.msg);
        return  activitymodel;
    }response:response];
}

+(void)getActivitiesWithSpaceId:(NSNumber *)spaceid spaceState:(NSNumber *)spaceState  response:(response)response{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Activity/findByState"];
    NSDictionary * parameters = @{@"activityState":spaceState};
    
     [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
         
         WOTActivityModel_msg * activitymodel = [[WOTActivityModel_msg alloc]initWithDictionary:responseobj error:nil];
         
         return  activitymodel;
         
         
     } response:response];
}


+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/CompanyInfo/findBySpaceId"];
    NSDictionary * parameters = @{@"spaceId":spaceid};
    
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        WOTEnterpriseModel_msg * enterprisemodel = [[WOTEnterpriseModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  enterprisemodel;
        
        
    }response:response];
}

+(void)getAllNewInformation:(response)response{
    NSString *infourl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Message/findAllMessageToApp"];
    [self doRequestWithParameters:nil useUrl:infourl complete:^JSONModel *(id responseobj) {
        WOTNewInformationModel_msg *infomodel = [[WOTNewInformationModel_msg alloc]initWithDictionary:responseobj error:nil];
        return infomodel;
    } response:response];
}

+(void)getHomeSliderSouceInfo:(response)response{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Slider/findByHome"];
    [self doRequestWithParameters:nil useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTSliderModel_msg *model = [[WOTSliderModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}



+(void)getServeSliderSouceInfo:(response)response{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Slider/findByServe"];
    [self doRequestWithParameters:nil useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTSliderModel_msg *model = [[WOTSliderModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    }response:response];
}




+(void)getMyHistoryFeedBackData:(NSNumber *)userId response:(response)response{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Opinion/findByUserId"];
     NSDictionary * parameters = @{@"userId":userId};
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTMyFeedBackModel_msg *model = [[WOTMyFeedBackModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}




+(void)registerServiceBusiness:(NSNumber *)userId firmName:(NSString *)firmName businessScope:(NSString *)businessScope contatcts:(NSString *)contatcts tel:(NSString *)tel facilitatorType:(NSString *)facilitatorType facilitatorState:(NSNumber *)facilitatorState firmLogo:(NSArray<UIImage *> *)firmLogo     response:(response)response{
    
    
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/FacilitatorInfo/addInfo"];
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userId,@"userId",firmName,@"firmName",businessScope,@"businessScope",contatcts,@"contatcts",tel,@"tel",facilitatorType,@"facilitatorType",nil];
    if (facilitatorState) {
        [parameters setValue:facilitatorState forKey:@"facilitatorState"];

    }
    
    
    [self doFileRequestWithParameters:parameters useUrl:registerurl image:firmLogo complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
  
}



+(void)visitorAppointmentWithVisitorName:(NSString *)name headPortrait:(UIImage *)head sex:(NSString *)sex papersType:(NSNumber *)papersType papersNumber:(NSString *)papersNumber tel:(NSString *)tel spaceId:(NSNumber *)spaceId accessType:(NSNumber *)accessType userName:(NSString *)userName visitorInfo:(NSString *)visitorInfo peopleNum:(NSNumber *)peopleNum visitTime:(NSString *)time response:(response)response
{
    NSDictionary *dic = @{
                          @"visitorName":name,
                          @"sex":sex,
                          @"papersType":papersType,
                          @"papersNum":papersNumber,
                          @"visitorTel":tel,
                          @"spaceId":spaceId,
                          @"accessType":accessType,
                          @"userName":userName,
                          @"visitInfo":visitorInfo,
                          @"peopleNum":peopleNum,
                          @"visitTime":time,
                        };
    
    NSArray *heads = nil;
    
    if (head) {
        heads = @[head];
    }
    
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Visitor/addVisitorOrUpdate"];
    
    [self doFileRequestWithParameters:dic useUrl:registerurl image:heads complete:^JSONModel *(id responseobj) {
        NSError *error = nil;
        WOTVisitorsModel *model = [[WOTVisitorsModel alloc] initWithDictionary:responseobj error:&error];
        if (response) {
            response(model, nil);
        }
        return model;
    } response:response];
    
}



+(void)addBusinessWithLogo:(UIImage *)logo name:(NSString *)name type:(NSString *)type contactName:(NSString *)contactName contactTel:(NSString *)contactTel contactEmail:(NSString *)email response:(response)response
{
    NSDictionary *dic = @{
                          @"companyName":name,
                          @"companyType":type,
                          @"contacts":contactName,
                          @"tel":contactTel,
                          @"mailbox":email,
                          };
    
    NSArray *companyPictures = nil;
    
    if (logo) {
        companyPictures = @[logo];
    }
    
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/CompanyInfo/addCompanyInfo"];
    
    [self doFileRequestWithParameters:dic useUrl:registerurl image:companyPictures complete:^JSONModel *(id responseobj) {
        WOTBusinessModel *model = [[WOTBusinessModel alloc] initWithDictionary:responseobj error:nil];
        if (response) {
            response(model,nil);
        }
        return model;
    } response:response];
}


/****************           Service        ****************************/
#pragma mark - Service
+(void)getMeetingRoomListWithSpaceId:(NSNumber *)spaceid response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Conference/findBySpaceId"];
    NSDictionary *dic = @{@"spaceId":spaceid};
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTMeetingListModel_msg *model = [[WOTMeetingListModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
    

}


+(void)postFeedBackInfoWithContent:(NSString *)opinionContent spaceId:(NSNumber *)spaceId userId:(NSNumber *)userId userName:(NSString *)userName tel:(NSString*)   tel  response:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Opinion/addOpinion"];
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:opinionContent,@"opinionContent",spaceId,@"spaceId",userId,@"userId",userName,@"userName",nil];
    if (tel) {
        [parameters setValue:tel forKey:@"tel"];
    }
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
    
}

+(void)getMeetingReservationsTimeWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)strTime response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Conferencedetails/findByIdAndTime"];
    NSDictionary *dic = @{@"spaceId":spaceid,
                          @"conferenceId":confid,
                          @"startTime":strTime};
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTMeetingReservationsModel_msg *model = [[WOTMeetingReservationsModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}





+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSString *)spaceId userId:(NSString *)userId facilitatorType:(NSString *)facilitatorType facilitatorLabel:(NSString *)facilitatorLabel  response:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/GetFacilitator/addGetFacilitator"];
   
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:describe,@"describe",spaceId,@"spaceId",userId,@"userId",facilitatorType,@"facilitatorType",facilitatorLabel,@"facilitatorLabel",nil];
   
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}
+(void)meetingReservationsWithSpaceId:(NSNumber *)spaceid conferenceId:(NSNumber *)confid startTime:(NSString *)startTime endTime:(NSString *)endTime response:(response)response
{
    
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Conferencedetails/subscribyTime"];
    NSDictionary *dic = @{
                          @"spaceId":spaceid,
                          @"conferenceId":confid,
                          @"startTime":startTime,
                          @"endTime":endTime};
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTReservationsResponseModel_msg *model = [[WOTReservationsResponseModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

#pragma mark - Site
+(void)getAllSiteResponse:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Site/findAllSite"];
    [self doRequestWithParameters:nil useUrl:url complete:^JSONModel *(id responseobj) {
         WOTSiteModel_Msg *model = [[WOTSiteModel_Msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getSiteListWithSpaceId:(NSNumber *)spaceid response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Site/findSiteBySpaceId"];
    NSDictionary *dic = @{
                          @"spaceId":spaceid,
                          };
    [self doRequestWithParameters:dic useUrl:url complete:^JSONModel *(id responseobj) {
        WOTSiteModel_Msg *model = [[WOTSiteModel_Msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getSiteReservationsTimeWithSpaceId:(NSNumber *)spaceid siteId:(NSNumber *)siteid startTime:(NSString *)strTime response:(response)response
{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SiteOrder/findByIdAndTime"];
    
    NSDictionary *dic = @{
                          @"spaceId":spaceid,
                          @"siteId":siteid,
                          @"startTime":strTime};
    
    [self doRequestWithParameters:dic useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTSiteReservationsModel_Msg *model = [[WOTSiteReservationsModel_Msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)siteReservationsWithSpaceId:(NSNumber *)spaceid siteId:(NSNumber *)siteid startTime:(NSString *)startTime endTime:(NSString *)endTime response:(response)response
{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/SiteOrder/findByTime"];
    
    NSDictionary *dic = @{
                          @"spaceId":spaceid,
                          @"siteId":siteid,
                          @"startTime":startTime,
                          @"endTime":endTime};
    
    [self doRequestWithParameters:dic useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTSiteReservationsRsponseModel_Msg *model = [[WOTSiteReservationsRsponseModel_Msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}


+(void)getAllServiceTypes:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/FacilitatorLabel/findAll"];
    
    [self doRequestWithParameters:nil useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTServiceCategoryModel_msg *model = [[WOTServiceCategoryModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

//+(void)getBookStationInfoWithSpaceId:(NSNumber *)spaceid response:(response)response
//{
//    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Station/findAllStation"];
//    [self doRequestWithParameters:nil useUrl:sliderurl complete:^JSONModel *(id responseobj) {
//        WOTReservationsResponseModel_msg *model = [[WOTReservationsResponseModel_msg alloc]initWithDictionary:responseobj error:nil];//1
//        return model;
//    }response:response];
//}


+(void)getUserActivitiseWithUserId:(NSNumber *)userId state:(NSString *)state response:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/ActivityApply/findByUserId"];
    NSDictionary *parameters = @{@"userId":userId,@"state":state};
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        if ([state isEqualToString:@"0"]) {
            WOTMyActivityModel_msg *model = [[WOTMyActivityModel_msg alloc]initWithDictionary:responseobj error:nil];
            return model;
        } else {
            
            WOTActivityModel_msg * activitymodel = [[WOTActivityModel_msg alloc]initWithDictionary:responseobj error:nil];
            
            return  activitymodel;
        }
        
    } response:response];
}


+(void)getUserEnterpriseWithCompanyId:(NSString *)companyId response:(response)response{
    
    NSString *myenterpriseurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/CompanyInfo/findMyCompany"];
    NSDictionary *parameters = @{@"companyId":companyId};
    [self doRequestWithParameters:parameters useUrl:myenterpriseurl complete:^JSONModel *(id responseobj) {
            WOTEnterpriseModel_msg * activitymodel = [[WOTEnterpriseModel_msg alloc]initWithDictionary:responseobj error:nil];
            
            return  activitymodel;
      
        
    } response:response];
}





+(void)getDemandsWithUserId:(NSNumber *)userId response:(response)response{
    
    NSString *demandsurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/GetFacilitator/findByUserId"];
    NSDictionary *parameters = @{@"userId":userId};
    [self doRequestWithParameters:parameters useUrl:demandsurl complete:^JSONModel *(id responseobj) {
        WOTMyHistoryDemandsModel_msg * activitymodel = [[WOTMyHistoryDemandsModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  activitymodel;
        
        
    } response:response];
}


+(void)getMyAppointmentWithUserId:(NSNumber *)userId   response:(response)response{
    
    NSString *applyurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Visitor/findVisitorByUserId"];
    NSDictionary *parameters = @{@"userId":userId};
    [self doRequestWithParameters:parameters useUrl:applyurl  complete:^JSONModel *(id responseobj) {
        WOTAppointmentModel_msg *model = [[WOTAppointmentModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  model;
    } response:response];
}


+(void)postRepairApplyWithUserId:(NSString *)userId type:(NSString *)type info:(NSString *)info appointmentTime:(NSString *)appointmentTime address:(NSString *)address file:(NSArray<UIImage *> *)file alias:(NSString *)alias  response:(response)response{
    
    NSString *applyurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/MaintainInfo/addMaintainInfo"];
    NSDictionary *parameters = @{@"userId":userId,@"alias":alias,@"type":type,@"info":info,@"appointmentTime":appointmentTime,@"address":address};
    [self doFileRequestWithParameters:parameters useUrl:applyurl image:file complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return  model;
    } response:response];
}



#pragma mark - 订单
+(void)generateOrderWithSpaceId:(NSNumber *)spaceId commodityNum:(NSNumber *)commNum commodityKind:(NSNumber *)commKind productNum:(NSNumber *)productNum startTime:(NSString *)startTime endTime:(NSString *)endTime money:(CGFloat)money dealMode:(NSString *)dealMode payType:(NSNumber *)payType payObject:(NSString *)payObject payMode:(NSNumber *)payMode contractMode:(NSNumber *)contractMode response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/Order/addOrderOrUpdate",HTTPBaseURL];
    NSString *deviceip = [[WOTConfigThemeUitls shared] getIPAddress];
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"facilitator":@(00001),
                                 @"carrieroperator":@(00002),
                                 @"body":@"易创客",
                                 @"total_fee":@(1),
                                 @"spbill_create_ip":deviceip,
                                 @"trade_type":@"APP",
                                 @"spaceId":spaceId,
                                 @"commodityNum":commNum,
                                 @"commodityKind":commKind,
                                 @"productNum":productNum,
                                 @"starTime":startTime,
                                 @"endTime":endTime,
                                 @"money":@(money),
                                 @"dealMode":dealMode,
                                 @"payType":payType,
                                 @"payObject":payObject,
                                 @"payMode":payMode,
                                 @"contractMode":contractMode,
                                 };
    
    [self doRequestWithParameters:parameters useUrl:url  complete:^JSONModel *(id responseobj) {
        WOTWXPayModel_msg *model = [[WOTWXPayModel_msg alloc]initWithDictionary:responseobj error:nil];
        //调用支付接口
        PayReq *payRequest = [[PayReq alloc]init];
        payRequest.partnerId = model.msg.mch_id;//商户id
        payRequest.prepayId = model.msg.prepay_id;//预支付订单编号
        payRequest.package = model.msg.package;//商家根据财付通文档填写的数据和签名
        payRequest.nonceStr = model.msg.nonce_str;//随机串，防重发
        payRequest.timeStamp = (UInt32)model.msg.timeStamp.integerValue;//时间戳，防重发
        payRequest.sign = model.msg.sign;//商家根据微信开放平台文档对数据做的签名
        [WXApi sendReq:payRequest];
        return  model;
    } response:response];
}

#pragma mark - 社交

+(void)sendMessageToSapceWithSpaceId:(NSNumber *)spaceId text:(NSString *)text images:(NSArray *)images response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/Share/addShare",HTTPBaseURL];
    NSDictionary *parameters = @{@"userId":[WOTUserSingleton shareUser].userInfo.userId,
                                 @"spaceId":spaceId,
                                 @"textWord":text,
                                 };
    
    [WOTHTTPNetwork doFileRequestWithParameters:parameters useUrl:url image:images complete:^JSONModel *(id responseobj) {
        WOTSendFriendsModel_msg *model = [[WOTSendFriendsModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model;
    } response:response];
}

+(void)getMessageBySapceIdWithSpaceId:(NSNumber *)spaceId response:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@/Share/findBySpaceId",HTTPBaseURL];
    NSDictionary *parameters = @{
                                 @"spaceId":spaceId,
                                 };
    
    [WOTHTTPNetwork doRequestWithParameters:parameters useUrl:url complete:^JSONModel *(id responseobj) {
        WOTFriendsMessageListModel_msg *model12 = [[WOTFriendsMessageListModel_msg alloc] initWithDictionary:responseobj error:nil];
        return model12;
    } response:response];
    
}

@end
