//
//  WOTReservationsMeetingCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTSelectScrollView.h"

@protocol WOTReservationsMeetingCellDelegate <NSObject>

-(void)submitReservations;

@end


@interface WOTReservationsMeetingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *meetingImg;
@property (weak, nonatomic) IBOutlet UILabel *meetingNameLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingInfoLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingPriceLab;
@property (weak, nonatomic) IBOutlet WOTSelectScrollView *selectTimeScroll;
@property (weak, nonatomic) IBOutlet UIButton *subTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *addTimeBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeStatisticsLab;
@property (weak, nonatomic) IBOutlet UILabel *timeScopeLab;
@property (weak, nonatomic) IBOutlet UILabel *meetingOpenTimeLab;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *meetingImgBGView;

@property (weak, nonatomic) id <WOTReservationsMeetingCellDelegate> delegate;

@end
