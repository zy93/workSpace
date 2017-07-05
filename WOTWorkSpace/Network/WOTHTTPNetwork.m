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


#define HTTPURL @"http://192.168.6.219:8080/"

@implementation WOTHTTPNetwork

+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd response:(response)response
{
    NSDictionary *dic = @{@"tel" :telOrEmail, @"password":[WOTUitls md5HexDigestByString:pwd]};
    //afn
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPURL,@"workSpace/Login/Login"];
    
    [manager POST:string parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *error = nil;
//        NSString *string
        WOTLoginModel *model = [[WOTLoginModel alloc] initWithDictionary:responseObject[@"msg"] error:&error];
        if (error) {
            NSLog(@"----error:%@",error);
            return ;
        }
        if (response) {
            response(model);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"http:----error:%@",error);
        }
        
    }];
    
    
}

@end
