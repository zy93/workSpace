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
+(void)doRequestWithParameters:(NSDictionary *)parameters useUrl:(NSString *)Url complete:(JSONModel *(^)(id responseobj))complete andBlock:(void(^)(id responseObject,NSError *error))block {
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",  @"text/html",
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
        
        NSInteger statusCode = [responseDic[@"code"] integerValue];
        if (statusCode == 200) {

            
            if (complete(responseDic) == nil) {
                NSError *error = [NSError errorWithDomain:@"JSONModel" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"json convert to response failed!"}];
                block(nil,error);
            } else {
                if (block) {
                    block(complete(responseDic),nil);
                }
            }
            
        } else if (statusCode == 202)
        {
            NSError *error = [NSError errorWithDomain:@"WOTWorkSpace" code:202 userInfo:@{NSLocalizedDescriptionKey:@"暂无数据"}];
            block(nil,error);
        } else if (statusCode == 500){
            NSError *error = [NSError errorWithDomain:@"WOTWorkSpace" code:500 userInfo:@{NSLocalizedDescriptionKey:@"请求失败，请重试"}];
            block(nil,error);
        }
        else{
            NSError *error = [NSError errorWithDomain:@"WOTWorkSpace" code:503 userInfo:@{NSLocalizedDescriptionKey:@"请求超时，请重试"}];
            block(nil,error);
            NSLog(@"----error:%@",error);
         
        }
        
        if (error) {
            NSLog(@"----error:%@",error);
            block(nil,error);
            return ;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"request URL: %@",task.originalRequest.URL.absoluteString);
        
       
                NSError *err = [NSError errorWithDomain:@"WOTWorkSpace" code:error.code userInfo:@{NSLocalizedDescriptionKey:@"网络异常，请重试"}];
                block(nil,err);

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
+(void)doFileRequestWithParameters:(NSDictionary *)parameters useUrl:(NSString *)Url image:(NSArray<UIImage *> *)images complete:(JSONModel *(^)(id responseobj))complete andBlock:(void(^)(id responseObject,NSError *error))block {
    
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
     
            if (complete(responseDic) == nil) {
                NSError *error = [NSError errorWithDomain:@"JSONModel" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"json convert to response failed!"}];
                block(nil,error);
            } else {
                if (block) {
                    block(complete(responseDic),nil);
                }
            }
            
        } else if (statusCode == 202)
        {
            NSError *error = [NSError errorWithDomain:@"WOTWorkSpace" code:202 userInfo:@{NSLocalizedDescriptionKey:@"暂无数据"}];
            block(nil,error);
        } else if (statusCode == 500){
            NSError *error = [NSError errorWithDomain:@"WOTWorkSpace" code:500 userInfo:@{NSLocalizedDescriptionKey:@"请求失败，请重试"}];
            block(nil,error);
        }
        else {
            NSLog(@"----error:%@",error);
            block(nil,error);
        }
        
        if (error) {
            NSLog(@"----error:%@",error);
            block(nil,error);
            return ;
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败%@",error);
        NSLog(@"request URL: %@",task.originalRequest.URL.absoluteString);
        
        
        NSError *err = [NSError errorWithDomain:@"WOTWorkSpace" code:error.code userInfo:@{NSLocalizedDescriptionKey:@"网络异常，请重试"}];
        block(nil,err);

        
        
    }];
  
}


//登录
+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd response:(response)response
{
    NSDictionary *dic = @{@"tel" :telOrEmail, @"password":[WOTUitls md5HexDigestByString:pwd]};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Login/Login"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTLoginModel *model = [[WOTLoginModel alloc] initWithDictionary:responseobj[@"msg"] error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
    
}

