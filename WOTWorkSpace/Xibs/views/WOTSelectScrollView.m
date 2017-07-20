//
//  WOTSelectScrollView.m
//  scrollTest
//
//  Created by 张雨 on 2017/7/11.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "WOTSelectScrollView.h"
#import "WOTReservationsMeetingCell.h"

#define ButtonWith 40
#define ButtonHeight 50


@interface WOTScrollButton ()

@end


@implementation WOTScrollButton

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        [self setBackgroundColor:UIColor_blue_40];
        [self setImage:[UIImage imageNamed:@"select_white"]  forState:UIControlStateNormal];
        [self.layer setBorderColor:UIColor_blue_40.CGColor];
    }
    else {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderColor:UIColor_gray_d6.CGColor];
    }
}

-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (!enabled) {
        [self setBackgroundColor:UIColor_gray_d6];
        [self setImage:[UIImage imageNamed:@"select_gray"]  forState:UIControlStateNormal];
    }
    else {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setImage:nil  forState:UIControlStateNormal];
    }
        
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
}

@end


@interface WOTSelectScrollView ()
{
    UIView *topLine;
    
//    NSArray *selectList;
    NSArray *invalidList;
    
}

@end


@implementation WOTSelectScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self commonInit];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [[self nextResponder] touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
}

-(void)setOpenTime:(NSString *)openTime
{
    NSArray *tims = [openTime getDECTime];
    openStartTime = [tims.firstObject floatValue];
    openEndTime   = [tims.lastObject floatValue];
    [self commonInit];
}

-(void)setBeginTime:(CGFloat)begin endTime:(CGFloat)end
{
    selectBeginTime = begin;
    selectEndTime = end;
    [self setNeedsLayout];
}

//-(void)setSelectBtnTimeList:(NSArray *)tagList
//{
//    selectList = tagList;
//    [self setNeedsLayout];
//}

-(void)setInvalidBtnTimeList:(NSArray *)tagList
{
    invalidList = tagList;
    [self setNeedsLayout];
}

-(void)commonInit
{
    if (!buttonArr) {
        buttonArr = [[NSMutableArray alloc] init];
    }
    else {
        for (UIButton *button in buttonArr) {
            [button removeFromSuperview];
        }
        [buttonArr removeAllObjects];
    }
    if (!titleArr) {
        titleArr = [[NSMutableArray alloc] init];
    }
    else {
        for (UILabel *lab in titleArr) {
            [lab removeFromSuperview];
        }
        [titleArr removeAllObjects];
    }
    if (!topLine) {
        topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 1)];
    }
    [topLine setBackgroundColor:[UIColor grayColor]];
    [self addSubview:topLine];
    
    for (float i = openStartTime; i<openEndTime; i+=0.5) {
        BOOL isInteger = i-((int)i)==0;
        NSString *tit = nil;
        if (isInteger) {
            tit = [NSString stringWithFormat:@"%d时",(int)i];
        }
        WOTScrollButton *btn = [self createButtonWithTitle:nil];
        btn.time = i;
        UILabel *lab = [self createLabelWithTitle:tit];
        [buttonArr addObject:btn];
        [titleArr addObject:lab];
        [self addSubview:btn];
        [self addSubview:lab];
    }
    
    [self setNeedsLayout];
}


-(WOTScrollButton *)createButtonWithTitle:(NSString *)title
{
    WOTScrollButton *button = [WOTScrollButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = UIColor_gray_d6.CGColor;
    button.layer.borderWidth = 1.f;
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    [button setFrame:CGRectMake(0, 0, ButtonWith, ButtonHeight)];
    
    return button;
}

-(UILabel *)createLabelWithTitle:(NSString *)title
{
    UILabel *lab = [[UILabel alloc] init];
    [lab setText:title];
    [lab setFont:[UIFont systemFontOfSize:13]];
    return lab;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect btnRect = CGRectMake(0, 30, ButtonWith, ButtonHeight);
    for (int i = 0 ; i<buttonArr.count ; i++) {
        WOTScrollButton *btn = buttonArr[i];
        [btn setFrame:btnRect];
        btnRect = CGRectMake(CGRectGetMaxX(btn.frame)-1, 30, ButtonWith, ButtonHeight);
        if (i%2==0) {
            UILabel *lab = [titleArr objectAtIndex:i];
            [lab setFrame:CGRectMake(CGRectGetMinX(btn.frame), 15, 30, 13)];
        }
        for (NSArray *times in invalidList) {
            CGFloat beginTime = [times.firstObject floatValue];
            CGFloat endTime = [times.lastObject floatValue];
            if (btn.time >= beginTime && btn.time < endTime) {
                [btn setEnabled:NO];
            }
        }
        if (btn.time >= selectBeginTime && btn.time < selectEndTime) {
            btn.selected = YES;
        }
    }
    
    
    self.contentSize = CGSizeMake(btnRect.origin.x, 80);
    [topLine setFrame:CGRectMake(0, 0, btnRect.origin.x, 1)];
}

-(void)selectButton:(WOTScrollButton *)sender
{
    if (sender.isEnabled==NO) {
        return;
    }
//    sender.selected = !sender.isSelected;
    if ([_mDelegate respondsToSelector:@selector(selectButton:)]) {
        [_mDelegate selectButton:sender];
    }
}

@end
