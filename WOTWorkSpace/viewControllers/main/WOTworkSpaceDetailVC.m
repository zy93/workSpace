//
//  WORworkSpaceDetailVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTworkSpaceDetailVC.h"
#import "WOTSpaceDetailCell.h"
#import "WOTSpaceDetailTeamCollectionCell.h"
@interface WOTworkSpaceDetailVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *enterBtn;
@property (weak, nonatomic) IBOutlet UIButton *visitBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionVIew;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end

@implementation WOTworkSpaceDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self congigNav];
    [self configScrollView];
    [self getautoScrollViewDataSource];
    [self loadAutoScrollView];
      [_collectionVIew registerNib:[UINib nibWithNibName:@"WOTSpaceDetailTeamCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"WOTSpaceDetailTeamCollectionCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)viewWillLayoutSubviews{
    self.scrollVIew.contentSize = CGSizeMake(self.view.frame.size.width,self.headerScrollview.frame.size.height+self.spaceNameView.frame.size.height+self.mapView.frame.size.height+self.spaceInformationVIew.frame.size.height+self.spaceServiceView.frame.size.height+self.spaceConnectsView.frame.size.height);
}
-(void)congigNav{
    [self configNaviBackItem];
}

-(void)configScrollView{
    self.scrollVIew.backgroundColor = MainColor;
    self.scrollVIew.delegate = self;
    self.scrollVIew.showsHorizontalScrollIndicator = NO;
    self.scrollVIew.showsVerticalScrollIndicator = NO;
   
    
    
    
}

-(void)loadAutoScrollView{
    
    
    self.headerScrollview.imageURLStringsGroup = _imageUrls;
    self.headerScrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.headerScrollview.delegate = self;
    self.headerScrollview.titlesGroup = _scrollViewTitles;
    self.headerScrollview.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    self.headerScrollview.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
}

- (IBAction)goToDestination:(id)sender {
    
    //TODO:完成地图导航，实现绘制轨迹路线
}


- (IBAction)makeCallToSpace:(id)sender {
    //MARK:打众创空间电话
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:_spaceTel.text]];
}

- (IBAction)goToAppointmentVC:(id)sender {
    
    //TODO:预约参观
}
- (IBAction)goToEnterVC:(id)sender {
   //TODO:预约入驻


}

//MARK:SDCycleScrollView   Delegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%@+%ld",cycleScrollView.titlesGroup[index],index);
}

//调用接口获取autoscrollview数据源
-(void)getautoScrollViewDataSource {
    _imageUrls = @[
                   @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                   @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                   @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                   ];
    
    // 图片配文字
    _scrollViewTitles = @[@"物联港科技",
                          @"物联港科技",
                          @"物联港科技",
                          @"物联港科技"
                          ];

    
}

//Mark:tableView dataSource   delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return 3;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return  120;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTSpaceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTSpaceDetailCellID" forIndexPath:indexPath];
    return cell;
}


#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WOTSpaceDetailTeamCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WOTSpaceDetailTeamCollectionCellID" forIndexPath:indexPath];
   
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.collectionVIew.frame.size.width/3.5, self.collectionVIew.frame.size.height);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
