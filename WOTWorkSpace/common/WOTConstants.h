//
//  WOTConstants.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#ifndef WOTConstants_h
#define WOTConstants_h





#define MainColor [UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];

//#define NavigationBGColor [UIColor colorWithRed:53.0/255.0 green:128.0/255.0 blue:81.0/255.0 alpha:1.0];
#define NavigationBGColor [UIColor whiteColor];
#define TabBGColor [UIColor colorWithRed:39.0/255.0 green:90.0/255.0 blue:134.0/255.0 alpha:1.0];
#define LINE_COLOR [UIColor grayColor];
#define LineBGColor [UIColor lightGrayColor];

#define White [UIColor whiteColor];
#define Black [UIColor blackColor];
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

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




#endif /* WOTConstants_h */
