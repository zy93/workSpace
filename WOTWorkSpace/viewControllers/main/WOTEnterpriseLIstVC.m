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
@interface WOTEnterpriseLIstVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseTag;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseStyle;

@end

@implementation WOTEnterpriseLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getAllDataFromWeb];
    [self.tableView registerNib:[UINib nibWithNibName:@"myenterpriseCell" bundle:nil] forCellReuseIdentifier:@"myenterpriseCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tagsMenuClick:(id)sender {
    
    
    
}
- (IBAction)styleMenuClick:(id)sender {
    
    
    
    
    
    
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return  _dataSource;
}
#pragma mark - tableview datasource delgate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return _dataSource.count;
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
