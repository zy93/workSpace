//
//  WOTImageCollectionViewCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *cityName;
@property (weak, nonatomic) IBOutlet UILabel *workSpaceNum;
@property (weak, nonatomic) IBOutlet UIImageView *cityImage;

@end
