//
//  WOTHttp.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTHttp.h"
#import "XMLReader.h"
@implementation WOTHttp



//重新封装参数
+ (NSString *)parseParams:(NSDictionary *)params
{

    NSLog(@"请求参数:%@",params);
    
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    
    //加密处理 将所有参数加密后结果当做参数传递
    //parameters = @{@"i":@"加密结果 抽空加入"};
    
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&", key, [params valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    return result;
}


+(void)doRequestWithParameters:(NSDictionary *)parameters useUrl:(NSString *)Url complete:(JSONModel *(^)(id responseobj))complete andBlock:(void(^)(id responseObject,NSError *error))block {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",  @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json", nil];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
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



@end
