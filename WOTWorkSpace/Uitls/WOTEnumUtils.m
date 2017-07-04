//
//  WOTEnumUtils.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTEnumUtils.h"

#import "WOTEnums.h"
@implementation WOTEnumUtils
-(WOT3DBallVCType)Wot3DballVCtypeenumToString:(NSString *)ballTitle{
  
    for (NSString *title in [WOTSingtleton shared].ballTitle) {
        if ([title isEqualToString:@"友邻"]) {
            return WOTEnterprise;
        }
    }

    return  WOTOthers;
}
@end
