//
//  WOTSingtleton.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTSingtleton : NSObject
+(instancetype)shared;
@property(nonatomic,strong)NSMutableArray *spaceCityArray;
@property(nonatomic,strong)NSArray *ballTitle;
@property(nonatomic,assign)BOOL isuserLogin ;
@end
