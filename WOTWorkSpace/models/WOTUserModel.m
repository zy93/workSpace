//
//  WOTUserModel.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUserModel.h"

@implementation WOTUserModel
-(instancetype)initWithuserId:(NSString *)userId userName:(NSString *)userName password:(NSString *)password tel:(NSString *)tel email:(NSString *)email realName:(NSString *)realName sex:(NSString *)sex headPortrait:(NSString *)headPortrait birthDate:(NSString *)birthDate companyId:(NSString *)companyId companyName:(NSString *)companyName userType:(NSString *)userType registerTime:(NSString *)registerTime state:(NSString *)state site:(NSString *)site skill:(NSString *)skill interest:(NSString *)interest industry:(NSString *)industry spared1:(NSString *)spared1 spared2:(NSString *)spared2 spared3:(NSString *)spared3{
    self = [super init];
    if (self) {
        self.userId = userId;
        self.userName = userName;
        self.password = password;
        self.tel = tel;
        self.email = email;
        self.realName = realName;
        self.sex = sex;
        self.headPortrait = headPortrait;
        self.birthDate = self.birthDate;
        self.companyId = self.companyId;
        self.companyName = self.companyName;
        self.userType  = self.userType;
        self.registerTime = self.registerTime;
        self.skill = self.skill;
        self.interest = interest;
        self.industry = self.industry;
        self.spared1 = self.spared1;
        self.spared2 = self.spared2;
        self.spared3 = self.spared3;
    }
    
    return self;
}
@end
