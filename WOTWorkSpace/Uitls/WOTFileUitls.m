//
//  WOTFileUitls.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/6.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTFileUitls.h"

@implementation WOTFileUitls


+(NSDictionary *)readPlistFileForFileName:(NSString *)fileName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //    //添加一项内容
    //    //获取应用程序沙盒的Documents目录
    //    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //    NSString *plistPath1 = [paths objectAtIndex:0];
    return dataDic;
    
}

+(NSArray *)readArrayPlistFileForFileName:(NSString *)fileName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    //    //添加一项内容
    //    //获取应用程序沙盒的Documents目录
    //    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //    NSString *plistPath1 = [paths objectAtIndex:0];
    return dataArr;
    
}

@end
