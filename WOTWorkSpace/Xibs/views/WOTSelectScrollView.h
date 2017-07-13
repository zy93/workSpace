//
//  WOTSelectScrollView.h
//  scrollTest
//
//  Created by 张雨 on 2017/7/11.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol WOTSelectScrollViewDelegate <NSObject>

-(void)selectButton:(NSInteger)btnTage;

@end


@interface WOTSelectScrollView : UIScrollView

{
    NSMutableArray *buttonArr;
    NSMutableArray *titleArr;
    
    CGFloat beginValue;
    CGFloat endValue;
    
}

-(void)setBeginValue:(CGFloat)begin endValue:(CGFloat)end;

@end
