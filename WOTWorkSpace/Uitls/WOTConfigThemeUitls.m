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

-(void)loadtagsBtn:(NSArray *)tagsArray superView:(UIView*)tagsView{
    CGFloat leading = 10;
    CGFloat top  = 0;
    
    for (NSString *title in tagsArray) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:15];
        label.frame = CGRectMake(leading, top,[title widthWithFont:[UIFont systemFontOfSize:15]]+15, 30);
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = ViewBorderColor;
        [label setCorenerRadius:10 borderColor:[UIColor colorWithRed:123.0/255.0 green:163.0/255.0 blue:238.0/255.0 alpha:1.0]];
    
        [tagsView addSubview:label];

        leading += label.frame.size.width+10;
        
        if (leading+[title widthWithFont:[UIFont systemFontOfSize:15]]+20>=tagsView.frame.size.width) {
            top += label.frame.size.height+10;
            leading = 10;
        }
      
        
    }
 
}


//添加屏幕触摸方法，完成收键盘
-(void)touchViewHiddenKeyboard:(UIView *)view{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:) ];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    if (self.hiddenKeyboardBlcok) {
        self.hiddenKeyboardBlcok();
    }
}
//懒加载登录模块navigationController
-(WOTLoginNaviController *)nav{
    if (_nav == nil) {
        WOTLoginVC *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTLoginVC"];
       _nav = [[WOTLoginNaviController alloc]initWithRootViewController:vc];
    }
    return _nav;
}
//跳转到登录页面通用方法
-(void)showLoginVC:(UIViewController *)persentVC{
    
    
    [persentVC presentViewController:self.nav animated:YES completion:^{
        
    }];
}

//统一显示alertView
-(void)showRemindingAlert:(UIViewController *)vc message:(NSString *)message okBlock:(void(^)())okBlock cancel:(void(^)())cancelBlock{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        okBlock();
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     cancelBlock();
    }]];
    [vc presentViewController:alert animated:YES completion:nil];
    
}
@end
