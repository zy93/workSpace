//
//  WOTInformationListVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTTableViewBaseVC.h"
#import "WOTNewInformationModel.h"
@interface WOTInformationListVC : WOTTableViewBaseVC
@property(nonatomic,strong)NSArray<WOTNewInformationModel *> *dataSource;
@end
