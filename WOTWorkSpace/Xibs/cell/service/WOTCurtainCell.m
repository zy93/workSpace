//
//  WOTCurtainCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTCurtainCell.h"

@implementation WOTCurtainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentBGView.backgroundColor=[UIColor whiteColor];
    self.contentBGView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.contentBGView.layer.shadowRadius = 4.f;
    self.contentBGView.layer.shadowOpacity = 0.2f;
    self.contentBGView.layer.shadowOffset = CGSizeMake(1, 1);
    self.contentBGView.layer.cornerRadius = 4.f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
