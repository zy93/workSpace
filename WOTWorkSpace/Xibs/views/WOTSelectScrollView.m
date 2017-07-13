//
//  WOTSelectScrollView.m
//  scrollTest
//
//  Created by 张雨 on 2017/7/11.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "WOTSelectScrollView.h"

#define ButtonWith 40
#define ButtonHeight 50

@interface WOTSelectScrollView ()
{
    UIView *topLine;
    
    
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

-(void)setBeginValue:(CGFloat)begin endValue:(CGFloat)end
{
    beginValue = begin;
    endValue = end;
    
    [self commonInit];
}

-(void)commonInit
{
    if (!buttonArr) {
        buttonArr = [[NSMutableArray alloc] init];
    }
    if (!titleArr) {
        titleArr = [[NSMutableArray alloc] init];
    }
    topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 1)];
    [topLine setBackgroundColor:[UIColor grayColor]];
    [self addSubview:topLine];
    NSMutableArray *titles =[NSMutableArray new];
    for (int i = beginValue; i<endValue; i++) {
        [titles addObject:[NSString stringWithFormat:@"%d时",i]];
    }
    
    for (NSString *tit in titles ) {
        UIButton *btn1 = [self createButtonWithTitle:nil];
        UIButton *btn2 = [self createButtonWithTitle:nil];
        UILabel *lab = [self createLabelWithTitle:tit];
        [buttonArr addObject:btn1];
        [buttonArr addObject:btn2];
        [titleArr addObject:lab];
        [self addSubview:btn1];
        [self addSubview:btn2];
        [self addSubview:lab];
    }
    [self setNeedsLayout];
}


-(UIButton *)createButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor grayColor].CGColor;
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
    if (sender.isSelected) {
        [sender setBackgroundColor:[UIColor whiteColor]];
        [sender setImage:nil forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundColor:[UIColor greenColor]];
        [sender setImage:[UIImage imageNamed:@"select_blue"] forState:UIControlStateNormal];
    }
    sender.selected = !sender.isSelected;
}

@end
