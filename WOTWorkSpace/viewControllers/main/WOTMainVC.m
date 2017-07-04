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
@interface WOTMainVC ()<UIScrollViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)ZYQSphereView *sphereView;
@property(nonatomic,strong)NewPagedFlowView *pageFlowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollviewHeight;
@property(nonatomic,strong)WOTworkSpaceLIstVC *spacevc;
@end

@implementation WOTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load3DBallView];
    [self loadAutoScrollView];
    [self configScrollView];
    [self loadSpaceView];
    
  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
//    [self.navigationController.navigationBar setHidden:YES];
     [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}


-(void)load3DBallView{
    _sphereView = [[ZYQSphereView alloc] initWithFrame:CGRectMake(15, 0, self.ballView.frame.size.width, self.ballView.frame.size.height)];
    NSArray *ballTitle = @[@"资讯",@"友邻",@"订工位",@"订会议室",@"开门",@"活动",@"预定场地",@"企业介绍",@"访客",@"精选",@"一键报修",@"意见反馈",@"集市",@"",@"",@"",@"",@"",@""];
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (int i = 0; i < ballTitle.count; i++) {
        UIButton *subV = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80,80)];
        
        [subV setBackgroundColor:UIColorFromRGB(0x86d3ff)];
        subV.alpha = 0.5;
        [subV setTitle:[NSString stringWithFormat:@"%@",ballTitle[i]] forState:UIControlStateNormal];
        [subV setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        subV.layer.masksToBounds=YES;
        subV.layer.cornerRadius=subV.frame.size.width/2;
        [subV addTarget:self action:@selector(subVClick:) forControlEvents:UIControlEventTouchUpInside];
        [views addObject:subV];
        
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

-(void)viewWillLayoutSubviews{
    self.scrollVIew.contentOffset = CGPointMake(0, 10);
     self.scrollVIew.contentSize = CGSizeMake(self.view.frame.size.width,self.autoScrollView.frame.size.height+self.ballView.frame.size.height+self.self.workspaceView.frame.size.height+self.activityView.frame.size.height+self.informationView.frame.size.height+80);
    
 
}

//3D球点击事件
-(void)subVClick:(UIButton*)sender{
    NSLog(@"%@",sender.titleLabel.text);
    
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
}
-(void)loadSpaceView{
    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",index]];
        [self.imageArray addObject:image];
    }
    
    [self setupUI];
}
-(void)configScrollView{
    self.scrollVIew.delegate = self;
    self.scrollVIew.showsHorizontalScrollIndicator = YES;
    self.scrollVIew.showsVerticalScrollIndicator = YES;
    self.scrollVIew.backgroundColor = MainColor;
    
  
    
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
    WOTworkSpaceDetailVC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVCID"];
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

//MARK:SDCycleScrollView   Delegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%@+%ld",cycleScrollView.titlesGroup[index],index);
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
