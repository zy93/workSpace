//
//  WOTOrderForBookStationCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForBookStationCell.h"
#import "MBProgressHUD+Extension.h"
@interface WOTOrderForBookStationCell()

@property (nonatomic, assign)int orderNumberInt;
//@property (nonatomic, assign)int

@end

@implementation WOTOrderForBookStationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectStartTime:(id)sender {
    
}

- (IBAction)selectEndTime:(id)sender {
    
}

- (IBAction)subButton:(id)sender {
    
}

- (IBAction)addButton:(id)sender {
    _orderNumberInt = [self.orderNumber.text intValue];
    _orderNumberInt +=1;
    if (_orderNumberInt > [self.spaceModel.alreadyTakenNum intValue]) {
//       [MBProgressHUDUtil showMessage:@"数量超过剩余最大工位数量" toView:self.view];
    }
    
}

@end
