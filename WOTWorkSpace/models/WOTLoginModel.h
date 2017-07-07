//
//  WOTLoginModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WOTLoginModel : JSONModel

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSNumber *birthDate;
@property (nonatomic, strong) NSNumber *companyId;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSNumber *userType;
@property (nonatomic, strong) NSNumber *registerTime;
@property (nonatomic, strong) NSNumber *state;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSString *skill;
@property (nonatomic, strong) NSString *interest;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *spared1;
@property (nonatomic, strong) NSString *spared2;
@property (nonatomic, strong) NSString *spared3;


@end
