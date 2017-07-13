//
//  WOTMainVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMainVC.h"

#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"
#import "ZYQSphereView.h"
#import "WOTworkSpaceLIstVC.h"
#import "WOTworkSpaceDetailVC.h"
#import "WOTEnterpriseLIstVC.h"
#import "WOTActivitiesLIstVC.h"
#import "WOTInformationListVC.h"
#import "WOTBookStationVC.h"
#import "WOTEnumUtils.h"
#import "WOTTEnterpriseListCell.h"
@interface WOTMainVC ()<UIScrollViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZYQSphereView *sphereView;
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;

@property(nonatomic,strong)WOTworkSpaceLIstVC *spacevc;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation WOTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load3DBallView];
    [self loadAutoScrollView];
    [self configScrollView];
    [self loadSpaceView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
  [self.tableView registerNib:[UINib nibWithNibName:@"WOTTEnterpriseListCell" bundle:nil] forCellReuseIdentifier:@"WOTTEnterpriseListCellID"];
    _tableView.scrollEnabled = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
}

//必须在页面出现以后，重新设置scrollview 的contengsize
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.scrollVIew.contentSize = CGSizeMake(self.view.frame.size.width,self.autoScrollView.frame.size.height+self.ballView.frame.size.height+self.self.workspaceView.frame.size.height+self.activityView.frame.size.height+self.informationView.frame.size.height+self.enterpriseView.frame.size.height+70);
    
}

-(void)configScrollView{
    self.scrollVIew.delegate = self;
    self.scrollVIew.showsHorizontalScrollIndicator = NO;
    self.scrollVIew.showsVerticalScrollIndicator = NO;
    self.scrollVIew.backgroundColor = MainColor;
    

}


#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}


-(void)load3DBallView{
   
    if (IS_IPHONE_5) {
         _sphereView = [[ZYQSphereView alloc] initWithFrame:CGRectMake(-1,11, self.ballView.frame.size.width-30, self.ballView.frame.size.height-30)];
    } else {
         _sphereView = [[ZYQSphereView alloc] initWithFrame:CGRectMake(-1,11, self.ballView.frame.size.width, self.ballView.frame.size.height)];
    }
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (int i = 0; i < [WOTSingtleton shared].ballTitle.count; i++) {
        UIView * subview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80,80)];
        subview.backgroundColor = COLOR(96.0, 119.0, 195.0, 1.0);
      
        [subview setCorenerRadius:subview.frame.size.width/2 borderColor:CLEARCOLOR];
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(23, 10, 35,35)];
        icon.image = [UIImage imageNamed:[WOTSingtleton shared].ballImage[i]];
        [subview addSubview:icon];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5,50,70,25)];
        title.text = [WOTSingtleton shared].ballTitle[i];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:14.0];
        title.textColor = COLOR(129.0, 225.0, 250.0, 1.0);
        [subview addSubview:title];
        UIButton *subbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80,80)];
        
        [subbtn setBackgroundColor:CLEARCOLOR];
        subbtn.alpha = 0.5;
        subbtn.tag = i;
        [subbtn setCorenerRadius:subbtn.frame.size.width/2 borderColor:CLEARCOLOR];
        [subbtn addTarget:self action:@selector(subVClick:) forControlEvents:UIControlEventTouchUpInside];
        [subview addSubview:subbtn];
        [views addObject:subview];
        
    }
    
    [_sphereView setItems:views];
    
    _sphereView.isPanTimerStart=YES;
  
    [self.ballView addSubview:_sphereView];
    [_sphereView timerStart];
    
}


-(void)loadAutoScrollView{
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
    
    
    self.autoScrollView.imageURLStringsGroup = imagesURLStrings;
    self.autoScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.autoScrollView.delegate = self;
    self.autoScrollView.titlesGroup = titles;
    self.autoScrollView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    self.autoScrollView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
}




