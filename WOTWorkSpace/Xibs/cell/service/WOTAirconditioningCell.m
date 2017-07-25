//
//  WOTAirconditioningCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTAirconditioningCell.h"
@interface WOTAirconditioningCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnWidth;

@end

@implementation WOTAirconditioningCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnWidth.constant = (self.bgview.frame.size.width-60)/4;
    [[WOTConfigThemeUitls shared]setLabelColorss:@[_refrigerationLabel,_heatingLabel,_fanspeedLabel] withColor:MiddleTextColor];
    [_lowBtn setTitleColor:MiddleTextColor forState:UIControlStateNormal];
    [_middleBtn setTitleColor:MiddleTextColor forState:UIControlStateNormal];
    [_highBtn setTitleColor:MiddleTextColor forState:UIControlStateNormal];
    [_cellSwitch setOn:NO];
    [_controlView setCorenerRadius:10 borderColor:CLEARCOLOR];
    _bgview.hidden = YES;
    [_controlView setShadow:Black];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)switchAction:(id)sender {
    
    _bgview.hidden = _cellSwitch.isOn ? NO:YES;
    if (_delegate) {
        [self.delegate switchChangeState:_cellSwitch.isOn];
    }
    
}
- (IBAction)lowAction:(id)sender {



}
- (IBAction)middleAction:(id)sender {
    
}
- (IBAction)highAction:(id)sender {
}
- (IBAction)autoControlAction:(id)sender {
}
- (IBAction)refrigerationAction:(id)sender {
}

- (IBAction)fanspeedAction:(id)sender {
}

- (IBAction)heatingAction:(id)sender {
}

- (IBAction)temperatureControl:(id)sender {
    
    
}




@end
