//
//  WOTReservationsMeetingCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTReservationsMeetingCell.h"

@implementation WOTReservationsMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clipsToBounds = YES;
    [self.meetingImgBGView setBackgroundColor:COLOR(40, 43, 50, 0.6)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickSubmit:(id)sender {
    if ([_delegate respondsToSelector:@selector(submitReservations)]) {
        [_delegate submitReservations];
    }
}

@end
