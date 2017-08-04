//
//  WOTShortcutMenuView.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTShortcutMenuView.h"


@interface WOTShortcutMenuView ()
{
    NSArray *imageNameList;
    NSArray *titleList;
    
    NSMutableArray *buttonList;
    CGFloat buttonDefaultY;
    CGFloat lineDefaultHeight;
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    
    
    NSArray *sbNameList;
    NSArray *vcNameList;
    
}

@end


@implementation WOTShortcutMenuView



-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
    self.backgroundColor = UIColorFromRGB(0x8fc5f3);
    
    sbNameList = @[@"Service",@"Service",@"Service",@"Service",@"Service",
                   @"spaceMain",@"",@"spaceMain",];
    
    vcNameList = @[@"WOTReservationsMeetingVC",
                   @"WOTVisitorsAppointmentVC",
                   @"WOTBookStationVCID",
                   @"WOTReservationsMeetingVC",
                   @"WOTOpenLockScanVCID",
                   @"WOTEnterpriseLIstVCID",
                   @"",
                   @"WOTActivitiesLIstVCID"];
    
    
    titleList = @[@"预定场地", @"访客",@"订工位",@"订会议室", @"一键开门", @"友邻", @"资讯", @"活动"];
    imageNameList = @[@"shortcut_site_icon",
                      @"shortcut_visitors_icon",
                      @"shortcut_station_icon",
                      @"shortcut_meeting_icon",
                      @"shortcut_open_icon",
                      @"shortcut_finds_icon",
                      @"shortcut_news_icon",
                      @"shortcut_activity_icon"];
    buttonDefaultY = 15;
    lineDefaultHeight = 10;
    buttonHeight = (180-(buttonDefaultY*2))/2;
    buttonWidth = SCREEN_WIDTH/4;
    
    for (int i = 0; i<titleList.count; i++) {
        UIButton *btn = [self createButtonWithTitle:titleList[i] imgName:imageNameList[i] i:i];
        [buttonList addObject:btn];
    }
}

-(UIButton *)createButtonWithTitle:(NSString *)title imgName:(NSString *)imgName i:(int)i
{
    
    NSInteger index = i%4;
    NSInteger line = i/4;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(index*buttonWidth, line*buttonHeight+buttonDefaultY+(line*lineDefaultHeight), buttonWidth, buttonHeight)];
    button.tag = i;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *img = [UIImage imageNamed:imgName];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    [imgV setImage:img];
    imgV.center = CGPointMake(buttonWidth*0.5, buttonHeight*0.5-15);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgV.frame)+10, buttonWidth, 20)];
    lab.text = title;
    lab.textColor = UIColorFromRGB(0xffffff);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:15.f];
    
    
    [button addSubview:imgV];
    [button addSubview:lab];
    
    [self addSubview:button];
    return button;
}


-(void)clickButton:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(pushToVCWithStoryBoardName:vcName:)]) {
        
        if (sender.tag == 0) {
            [WOTSingtleton shared].orderType = ORDER_TYPE_SITE;
        }
        else if (sender.tag == 2) {
            [WOTSingtleton shared].orderType = ORDER_TYPE_BOOKSTATION;
        }
        else if (sender.tag == 3) {
            [WOTSingtleton shared].orderType = ORDER_TYPE_MEETING;
        }
        
        [_delegate pushToVCWithStoryBoardName:sbNameList[sender.tag] vcName:vcNameList[sender.tag]];
    }
}


@end
