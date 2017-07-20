//
//  NSDate+Uitls.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "NSDate+Uitls.h"

@implementation NSDate (Uitls)

+(NSString *)getNewTimeZero
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY/MM/dd 00:00:00"];
    NSString *DateTime = [formatter stringFromDate:date];
//    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    return DateTime;
}

+(NSString *)getTomorrowTimeZero
{
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    [components setDay:([components day]+1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd 00:00:00"];
    NSString * DateTime =[dateday stringFromDate:beginningOfWeek];
//    NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
    return DateTime;
}


@end
