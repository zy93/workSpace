//
//  WOTSelectScrollView.h
//  scrollTest
//
//  Created by 张雨 on 2017/7/11.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WOTScrollButton : UIButton

@end


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

@property (nonatomic, weak) id <WOTSelectScrollViewDelegate> mDelegate;

-(void)setBeginValue:(CGFloat)begin endValue:(CGFloat)end;
-(void)setSelectBtnTagList:(NSArray *)tagList;
-(void)setInvalidBtnTagList:(NSArray *)tagList;
@end
