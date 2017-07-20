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
#import "WOTBookStationListModel.h"
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


+(void)doFileRequestWithParameters:(NSDictionary *)parameters useUrl:(NSString *)Url image:(NSArray<UIImage *> *)images complete:(JSONModel *(^)(id responseobj))complete andBlock:(void(^)(id responseObject,NSError *error))block {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    
    [manager POST:Url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
//        NSData *data = UIImagePNGRepresentation(image);
//        //上传的参数(上传图片，以文件流的格式)
//        [formData appendPartWithFileData:data
//                                    name:@"firmLogo"
//                                fileName:@"gauge.png"
//                                mimeType:@"image/png"];
        
        
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData;
            imageData = UIImageJPEGRepresentation(image,1.f);
            if (!imageData) {
                imageData = UIImagePNGRepresentation(image);
            }
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"上传成功");
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败%@",error);
        
        
        
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


/**
 * 获取空间列表
 *parameter：传入城市 string类型，不传参，返回全部数据
 */
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

/**
 *  根据空间id 和状态请求筛选 获取活动列表
 */
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

/**
 *获取空间下的友邻企业
 *parameter:spaceid  空间id
 * block: 对象返回上层，错误返回error
 */
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

/**
 *获取全部资讯列表 
 */
+(void)getAllNewInformation:(response)response{
    NSString *infourl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Message/findAllMessage"];
    [self doRequestWithParameters:nil useUrl:infourl complete:^JSONModel *(id responseobj) {
        WOTNewInformationModel_msg *infomodel = [[WOTNewInformationModel_msg alloc]initWithDictionary:responseobj error:nil];
        return infomodel;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}
/**
 *获取首页轮播图资源数据
 */
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


/**
 *获取我的历史--反馈列表数据
 */


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


/**
 *注册成为平台服务商
 */

+(void)registerServiceBusiness:(NSString *)userId firmName:(NSString *)firmName businessScope:(NSString *)businessScope contatcts:(NSString *)contatcts tel:(NSString *)tel facilitatorType:(NSString *)facilitatorType facilitatorState:(NSNumber *)facilitatorState firmLogo:(NSArray<UIImage *> *)firmLogo     response:(response)response{
    
    
    NSString *registerurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/FacilitatorInfo/addInfo"];
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userId,@"userId",firmName,@"firmName",businessScope,@"businessScope",contatcts,@"contatcts",tel,@"tel",facilitatorType,@"facilitatorType",nil];
    if (facilitatorState) {
        [parameters setValue:facilitatorState forKey:@"facilitatorState"];

    }
    
    
    [self doFileRequestWithParameters:parameters useUrl:registerurl image:firmLogo complete:^JSONModel *(id responseobj) {
        WOTMyFeedBackModel_msg *model = [[WOTMyFeedBackModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        response (nil, nil);
    }];
    
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
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
    

}

/**
 *提交意见反馈
 */
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




/**
 *服务--发布需求页面
 */
+(void)postServiceRequestWithDescribe:(NSString *)describe spaceId:(NSNumber *)spaceId userId:(NSNumber *)userId facilitator_type:(NSString *)facilitator_type time:(NSDate   *)time  response:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/GetFacilitator/addGetFacilitator"];
   
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc]initWithObjectsAndKeys:describe,@"describe",spaceId,@"spaceId",userId,@"userId",facilitator_type,@"facilitator_type",time,@"time",nil];
   
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
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Conferencedetails/subscriByTime"];
    NSDictionary *dic = @{@"spaceId":spaceid,
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


/**
 *服务--获取服务商类别
 */
+(void)getAllServiceTypes:(response)response{
    
    NSString *feedbackurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/FacilitatorLabel/findAll"];
    

    
    [self doRequestWithParameters:nil useUrl:feedbackurl complete:^JSONModel *(id responseobj) {
        WOTBaseModel *model = [[WOTBaseModel alloc]initWithDictionary:responseobj error:nil];
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

@end
