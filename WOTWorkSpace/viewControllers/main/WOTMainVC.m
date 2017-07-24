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
#import "WOTEnterpriseModel.h"
#import "WOTSliderModel.h"
#import "WOTSpaceModel.h"
@interface WOTMainVC ()<UIScrollViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)ZYQSphereView *sphereView;
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;

@property(nonatomic,strong)WOTworkSpaceLIstVC *spacevc;

@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UIImageView *infoImage;
@property (weak, nonatomic) IBOutlet UILabel *InfoMessage;
@property (weak, nonatomic) IBOutlet UILabel *InfoTime;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray<WOTEnterpriseModel *> *enterpriseListdata;
@property (nonatomic,strong) NSMutableArray *imageUrlStrings;
@property (nonatomic,strong) NSMutableArray *imageTitles;
@property (nonatomic,strong) NSMutableArray *sliderUrlStrings;
@property (strong,nonatomic)NSMutableArray<WOTSpaceModel *> *spacedataSource;
@property (strong,nonatomic)NSArray<WOTActivityModel *> *activitydataSource;
@property(nonatomic,strong)NSArray<WOTNewInformationModel *> *infodataSource;
@property(nonatomic,strong)NSString *activityImageUrl;
@end

@implementation WOTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load3DBallView];
    [self getSliderDataSource:^{
        [self loadAutoScrollView];
    }];
    
    [self configScrollView];
    [self loadSpaceView];
    
   
     
    _tableView.dataSource = self;
    _tableView.delegate = self;
  [self.tableView registerNib:[UINib nibWithNibName:@"WOTTEnterpriseListCell" bundle:nil] forCellReuseIdentifier:@"WOTTEnterpriseListCellID"];
    _tableView.scrollEnabled = NO;
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    
    
    [MBProgressHUDUtil showLoadingWithMessage:@"数据加载中..." toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        [self getEnterpriseListDataFromWeb:^{
            [hud setHidden:YES];
        }];
        
    }];
    
    
    [MBProgressHUDUtil showLoadingWithMessage:@"数据加载中..." toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        [self getActivityDataFromWeb:^{
            [hud setHidden: YES];
        }];
        
    }];
    
    [MBProgressHUDUtil showLoadingWithMessage:@"数据加载中..." toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        [self getInfoDataFromWeb:^{
            [hud setHidden:YES];
        }];
        
    }];
    
    // Do any additional setup after loading the view.
    self.tabBarController.tabBar.translucent = NO;
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
-(NSArray<WOTEnterpriseModel *>*)enterpriseListdata{
    if (_enterpriseListdata == nil) {
        _enterpriseListdata = [[NSArray alloc]init];
    }
    return _enterpriseListdata;
}

- (NSMutableArray *)imageUrlStrings {
    if (_imageUrlStrings == nil) {
        _imageUrlStrings = [NSMutableArray array];
    }
    return _imageUrlStrings;
}

- (NSMutableArray *)imageTitles {
    if (_imageTitles == nil) {
        _imageTitles = [NSMutableArray array];
    }
    return _imageTitles;
}

- (NSMutableArray *)sliderUrlStrings {
    if (_sliderUrlStrings == nil) {
        _sliderUrlStrings = [NSMutableArray array];
    }
    return _sliderUrlStrings;
}

-(NSString *)activityImageUrl{
    if (_activityImageUrl == nil) {
        _activityImageUrl = @"";
    }
    return  _activityImageUrl;
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
//        subview.backgroundColor = UIColorFromRGB(0x86d3ff);
        subview.backgroundColor = CLEARCOLOR;
      
        [subview setCorenerRadius:subview.frame.size.width/2 borderColor:CLEARCOLOR];
        UIImageView *bgimage = [[UIImageView alloc]initWithFrame:subview.bounds];
        [bgimage setImage:[UIImage imageNamed:@"ball_iconbgimage"]];
        [subview addSubview:bgimage];
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
    

    self.autoScrollView.imageURLStringsGroup = _imageUrlStrings;
    self.autoScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    self.autoScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;  //设置图片填充格式
    self.autoScrollView.delegate = self;
    self.autoScrollView.titlesGroup = _imageTitles;
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
            
            break;
        case WOTReservationsMeeting:
            [self pushToViewControllerWithStoryBoardName:@"Service" viewControllerName:@"WOTReservationsMeetingVC"];
            break;
        default:
            break;
    }
}


