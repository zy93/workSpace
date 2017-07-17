//
//  WOTUserModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTUserModel : NSObject
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, strong) NSString *companyId;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *registerTime;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *skill;
@property (nonatomic, strong) NSString *interest;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *spared1;
@property (nonatomic, strong) NSString *spared2;
@property (nonatomic, strong) NSString *spared3;


-(instancetype)initWithuserId:(NSString *)userId userName:(NSString *)userName password:(NSString *)password tel:(NSString *)tel email:(NSString *)email realName:(NSString *)realName sex:(NSString *)sex headPortrait:(NSString *)headPortrait birthDate:(NSString *)birthDate companyId:(NSString *)companyId companyName:(NSString *)companyName userType:(NSString *)userType registerTime:(NSString *)registerTime state:(NSString *)state site:(NSString *)site skill:(NSString *)skill interest:(NSString *)interest industry:(NSString *)industry spared1:(NSString *)spared1 spared2:(NSString *)spared2 spared3:(NSString *)spared3;
@end
