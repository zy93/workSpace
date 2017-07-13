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

#define HTTPURL @"http://192.168.6.219:8080/"

@implementation WOTHTTPNetwork

+(void)doRequestWithParameters:(NSDictionary *)parameters useUrl:(NSString *)Url complete:(JSONModel *(^)(id responseobj))complete andBlock:(void(^)(id responseObject,NSError *error))block {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    
    [manager POST:Url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
     
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
        if (error) {
            NSLog(@"http:----error:%@",error);
            block(nil,error);
        }
        
    }];
}


+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd response:(response)response
{
    NSDictionary *dic = @{@"tel" :telOrEmail, @"password":[WOTUitls md5HexDigestByString:pwd]};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPURL,@"workSpace/Login/Login"];
    
    [self doRequestWithParameters:dic useUrl:string complete:^JSONModel *(id responseobj) {
        WOTLoginModel *model = [[WOTLoginModel alloc] initWithDictionary:responseobj[@"msg"] error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
    
}



+(void)getActivitiesWithSpace:(NSInteger)workSpaceid activityType:(NSString *)activityType response:(response)response
{
    NSDictionary *dic = @{@"spaceId":[NSNumber numberWithInteger:workSpaceid]};
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPURL,@"workSpace/Activity/findBySpaceId"];
    
    [self doRequestWithParameters:dic useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTLoginModel *model = [[WOTLoginModel alloc] initWithDictionary:responseobj[@"msg"] error:nil];
        return model;
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
    
}
+(void)getAllSpace:(response)response{
    
     NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPURL,@"workSpace/Space/findAllSpace"];
    
    [self doRequestWithParameters:nil useUrl:urlstring complete:^JSONModel *(id responseobj) {
        WOTSpaceModel_msg * spacemodel = [[WOTSpaceModel_msg alloc]initWithDictionary:responseobj error:nil];
        
        return  spacemodel;
        
        
    } andBlock:^(id responseObject, NSError *error) {
        if (response) {
            response(responseObject,error);
        }
    }];
}
@end
