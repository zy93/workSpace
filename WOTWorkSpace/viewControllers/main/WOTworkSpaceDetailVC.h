//
//  WORworkSpaceDetailVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
@interface WOTworkSpaceDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *web;

//直接打开H5
@property (nonatomic, strong) NSString *url;

@end