+(void)userGetVerifyWitTel:(NSString *)tel response:(response)response
{
    NSDictionary *dic = @{@"tel" :tel};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Login/sendVerify"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTGetVerifyModel *model = [[WOTGetVerifyModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}

+(void)userRegisterWitUserNick:(NSString *)nick tel:(NSString *)tel password:(NSString *)pass response:(response)response
{
    NSDictionary *dic = @{@"tel" :tel, @"nick": nick, @"password":[WOTUitls md5HexDigestByString:pass]};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Login/register"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTRegisterModel *model = [[WOTRegisterModel alloc] initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}

+(void)getAllSpaceWithCity:(NSString *)city block:(response)response{
    
     NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Space/findAllSpace"];
    NSDictionary *parameters;
    if (city != nil) {
        parameters = @{@"city":city};
    }

    [self doRequestWithParameters:parameters useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTSpaceModel_msg * spacemodel = [[WOTSpaceModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  spacemodel;
        
        
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
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
        
        
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}

+(void)getSpaceWithLocation:(CGFloat)lat lon:(CGFloat)lon response:(response)response
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Space/findNearSpace"];
    NSDictionary * parameters = @{@"lng":@(lon),
                                  @"lat":@(lat)};
    
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        WOTLocationModel_Msg * activitymodel = [[WOTLocationModel_Msg alloc]initWithDictionary:responseobj error:nil];
        
        return  activitymodel;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}

+(void)getActivitiesWithSpaceId:(NSNumber *)spaceid spaceState:(NSNumber *)spaceState  response:(response)response{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Activity/findByState"];
    NSDictionary * parameters = @{@"activityState":spaceState};
    
     [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
         
         WOTActivityModel_msg * activitymodel = [[WOTActivityModel_msg alloc]initWithDictionary:responseobj error:nil];
         
         return  activitymodel;
         
         
     } andBlock:^(id responseObject, NSError *error) {
         if (response) {
             response(responseObject,error);
         }
     }];
}


+(void)getEnterprisesWithSpaceId:(NSNumber *)spaceid response:(response)response{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/CompanyInfo/findBySpaceId"];
    NSDictionary * parameters = @{@"spaceId":spaceid};
    
    [self doRequestWithParameters:parameters useUrl:urlString complete:^JSONModel *(id responseobj) {
        
        WOTEnterpriseModel_msg * enterprisemodel = [[WOTEnterpriseModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  enterprisemodel;
        
        
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}

+(void)getAllNewInformation:(response)response{
    NSString *infourl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Message/findAllMessageToApp"];
    [self doRequestWithParameters:nil useUrl:infourl complete:^JSONModel *(id responseobj) {
        WOTNewInformationModel_msg *infomodel = [[WOTNewInformationModel_msg alloc]initWithDictionary:responseobj error:nil];
        return infomodel;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}

+(void)getHomeSliderSouceInfo:(response)response{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Slider/findByHome"];
    [self doRequestWithParameters:nil useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTSliderModel_msg *model = [[WOTSliderModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}



+(void)getServeSliderSouceInfo:(response)response{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Slider/findByServe"];
    [self doRequestWithParameters:nil useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTSliderModel_msg *model = [[WOTSliderModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}




+(void)getMyHistoryFeedBackData:(NSNumber *)userId response:(response)response{
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Opinion/findByUserId"];
     NSDictionary * parameters = @{@"userId":userId};
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTMyFeedBackModel_msg *model = [[WOTMyFeedBackModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}




+(void)registerServiceBusiness:(NSString *)userId firmName:(NSString *)firmName businessScope:(NSString *)businessScope contatcts:(NSString *)contatcts tel:(NSString *)tel facilitatorType:(NSString *)facilitatorType facilitatorState:(NSNumber *)facilitatorState firmLogo:(NSArray<UIImage *> *)firmLogo     response:(response)response{
    
    
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/FacilitatorInfo/addInfo"];
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userId,@"userId",firmName,@"firmName",businessScope,@"businessScope",contatcts,@"contatcts",tel,@"tel",facilitatorType,@"facilitatorType",nil];
    if (facilitatorState) {
        [parameters setValue:facilitatorState forKey:@"facilitatorState"];

    }
    
    
    [self doFileRequestWithParameters:parameters useUrl:registerurl image:firmLogo complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
  
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
    } andBlock:^(id responseObject, NSError *error) {
        response(nil, nil);
    }];
    
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
    } andBlock:^(id responseObject, NSError *error) {
        response(nil, error);
    }];
}






/****************           Service        ****************************/
#pragma mark - Service
+(void)getMeetingRoomListWithSpaceId:(NSNumber *)spaceid response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Conference/findBySpaceId"];
    NSDictionary *dic = @{@"spaceId":spaceid};
    [self doRequestWithParameters:dic useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTMeetingListModel_msg1 *model = [[WOTMeetingListModel_msg1 alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
    

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
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
    
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
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
   }





+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSString *)spaceId userId:(NSString *)userId facilitatorType:(NSString *)facilitatorType facilitatorLabel:(NSString *)facilitatorLabel  response:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/GetFacilitator/addGetFacilitator"];
   
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:describe,@"describe",spaceId,@"spaceId",userId,@"userId",facilitatorType,@"facilitatorType",facilitatorLabel,@"facilitatorLabel",nil];
   
    [self doRequestWithParameters:parameters useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
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
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}

#pragma mark - Site
+(void)getAllSiteResponse:(response)response
{
    NSString *url = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Site/findAllSite"];
    [self doRequestWithParameters:nil useUrl:url complete:^JSONModel *(id responseobj) {
         WOTSiteModel_Msg *model = [[WOTSiteModel_Msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
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
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
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
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
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
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}


+(void)getAllServiceTypes:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/FacilitatorLabel/findAll"];
    
    [self doRequestWithParameters:nil useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTServiceCategoryModel_msg *model = [[WOTServiceCategoryModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}
+(void)getBookStationInfoWithSpaceId:(NSNumber *)spaceid response:(response)response
{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Station/findAllStation"];
    [self doRequestWithParameters:nil useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTReservationsResponseModel_msg *model = [[WOTReservationsResponseModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}


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
        
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}


+(void)getUserEnterpriseWithCompanyId:(NSString *)companyId response:(response)response{
    
    NSString *myenterpriseurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/CompanyInfo/findMyCompany"];
    NSDictionary *parameters = @{@"companyId":companyId};
    [self doRequestWithParameters:parameters useUrl:myenterpriseurl complete:^JSONModel *(id responseobj) {
            WOTEnterpriseModel_msg * activitymodel = [[WOTEnterpriseModel_msg alloc]initWithDictionary:responseobj error:nil];
            
            return  activitymodel;
      
        
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}





+(void)getDemandsWithUserId:(NSNumber *)userId response:(response)response{
    
    NSString *demandsurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/GetFacilitator/findByUserId"];
    NSDictionary *parameters = @{@"userId":userId};
    [self doRequestWithParameters:parameters useUrl:demandsurl complete:^JSONModel *(id responseobj) {
        WOTMyHistoryDemandsModel_msg * activitymodel = [[WOTMyHistoryDemandsModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  activitymodel;
        
        
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}


+(void)getMyAppointmentWithUserId:(NSNumber *)userId   response:(response)response{
    
    NSString *applyurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Visitor/findVisitorByUserId"];
    NSDictionary *parameters = @{@"userId":userId};
    [self doRequestWithParameters:parameters useUrl:applyurl  complete:^JSONModel *(id responseobj) {
        WOTAppointmentModel_msg *model = [[WOTAppointmentModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}


+(void)postRepairApplyWithUserId:(NSString *)userId type:(NSString *)type info:(NSString *)info appointmentTime:(NSString *)appointmentTime address:(NSString *)address file:(NSArray<UIImage *> *)file alias:(NSString *)alias  response:(response)response{
    
    NSString *applyurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/MaintainInfo/addMaintainInfo"];
    NSDictionary *parameters = @{@"userId":userId,@"alias":alias,@"type":type,@"info":info,@"appointmentTime":appointmentTime,@"address":address};
    [self doFileRequestWithParameters:parameters useUrl:applyurl image:file complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
        
        return  model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}


@end
