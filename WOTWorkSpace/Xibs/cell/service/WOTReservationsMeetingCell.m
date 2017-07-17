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
    self.selectTimeScroll.mDelegate = self;
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


#pragma mark - WOTScrollView Delegate
-(void)selectButton:(NSInteger)btnTage
{
    if ([_delegate respondsToSelector:@selector(selectTimeWithTag:)]) {
        [_delegate selectTimeWithTag:btnTage];
    }
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
