//
//  JudgmentTime.m
//  ConstraintDemo
//
//  Created by 编程 on 2017/9/25.
//  Copyright © 2017年 wxd. All rights reserved.
//

#import "JudgmentTime.h"

@implementation JudgmentTime

-(BOOL)judgementTimeWithYear:(NSInteger) year month:(NSInteger)month day:(NSInteger)day
{
    NSDate * date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    BOOL isValidYear = [[formatter stringFromDate:date] intValue] > year;
    [formatter setDateFormat:@"MM"];
    BOOL isValidMonth1 = [[formatter stringFromDate:date] intValue] > month;
    BOOL isValidMonth2 = [[formatter stringFromDate:date] intValue] == month;
    [formatter setDateFormat:@"dd"];
    BOOL isValidDay = [[formatter stringFromDate:date] intValue] > day;
    if (isValidYear) {
        return NO;
    }
    if (isValidMonth1) {

        return NO;
    }
    if (isValidMonth2 && isValidDay) {
        return NO;
    }
    return YES;
}
@end
