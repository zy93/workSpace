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
    self.enabled = enabled;
    if (enabled) {
        [self setBackgroundColor:UIColor_gray_d6];
        [self setImage:[UIImage imageNamed:@"select_gray"]  forState:UIControlStateNormal];
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
    
    NSArray *selectList;
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


-(void)setBeginValue:(CGFloat)begin endValue:(CGFloat)end
{
    beginValue = begin;
    endValue = end;
    
    [self commonInit];
}

-(void)setSelectBtnTagList:(NSArray *)tagList
{
    selectList = tagList;
}

-(void)setInvalidBtnTagList:(NSArray *)tagList
{
    invalidList = tagList;
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
    NSMutableArray *titles =[NSMutableArray new];
    for (int i = beginValue; i<endValue; i++) {
        [titles addObject:[NSString stringWithFormat:@"%d时",i]];
    }
    
    for (int i = 0;i<titles.count;i++) {
        NSString *tit =titles[i];
        UIButton *btn1 = [self createButtonWithTitle:nil];
        UIButton *btn2 = [self createButtonWithTitle:nil];
        btn1.tag = i;
        btn2.tag = i+titles.count+1;
        for (NSNumber *t in invalidList) {
            if (btn1.tag == [t integerValue]) {
                btn1.enabled = NO;
            }
            if (btn2.tag == [t integerValue]) {
                btn2.enabled = NO;
            }
        }
        for (NSNumber *t in selectList) {
            if (btn1.tag == [t integerValue]) {
                btn1.selected = YES;
            }
            
            if (btn2.tag == [t integerValue]) {
                btn2.selected = YES;
            }
        }
        UILabel *lab = [self createLabelWithTitle:tit];
        [buttonArr addObject:btn1];
        [buttonArr addObject:btn2];
        [titleArr addObject:lab];
        [self addSubview:btn1];
        [self addSubview:btn2];
        [self addSubview:lab];
    }
    
    for (UIButton *btn in buttonArr) {
        if (btn.isSelected) {
        }
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
        UIButton *btn = buttonArr[i];
        [btn setFrame:btnRect];
        btnRect = CGRectMake(CGRectGetMaxX(btn.frame)-1, 30, ButtonWith, ButtonHeight);
        if (i%2==0) {
            UILabel *lab = [titleArr objectAtIndex:i/2];
            [lab setFrame:CGRectMake(CGRectGetMinX(btn.frame), 15, 30, 13)];
        }
    }
    
    
    self.contentSize = CGSizeMake(btnRect.origin.x, 80);
    [topLine setFrame:CGRectMake(0, 0, btnRect.origin.x, 1)];
}

-(void)selectButton:(UIButton *)sender
{
    if (sender.isEnabled==NO) {
        return;
    }
//    sender.selected = !sender.isSelected;
    if ([_mDelegate respondsToSelector:@selector(selectButton:)]) {
        [_mDelegate selectButton:sender.tag];
    }
}

@end
