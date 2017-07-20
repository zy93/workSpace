//
//  WOTBookStationListModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WOTBookStationListModel : JSONModel


@property (nonatomic, strong) NSNumber *conferenceId;
@property (nonatomic, strong) NSString *conferenceName;
@property (nonatomic, strong) NSString *conferenceDescribe;
@property (nonatomic, strong) NSString *conferencePicture;
@property (nonatomic, strong) NSString *openTime;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSNumber *conferenceState;
@property (nonatomic, strong) NSNumber *conferencePrice;
@property (nonatomic, strong) NSNumber *conferenceType;
@property (nonatomic, strong) NSString *spared1;
@property (nonatomic, strong) NSString *spared2;
@property (nonatomic, strong) NSString *spared3;


@end