-(void)pushToViewControllerWithStoryBoardName:(NSString *)sbName viewControllerName:(NSString *)vcName
{
    UIViewController *stationvc = [[UIStoryboard storyboardWithName:sbName bundle:nil] instantiateViewControllerWithIdentifier:vcName];
    [self.navigationController pushViewController:stationvc animated:YES];
}


-(void)loadSpaceView{
    
    [MBProgressHUDUtil showLoadingWithMessage:@"数据加载中..." toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        
        [self getDataSourceFromWebFWithCity:nil complete:^{
            [hud setHidden: YES];
        } loadVIews:^{
            [self setupUI];
        }];
    }];
 
}


//MARK: main scrollview delegate
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}


//page view UI
- (void)setupUI {
    
    
    _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, self.spaceView.frame.size.height-20)];
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
    //从网络加载图片用
      [bannerView.mainImageView sd_setImageWithURL:self.imageArray[index] placeholderImage:[UIImage imageNamed:@"spacedefault"]];
    //从本地加载图片用
//    bannerView.mainImageView.image = self.imageArray[index];
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}
//MARK:点击显示新页面
- (IBAction)showWorkSpaceVC:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
    _spacevc = [storyboard instantiateViewControllerWithIdentifier:@"WOTworkSpaceLIstVCID"];
    [_spacevc setDataSource:_spacedataSource];
    [self.navigationController pushViewController:_spacevc animated:YES];
    
    
    
}


- (IBAction)showActivitiesVC:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"spaceMain" bundle:nil];
  WOTActivitiesLIstVC  *acvc = [storyboard instantiateViewControllerWithIdentifier:@"WOTActivitiesLIstVCID"];
    [acvc setDataSource:_activitydataSource];
    [self.navigationController pushViewController:acvc animated:YES];
    
    
}
- (IBAction)showInformationLIstVC:(id)sender {
    
    WOTInformationListVC *infovc = [[WOTInformationListVC alloc]init];
    infovc.dataSource = _infodataSource;
    [self.navigationController pushViewController:infovc animated:YES];
    
}
- (IBAction)showEnterpriseListVC:(id)sender {

    WOTEnterpriseLIstVC *enterprisevc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTEnterpriseLIstVCID"];
    [enterprisevc setDataSource:_enterpriseListdata];
    [self.navigationController pushViewController:enterprisevc animated:YES];
}
//activity section imageClick
- (IBAction)showActivityDetail:(id)sender {
    
    WOTworkSpaceDetailVC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = @"http://219.143.170.100:8012/makerSpace/activity.html";
    [self.navigationController pushViewController:detailvc animated:YES];
    
    
}
//new information section imageClick 
- (IBAction)showInfoDetail:(id)sender {
    WOTworkSpaceDetailVC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = @"http://219.143.170.100:8012/makerSpace/activity.html";
    [self.navigationController pushViewController:detailvc animated:YES];
    
    
}

