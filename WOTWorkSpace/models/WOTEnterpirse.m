//
//  WOTEnterpirse.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTEnterpirse.h"

@implementation WOTEnterpirse
-(instancetype)initWithImage:(NSString *)imageUrl enterpriseName:(NSString *)enterpriseName enterpriseInfo:(NSString *)enterpriseInfo{
    self = [super init];
    if (self) {
        self.imageUrl = imageUrl;
        self.enterpriseName = enterpriseName;
        self.enterpriseInfo = enterpriseInfo;
    }
    return self;
}
@end
