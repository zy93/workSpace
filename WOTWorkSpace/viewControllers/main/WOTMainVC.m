//
//  WOTMainVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMainVC.h"
#import "header.h"
#import "WOTMainScrollViewCell.h"
#import "WOTMain3DCircleCell.h"
#import "ZYQSphereView.h"
@interface WOTMainVC ()<UIScrollViewDelegate>
@property(nonatomic,strong)ZYQSphereView *sphereView;

@end

@implementation WOTMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self load3DBallView];
    [self loadAutoScrollView];
    [self configScrollView];
//    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMainScrollViewCell" bundle:nil] forCellReuseIdentifier:@"WOTMainScrollViewCellID"];
//    
//    
//    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMain3DCircleCell" bundle:nil] forCellReuseIdentifier:@"WOTMain3DCircleCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)configScrollView{
    self.scrollVIew.delegate = self;
    UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, self.autoScrollView.frame.size.height+10+self.ballView.frame.size.height, self.view.frame.size.width,1000)];
    spaceView.backgroundColor = [UIColor redColor];
    [self.scrollVIew addSubview:spaceView];
    
//    self.scrollVIew. = YES;
    self.scrollVIew.contentSize = CGSizeMake(self.view.frame.size.width,self.autoScrollView.frame.size.height+10+self.ballView.frame.size.height+spaceView.frame.size.height+1000);
    
}

//MARK: scrollview delegate
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    
}


//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 5;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    switch (indexPath.row) {
//        case 0:
//            return 180;
//        case 1:
//            return 250;
//        case 2:
//            return 200;
//        case 3:
//            return 200;
//        case 4:
//            return 200;
//            break;
//            
//        default:
//            break;
//    }
//    return 0;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UITableViewCell *commoncell;
//    if (indexPath.row == 0) {
//        WOTMainScrollViewCell *scrollcell = [tableView dequeueReusableCellWithIdentifier:@"WOTMainScrollViewCellID" forIndexPath:indexPath];
//        commoncell = scrollcell;
//    } else if (indexPath.row == 1){
//        WOTMain3DCircleCell *main3D = [tableView dequeueReusableCellWithIdentifier:@"WOTMain3DCircleCellID" forIndexPath:indexPath];
//        commoncell = main3D;
//    } else if (indexPath.row == 2){
//        WOTMain3DCircleCell *main3D = [tableView dequeueReusableCellWithIdentifier:@"WOTMain3DCircleCellID" forIndexPath:indexPath];
//        commoncell = main3D;
//    }else if (indexPath.row == 3){
//        WOTMain3DCircleCell *main3D = [tableView dequeueReusableCellWithIdentifier:@"WOTMain3DCircleCellID" forIndexPath:indexPath];
//        commoncell = main3D;
//    }
//    else if (indexPath.row == 4){
//        WOTMain3DCircleCell *main3D = [tableView dequeueReusableCellWithIdentifier:@"WOTMain3DCircleCellID" forIndexPath:indexPath];
//        commoncell = main3D;
//    }
//    
//    
//   
//    return commoncell;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
