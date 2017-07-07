//
//  WOTSpaceCityScrollView.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSpaceCityScrollView.h"
#import "WOTSpaceCityCollectionCell.h"
@interface WOTSpaceCityScrollView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong) WOTSpaceCityCollectionCell *collectionCell;

@end
@implementation WOTSpaceCityScrollView

-(void)awakeFromNib{
    [super awakeFromNib];
    _collectionVIew.delegate = self;
    _collectionVIew.dataSource = self;
   
   
}


#pragma mark --懒加载

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [WOTSingtleton shared].spaceCityArray.count;
    
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld",indexPath.row];
      [_collectionVIew registerNib:[UINib nibWithNibName:@"WOTSpaceCityCollectionCell" bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    _collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    _collectionCell.cityName.text = [[WOTSingtleton shared].spaceCityArray objectAtIndex:indexPath.row];
    
    return _collectionCell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionVIew.frame.size.width/5, self.collectionVIew.frame.size.height-10);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 5);
}


//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WOTSpaceCityCollectionCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.cityName.textColor = RGBA(77.0, 139.0, 231.0, 1.0);
    [cell.cityName setCorenerRadius:10 borderColor:RGBA(77.0, 139.0, 231.0, 1.0)];
    
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WOTSpaceCityCollectionCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.cityName.textColor = [UIColor grayColor];
    [cell.cityName setCorenerRadius:10 borderColor:[UIColor grayColor]];
}
- (IBAction)moreAction:(id)sender {
    
    if (_delegate) {
        [_delegate showMoreCityVC];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
