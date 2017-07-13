//
//  WOTworkSpaceSearchCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTworkSpaceSearchCell.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"
@implementation WOTworkSpaceSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_searchBar changeLeftPlaceholder:@"搜索城市或空间"];
    [_searchBar setBarStyle:UIBarStyleBlackTranslucent];
    [_searchBar setBackgroundColor:CLEARCOLOR];
    UIView *searchTextField = nil;
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    
    if (is7Version) {
        
        searchTextField = [[[_searchBar.subviews firstObject] subviews] lastObject];
        
    }else{// iOS6以下版本searchBar内部子视图的结构不一样
        for(UIView *subview in _searchBar.subviews)
        {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                searchTextField = subview;
                
            }
        }
    }
    searchTextField.backgroundColor = MainColor;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
