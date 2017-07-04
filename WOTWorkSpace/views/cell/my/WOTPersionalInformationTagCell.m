//
//  WOTPersionalInformationTagCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTPersionalInformationTagCell.h"

@implementation WOTPersionalInformationTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}

-(void)loadtagsBtn{
    CGFloat leading = 20;
    CGFloat top  = 0;
    
    for (NSString *title in _tagLabelArray) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(leading, top,[title widthWithFont:[UIFont systemFontOfSize:15]]+15, 30);
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [label setRadiuWithCorners:UIRectCornerAllCorners radiu:10];
        label.layer.masksToBounds = YES;
        label.layer.borderColor = [UIColor blueColor].CGColor;
        label.layer.borderWidth = 1;
        [self.tagsVIew addSubview:label];
        leading += label.frame.size.width+10;
        
        if (leading>=SCREEN_WIDTH) {
             top += label.frame.size.height;
        }
       
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
