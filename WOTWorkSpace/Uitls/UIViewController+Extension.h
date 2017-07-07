//
//  UIViewController+Extension.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface UIViewController(Extension)
-(void)configNaviBackItem;
-(void)configNaviView:(NSString *)searchTitle block:(void(^)())search;
-(void)configNaviRightItemWithImage:(UIImage *)image;
@end
