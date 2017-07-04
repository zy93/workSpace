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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerScrollview;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet UIView *spaceNameView;
@property (weak, nonatomic) IBOutlet UIView *spaceInformationVIew;
@property (weak, nonatomic) IBOutlet UIView *spaceServiceView;
@property (weak, nonatomic) IBOutlet UIView *spaceConnectsView;
@property (weak, nonatomic) IBOutlet UILabel *spaceTel;
@property (weak, nonatomic) IBOutlet UILabel *spaceLocation;

@property(nonatomic,strong)NSArray *imageUrls;
@property(nonatomic,strong)NSArray *scrollViewTitles;
@end
