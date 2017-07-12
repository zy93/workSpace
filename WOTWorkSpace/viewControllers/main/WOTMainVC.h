//
//  WOTMainVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "ZYQSphereView.h"
@interface WOTMainVC : UIViewController
@property (weak, nonatomic) IBOutlet SDCycleScrollView *autoScrollView;

@property (weak, nonatomic) IBOutlet UIView *ballView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (weak, nonatomic) IBOutlet UIView *spaceView;
@property (weak, nonatomic) IBOutlet UIView *activityView;

@property (weak, nonatomic) IBOutlet UIView *informationView;
@property (weak, nonatomic) IBOutlet UIView *workspaceView;
@property (weak, nonatomic) IBOutlet UIView *enterpriseView;


@end
