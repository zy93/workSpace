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
 * 无参数获取全部空间
 */
+(void)getAllSpaceWithCity:(NSString *)city block:(response)response{
    
     NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/Space/findAllSpace"];
     NSDictionary * parameters = @{@"city":city};
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
+(void)getFlexSliderSouceInfo:(response)response{
    NSString *sliderurl = [NSString stringWithFormat:@"%@%@",HTTPBaseURL,@"/Slider/findAll"];
    [self doRequestWithParameters:nil useUrl:sliderurl complete:^JSONModel *(id responseobj) {
        WOTSliderModel_msg *model = [[WOTSliderModel_msg alloc]initWithDictionary:responseobj error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}
@end
