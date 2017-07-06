//
//  WOTSpaceCityScrollView.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WOTWorkSpaceMoreCityDelegate
@required
    -(void)showMoreCityVC;


@end
@interface WOTSpaceCityScrollView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;
@property (weak, nonatomic) IBOutlet UIImageView *moreBtn;

@property(nonatomic,strong)id<WOTWorkSpaceMoreCityDelegate>delegate;

@end
