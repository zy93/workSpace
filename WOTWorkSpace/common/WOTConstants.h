//
//  WOTConstants.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#ifndef WOTConstants_h
#define WOTConstants_h

//----------------------设备类---------------------------
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)//获取屏幕 宽度
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)//获取屏幕 高度
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)




//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]


#define MainColor [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];

//#define NavigationBGColor [UIColor colorWithRed:53.0/255.0 green:128.0/255.0 blue:81.0/255.0 alpha:1.0];
#define NavigationBGColor [UIColor whiteColor]
#define TabBGColor [UIColor colorWithRed:39.0/255.0 green:90.0/255.0 blue:134.0/255.0 alpha:1.0]
#define LINE_COLOR [UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1.0]
#define ViewBorderColor [UIColor colorWithRed:123.0/255.0 green:163.0/255.0 blue:238.0/255.0 alpha:1.0]

#define White [UIColor whiteColor]
#define Black [UIColor blackColor]
#define HighTextColor UIColorFromRGB(0x333333)
#define MiddleTextColor UIColorFromRGB(0x666666)
#define LowTextColor UIColorFromRGB(0x888888)
#define MainOrangeColor UIColorFromRGB(0xfa8d14)

#define UIColor_gray_d6 UIColorFromRGB(0xd6d6d6)
#define UIColor_gray_89 UIColorFromRGB(0x898989)
#define UIColor_blue_40 UIColorFromRGB(0x4087ee)
#define UIColor_green_12 UIColorFromRGB(0x12c700)

#define HTTPBaseURL @"http://192.168.6.219:8080/workSpace"
#define LOGIN_STATE_USERDEFAULT @"islogin"
#endif /* WOTConstants_h */
