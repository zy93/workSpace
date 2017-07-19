//
//  WOTReservationsMeetingCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTReservationsMeetingCell.h"
#import "WOTReservationsMeetingVC.h"

@implementation WOTReservationsMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clipsToBounds = YES;
    [self.meetingImgBGView setBackgroundColor:COLOR(40, 43, 50, 0.6)];
    self.selectTimeScroll.mDelegate = self;
    self.selectIndicationView.layer.borderColor = UIColor_gray_d6.CGColor;
    self.selectIndicationView.layer.borderWidth = 1.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickSubmit:(id)sender {
    if ([_delegate respondsToSelector:@selector(submitReservationsCell:)]) {
        [_delegate submitReservationsCell:self];
    }
}


#pragma mark - WOTScrollView Delegate
-(void)selectButton:(WOTScrollButton *)button
{
    if ([_delegate respondsToSelector:@selector(selectTimeWithCell:Time:)]) {
        [_delegate selectTimeWithCell:self Time:button.time];
    }
    [self setNeedsLayout];
}

-(void)setModel:(WOTMeetingListModel *)model
{
    _model = model;
    [self.meetingNameLab setText:model.conferenceName];
    [self.meetingInfoLab setText:model.conferenceDescribe];
    [self.meetingPriceLab setText:[NSString stringWithFormat:@"%d元/小时",[model.conferencePrice intValue]]];
    //
    [self.selectTimeScroll setOpenTime:model.openTime];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    WOTReservationsMeetingVC *vc = (WOTReservationsMeetingVC *)[self GetSubordinateControllerForSelf];
    CGFloat time = vc.endTime - vc.beginTime;
    NSString *str =[NSString stringWithFormat:@"共%.1f小时",time];
    self.TimeStatisticLab.text = str;
    self.timeStatisticsLab.text = [NSString stringWithFormat:@"%@-%@",[NSString floatTimeConvertStringTime:vc.beginTime],[NSString floatTimeConvertStringTime:vc.endTime]];
}

#pragma mark - touches

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
}

@end
