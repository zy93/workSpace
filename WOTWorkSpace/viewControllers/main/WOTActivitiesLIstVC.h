//
//  WOTActivitiesLIstVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTMenuViewParentVC.h"
#import "WOTActivityModel.h"
@interface WOTActivitiesLIstVC : WOTMenuViewParentVC

@property (strong,nonatomic)NSArray<WOTActivityModel *> *dataSource;
-(void)getActivityDataFromWeb:(void(^)())complete;
@end
