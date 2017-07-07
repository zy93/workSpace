//
//  WOTFileUitls.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/6.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTFileUitls : NSObject

//读取程序开发时配置plist文件
+(NSDictionary *)readPlistFileForFileName:(NSString *)fileName;
+(NSArray *)readArrayPlistFileForFileName:(NSString *)fileName;
@end
