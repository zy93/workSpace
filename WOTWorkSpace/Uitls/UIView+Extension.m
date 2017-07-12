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


-(UIImage *)toImage{
    UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, self.bounds.size.height));
    CGContextRef currentContex = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:currentContex];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self cutImage:result size:self.bounds.size];
    return result;
    
}



//裁剪图片
/**
 *
 *
 */
- (UIImage *)cutImage:(UIImage*)originImage size:(CGSize)viewsize
{
    CGSize newImageSize;
    CGImageRef imageRef = nil;
    
    CGSize imageViewSize = viewsize;
    CGSize originImageSize = originImage.size;
    
    if ((originImageSize.width / originImageSize.height) < (imageViewSize.width / imageViewSize.height))
    {
        // imageView的宽高比 > image的宽高比
        newImageSize.width = originImageSize.width;
        newImageSize.height = imageViewSize.height * (originImageSize.width / imageViewSize.width);
        
        imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake(0, fabs(originImageSize.height - newImageSize.height) / 2, newImageSize.width, newImageSize.height));
    }
    else
    {
        // image的宽高比 > imageView的宽高比   ： 也就是说原始图片比较狭长
        newImageSize.height = originImageSize.height;
        newImageSize.width = imageViewSize.width * (originImageSize.height / imageViewSize.height);
        
        imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake(fabs(originImageSize.width - newImageSize.width) / 2, 0, newImageSize.width, newImageSize.height));
    }
    
    return [UIImage imageWithCGImage:imageRef];
}


@end
