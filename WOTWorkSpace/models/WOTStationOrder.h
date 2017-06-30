//
//  WOTStationOrder.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTStationOrder : NSObject
@property(nonatomic,strong)NSString *spacePlace;
@property(nonatomic,strong)NSString *orderDate;
@property(nonatomic,strong)NSString *orderTime;
@property(nonatomic,strong)NSString *orderMoney;

-(instancetype)initWithPlace:(NSString *)spacePlace orderDate:(NSString *)orderDate orderTime:(NSString *)orderTime orderMoney:(NSString *)orderMoney;
@end
