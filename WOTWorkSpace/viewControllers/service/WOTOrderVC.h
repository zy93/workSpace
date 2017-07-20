//
//  WOTOrderVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTBookStationListModel.h"

@interface WOTOrderVC : UIViewController

@property (nonatomic, assign) BOOL isBookStation;

@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSNumber *conferenceId;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) WOTBookStationListModel *model;

@end
