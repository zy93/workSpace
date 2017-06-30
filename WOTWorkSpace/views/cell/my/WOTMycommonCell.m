//
//  WOTMycommonCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMycommonCell.h"
#import "header.h"
#import "WOTConstants.h"
@implementation WOTMycommonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubViews];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}


-(void)loadSubViews{
 
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nextImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backAcssory"]];
    _lineview = [[UIView alloc]init];
    _lineview.backgroundColor = LineBGColor;
    [self.contentView addSubview:_lineview];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_nextImageView];
    
}
-(void)layoutSubviews{
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.left.mas_equalTo(self.contentView.mas_left).offset(10);
        maker.centerY.mas_equalTo(self.contentView);
    }];
    
    
    [_nextImageView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.trailingMargin.mas_equalTo(self.contentView).offset(-8);
        maker.centerY.mas_equalTo(self.contentView);
        maker.height.mas_equalTo(15);
        maker.width.mas_equalTo(20);
    }];
    
    [_lineview mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.height.mas_equalTo(1);
        maker.bottom.mas_equalTo(self.contentView);
        maker.left.mas_equalTo(self.contentView);
        maker.right.mas_equalTo(self.contentView);
    }];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
