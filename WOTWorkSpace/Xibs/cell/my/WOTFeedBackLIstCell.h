//
//  WOTFeedBackLIstCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTFeedBackLIstCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *yearmonth;

@property (weak, nonatomic) IBOutlet UILabel *day;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *content;

@property (weak, nonatomic) IBOutlet UIView *tagsView;

@property(strong,nonatomic)NSArray *tagLabelArray;
-(void)loadtagsBtn;
@end
