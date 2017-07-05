//
//  WOTEnterpirse.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTEnterpirse : NSObject
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *enterpriseName;
@property(nonatomic,strong)NSString *enterpriseInfo;


-(instancetype)initWithImage:(NSString *)imageUrl enterpriseName:(NSString *)enterpriseName enterpriseInfo:(NSString *)enterpriseInfo;
@end
