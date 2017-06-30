//
//  WORTMyEnterpriseVC.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WORTMyEnterpriseVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@property(nonatomic,strong)NSMutableArray *dataSource;
@end
