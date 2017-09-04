//
//  WOTUserSingleton.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTUserSingleton : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *companyId;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSString *constellation;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *skill;
@property (nonatomic, strong) NSString *interests;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *spared1;

+(instancetype)shareUser;
-(void)saveUserInfoToPlist:(NSDictionary *)userinfo;
-(void)setValues;
@end