//MARK:SDCycleScrollView   Delegate  点击轮播图显示详情
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    
    WOTworkSpaceDetailVC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = _sliderUrlStrings[index];
    [self.navigationController pushViewController:detailvc animated:YES];
    
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
    enterprisecell.enterpriseName.text = _enterpriseListdata[indexPath.row].companyName;
    enterprisecell.enterpriseInfo.text = _enterpriseListdata[indexPath.row].companyProfile;
    [enterprisecell.enterpriseLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,_enterpriseListdata[indexPath.row].companyPicture]] placeholderImage:[UIImage imageNamed:@"enterprise_logo"]];
    enterprisecell.lineView.hidden = indexPath.row == _enterpriseListdata.count-1 ? YES:NO;
    return enterprisecell;
    
}
-(void)getEnterpriseListDataFromWeb:(void(^)())complete{
    
    [WOTHTTPNetwork getEnterprisesWithSpaceId:[[NSNumber alloc]initWithInt:55] response:^(id bean, NSError *error) {
        complete();
        if (bean) {
            WOTEnterpriseModel_msg *dd = (WOTEnterpriseModel_msg *)bean;
            _enterpriseListdata = dd.msg;
            [self.tableView reloadData];
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
    }];
}
-(void)getSliderDataSource:(void(^)())complete{
    [WOTHTTPNetwork getHomeSliderSouceInfo:^(id bean, NSError *error) {
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
            _imageUrlStrings = [[NSMutableArray alloc]initWithArray:@[
                                                                     @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                                                     @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                                                     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                                                     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
                                                                     @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                                                     ]];
            
            // 图片配文字
            _imageTitles = [[NSMutableArray alloc]initWithArray:            @[@"物联港科技",
                                                                              @"物联港科技",
                                                                              @"物联港科技",
                                                                              @"物联港科技",
                                                                              @"物联港科技"
                                                                              ]];
            
            
            
        }
        if (bean) {
         
            WOTEnterpriseModel_msg *dd = (WOTEnterpriseModel_msg *)bean;
            _imageTitles = [[NSMutableArray alloc]init];
            _imageUrlStrings = [[NSMutableArray alloc]init];
            _sliderUrlStrings = [[NSMutableArray alloc]init];
            for (WOTSliderModel *slider in dd.msg) {
                [_imageUrlStrings addObject:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,slider.image]];
                [_imageTitles addObject:slider.headline];
                [_sliderUrlStrings addObject:slider.url];
            }
            complete();
            
        }
    }];
}

//从网络获取空间数据
-(void)getDataSourceFromWebFWithCity:( NSString * __nullable )city complete:(void(^)())complete loadVIews:(void(^)())loadViews{
    
    [WOTHTTPNetwork getAllSpaceWithCity:city block:^(id bean, NSError *error) {
        complete();
        if (bean != nil) {
            
            
            WOTSpaceModel_msg *dd = (WOTSpaceModel_msg *)bean;
            _spacedataSource = dd.msg;
            
            if (_spacedataSource.count>5) {
                for (int index = 0; index < 5; index++) {
                    if ([_spacedataSource[index].spacePicture separatedWithString:@","].count != 0) {
                        [self.imageArray addObject:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,[_spacedataSource[index].spacePicture separatedWithString:@","][0]]];
                    }
                }
            } else {
                for (int index = 0; index < _spacedataSource.count; index++) {
                    if ([_spacedataSource[index].spacePicture separatedWithString:@","].count != 0) {
                        [self.imageArray addObject:[NSString stringWithFormat:@"%@%@",HTTPBaseURL,[_spacedataSource[index].spacePicture separatedWithString:@","][0]]];
                    }
                }
            }
            loadViews();
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
        
    }];
    
}


-(void)getActivityDataFromWeb:(void(^)())complete{
    
    [WOTHTTPNetwork getActivitiesWithSpaceId:nil spaceState:[[NSNumber alloc]initWithInt:1]  response:^(id bean, NSError *error) {
        
        complete();
        if (bean) {
            WOTActivityModel_msg *dd = (WOTActivityModel_msg *)bean;
            _activitydataSource = dd.msg;
            if (_activitydataSource.count>0) {
                if ([_activitydataSource[0].pictureSite separatedWithString:@","].count !=0 ) {
                    _activityImageUrl = [_activitydataSource[0].pictureSite separatedWithString:@","][0];
                    
                    [_activityImage sd_setImageWithURL:[_activityImageUrl ToUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
                    
                }
            }

        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
        
    }];
}
\


-(void)getInfoDataFromWeb:(void(^)())complete{
    
    [WOTHTTPNetwork getAllNewInformation:^(id bean, NSError *error) {
        complete();
        if (bean) {
            WOTNewInformationModel_msg *dd = (WOTNewInformationModel_msg *)bean;
          
            _infodataSource = dd.msg;
            
            WOTNewInformationModel *model = _infodataSource[0];
           
            [_infoImage sd_setImageWithURL: [[model.pictureSite separatedWithString:@","][0] ToUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
            _InfoMessage.text = model.messageInfo;
            _InfoTime.text = model.issueTime;
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
        
    }];
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
