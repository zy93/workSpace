//
//  WOTUserSingleton.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUserSingleton.h"

@implementation WOTUserSingleton
+(instancetype)currentUser{
    static WOTUserSingleton *currentUser;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        currentUser = [[self alloc]init];
    });
    return currentUser;
}


-(void)saveUserInfoToPlist:(NSDictionary *)userinfo{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];

    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"userinfo.plist"];
    //输入写入
    NSLog(@"fileName:%@",filename);
    [userinfo writeToFile:filename atomically:YES];

   
    
}
-(NSDictionary *)readUserInfoFromPlist{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
       NSString *filename=[plistPath1 stringByAppendingPathComponent:@"userinfo.plist"];
    NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    
    NSLog(@"%@", user);
    return user;
}
@end
