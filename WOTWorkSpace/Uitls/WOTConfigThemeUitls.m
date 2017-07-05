//
//  WOTConfigThemeUitls.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTConfigThemeUitls.h"
#import <UIKit/UIKit.h>
@implementation WOTConfigThemeUitls
+(instancetype)shared{
    static WOTConfigThemeUitls *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[self alloc]init];
    });
    return  instance;
}
-(void)setLabelTexts:(NSArray *)labels withTexts:(NSArray *)texts{
    
    for (NSInteger i=0; i<labels.count; i++) {
        UILabel *label = (UILabel *)[labels objectAtIndex:i];
        label.text = texts[i];
    }
}


-(void)setLabelColorss:(NSArray *)labels withColor:(UIColor *)color{
    for (UILabel *label in labels) {
        label.textColor = color;
    }
}

@end
