//
//  WOTSpaceCityCollectionCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSpaceCityCollectionCell.h"

@implementation WOTSpaceCityCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_cityName setDefaultRadiuWithCorners:UIRectCornerAllCorners];
    // Initialization code
}
- (IBAction)changeCity:(id)sender {
}

@end
