//
//  WOTEnterpriseLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/4.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTEnterpriseLIstVC.h"
#import "WOTMyEnterPriseCell.h"
#import "WOTEnterpirse.h"
#import "WOTMenuView.h"
@interface WOTEnterpriseLIstVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseTag;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseStyle;
@property (weak, nonatomic) IBOutlet UIView *tagfilter;
@property (weak, nonatomic) IBOutlet UIImageView *tagsArrowImage;
@property (weak, nonatomic) IBOutlet UIView *styleVIew;
@property (weak, nonatomic) IBOutlet UIImageView *styleArrowImage;

@property (nonatomic, strong) WOTMenuView *menuView;
@property (nonatomic, strong) WOTMenuView *stylemenuView;
@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) NSMutableArray *stylemenuArray;
@end

@implementation WOTEnterpriseLIstVC

bool istags =  NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self getAllDataFromWeb];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTMyEnterPriseCell" bundle:nil] forCellReuseIdentifier:@"myenterpriseCellID"];
    
    self.enterpriseTag.text = ((WOTFilterTypeModel *)self.menuArray[0]).filterName;
    self.enterpriseStyle.text = ((WOTFilterTypeModel *)self.stylemenuArray[0]).filterName;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tagsMenuClick:(id)sender {
    istags = YES;
    [self.menuView menuTappedWithSuperView:self.view];
    [self.menuView reloadData];
}
- (IBAction)styleMenuClick:(id)sender {
    
    istags = NO;
   
    [self.stylemenuView menuTappedWithSuperView:self.view];
    [self.stylemenuView reloadData];
    
}


-(void)configNav{
    [self configNaviBackItem];
    [self configNaviView:@"输入企业名或标签" block:^{
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    
}
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return  _dataSource;
}


-(NSMutableArray<WOTFilterTypeModel *> *)menu_filterDataArray {
    
    if (istags) {
        return self.menuArray;
    }else {
       return self.stylemenuArray;
    }
  
    
    
 
}

-(void)menu:(DropMenuView *)menu tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (WOTMenuView *)menuView {
    if (!_menuView && [self.menuArray count] > 0) {
        
        _menuView = [[WOTMenuView alloc] initWithOrigin:CGPointMake(0, self.tagfilter.frame.origin.y + self.tagfilter.frame.size.height)];
        _menuView.transformImageView = self.tagsArrowImage;
        _menuView.titleLabel = self.enterpriseTag;
        
        _menuView.dataSource = self;
        _menuView.delegate = self;
    }
    return _menuView;
}

-(NSMutableArray *)menuArray {
    if (!_menuArray) {
        
            _menuArray = [NSMutableArray array];
            WOTFilterTypeModel *model = [[WOTFilterTypeModel alloc]initWithName:@"全部" andId:@"one"];
            WOTFilterTypeModel *model2 = [[WOTFilterTypeModel alloc]initWithName:@"软件服务商" andId:@"two"];
            WOTFilterTypeModel *model3 = [[WOTFilterTypeModel alloc]initWithName:@"法律" andId:@"three"];
            WOTFilterTypeModel *model4 = [[WOTFilterTypeModel alloc]initWithName:@"硬件服务商" andId:@"four"];
            WOTFilterTypeModel *model5 = [[WOTFilterTypeModel alloc]initWithName:@"其他" andId:@"five"];
            [_menuArray addObject:model];
            [_menuArray addObject:model2];
            [_menuArray addObject:model3];
            [_menuArray addObject:model4];
            [_menuArray addObject:model5];
       
    }
   
    return _menuArray;
}


- (WOTMenuView *)stylemenuView {
    if (!_stylemenuView && [self.stylemenuArray count] > 0) {
        
        _stylemenuView = [[WOTMenuView alloc] initWithOrigin:CGPointMake(0, self.styleVIew.frame.origin.y + self.styleVIew.frame.size.height)];
        _stylemenuView.transformImageView = self.styleArrowImage;
        _stylemenuView.titleLabel = self.enterpriseStyle;
        
        _stylemenuView.dataSource = self;
        _stylemenuView.delegate = self;
    }
    return _stylemenuView;
}


-(NSMutableArray *)stylemenuArray {
    if (!_stylemenuArray) {
        
        _stylemenuArray = [NSMutableArray array];
        WOTFilterTypeModel *model = [[WOTFilterTypeModel alloc]initWithName:@"全部" andId:@"one"];
        WOTFilterTypeModel *model2 = [[WOTFilterTypeModel alloc]initWithName:@"服务商企业" andId:@"two"];
        WOTFilterTypeModel *model3 = [[WOTFilterTypeModel alloc]initWithName:@"普通企业" andId:@"third"];
        [_stylemenuArray addObject:model];
        [_stylemenuArray addObject:model2];
        [_stylemenuArray addObject:model3];
        
    }
    
    return _stylemenuArray;
}


#pragma mark - tableview datasource delgate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return 10;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return  70;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WOTMyEnterPriseCell *enterprisecell = [tableView dequeueReusableCellWithIdentifier:@"myenterpriseCellID" forIndexPath:indexPath];
    return enterprisecell;
}


//获取tableview数据源

-(void)getDataFromWeb:(NSString *)tag block:(void(^)()) refresh{
    //TODO:根据状态筛选
    [_tableView reloadData];
}

-(void)getAllDataFromWeb{
    
    WOTEnterpirse *enterprise = [[WOTEnterpirse alloc]initWithImage:@"" enterpriseName:@"北京物联港科技发展有限公司" enterpriseInfo:@"我们有健全的软件服务体系，为您打造周围的智慧社区"];
    [_dataSource addObject:enterprise];
    
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
