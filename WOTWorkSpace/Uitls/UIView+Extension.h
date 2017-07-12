//
//  UIView+Extension.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/1.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(Extension)
//对指定角设置默认圆角
-(void)setDefaultRadiuWithCorners:(UIRectCorner)corners;
//对指定角设置圆角，并指定圆角弧度
-(void)setRadiuWithCorners:(UIRectCorner)corners radiu:(CGFloat)radiu;

-(void)setCorenerRadius:(CGFloat)radiu borderColor:(UIColor *)borderColor;


-(UIImage *)toImage;
@end
