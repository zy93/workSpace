//
//  UIView+Extension.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/1.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView(Extension)

-(void)setDefaultRadiuWithCorners:(UIRectCorner)corners{
    [self setRadiuWithCorners:corners radiu:5];
}

-(void)setRadiuWithCorners:(UIRectCorner)corners radiu:(CGFloat)radiu{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radiu, radiu)].CGPath;
    self.layer.mask = shapeLayer;
    
}

-(void)setCorenerRadius:(CGFloat)radiu borderColor:(UIColor *)borderColor{
   
    self.layer.cornerRadius = radiu;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1;
}


@end