//3D球点击事件
-(void)subVClick:(UIButton*)sender{
    
    NSLog(@"%@",[WOTSingtleton shared].ballTitle[sender.tag]);
    
    BOOL isStart=[_sphereView isTimerStart];
    
    [_sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        sender.transform=CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            sender.transform=CGAffineTransformMakeScale(1, 1);
            if (isStart) {
                [_sphereView timerStart];
            }
        }];
    }];
    WOT3DBallVCType balltype = [[[WOTEnumUtils alloc]init] Wot3DballVCtypeenumToString:[WOTSingtleton shared].ballTitle[sender.tag]];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
    WOTEnterpriseLIstVC *enterprisevc = [storyboard instantiateViewControllerWithIdentifier:@"WOTEnterpriseLIstVCID"];
    WOTBookStationVC *stationvc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTBookStationVCID"];
    switch (balltype) {
        case WOTEnterprise:
           
            [self.navigationController pushViewController:enterprisevc animated:YES];
            break;
        case WOTBookStation:
            [self.navigationController pushViewController:stationvc animated:YES];
            break;
        case WOTOthers:
            
        default:
            break;
    }
}
-(void)loadSpaceView{
    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",index]];
        [self.imageArray addObject:image];
    }
    
    [self setupUI];
}


//MARK: main scrollview delegate
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}


//page view UI
- (void)setupUI {
    
    
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 20)];
    _pageFlowView.delegate = self;
    _pageFlowView.dataSource = self;
    _pageFlowView.minimumPageAlpha = 0.1;
    _pageFlowView.isCarousel = NO;
    _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    _pageFlowView.isOpenAutoScroll = YES;
    
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _pageFlowView.frame.size.height - 32, SCREEN_WIDTH, 8)];
    _pageFlowView.pageControl = pageControl;
    [_pageFlowView addSubview:pageControl];
    
   
    [self.spaceView addSubview:_pageFlowView];
    
    [_pageFlowView reloadData];
    

    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(SCREEN_WIDTH - 60, (SCREEN_WIDTH - 60) * 9 / 16);
}
- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
    WOTworkSpaceDetailVC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = @"http://219.143.170.100:8012/makerSpace/activity.html";
    [self.navigationController pushViewController:detailvc animated:YES];
    

}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
    
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 9 / 16)];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

- (IBAction)showWorkSpaceVC:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
    _spacevc = [storyboard instantiateViewControllerWithIdentifier:@"WOTworkSpaceLIstVCID"];
    [self.navigationController pushViewController:_spacevc animated:YES];
    
    
    
}


- (IBAction)showActivitiesVC:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
    WOTActivitiesLIstVC *acvc = [storyboard instantiateViewControllerWithIdentifier:@"WOTActivitiesLIstVCID"];
    [self.navigationController pushViewController:acvc animated:YES];
    
    
}
- (IBAction)showInformationLIstVC:(id)sender {
    
    WOTInformationListVC *infovc = [[WOTInformationListVC alloc]init];
    [self.navigationController pushViewController:infovc animated:YES];
    
}
- (IBAction)showEnterpriseListVC:(id)sender {

    WOTEnterpriseLIstVC *enterprisevc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTEnterpriseLIstVCID"];
    
    [self.navigationController pushViewController:enterprisevc animated:YES];
}

//MARK:SDCycleScrollView   Delegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%@+%ld",cycleScrollView.titlesGroup[index],index);
}

//MARK:tableView datasource delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WOTTEnterpriseListCell *enterprisecell = [tableView dequeueReusableCellWithIdentifier:@"WOTTEnterpriseListCellID" forIndexPath:indexPath];
    enterprisecell.enterpriseName.text = @"北京物联港科技发展有限公司";
    enterprisecell.enterpriseInfo.text = @"#软件#  集成软件我们是专家，欢迎大家来咨询！！！";
    enterprisecell.enterpriseLogo.image = [UIImage imageNamed:@"enterprise_logo"];
    
    return enterprisecell;
    
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
