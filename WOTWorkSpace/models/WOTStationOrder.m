//
//  WOTStationOrder.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTStationOrder.h"

@implementation WOTStationOrder
-(instancetype)initWithPlace:(NSString *)spacePlace orderDate:(NSString *)orderDate orderTime:(NSString *)orderTime orderMoney:(NSString *)orderMoney{
    self = [super init];
    if (self) {
        self.spacePlace = spacePlace;
        self.orderDate = orderDate;
        self.orderTime = orderTime;
        self.orderMoney = orderMoney;
    }
    return  self;
}


@end
