//
//  WOTMainScrollViewCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/30.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMainScrollViewCell.h"

@implementation WOTMainScrollViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 图片配文字
    NSArray *titles = @[@"物联港科技",
                        @"物联港科技",
                        @"物联港科技",
                        @"物联港科技"
                        ];
    
    
    self.scrollView.imageURLStringsGroup = imagesURLStrings;
    self.scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.scrollView.delegate = self;
    self.scrollView.titlesGroup = titles;
    self.scrollView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    self.scrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
