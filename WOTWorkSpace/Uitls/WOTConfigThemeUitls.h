//
//  WOTConfigThemeUitls.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WOTConfigThemeUitls : NSObject
+(instancetype)shared;
-(void)setLabelTexts:(NSArray *)labels withTexts:(NSArray *)texts;
-(void)setLabelColorss:(NSArray *)labels withColor:(UIColor *)color;
-(void)loadtagsBtn:(NSArray *)tagsArray superView:(UIView *)tagsView;
-(void)touchViewHiddenKeyboard:(UIView *)view;
@property(nonatomic,copy)void (^hiddenKeyboardBlcok)();
@end
