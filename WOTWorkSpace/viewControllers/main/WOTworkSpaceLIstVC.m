//
//  WOTworkSpaceLIstVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTworkSpaceLIstVC.h"
#import "WOTworkSpaceSearchCell.h"
#import "WOTworkSpaceScrollVIewCell.h"
#import "WOTworkSpacenearCell.h"
#import "WOTworkSpaceCommonCell.h"
#import "WOTSpaceCityScrollView.h"

#import "WOTworkSpaceDetailVC.h"
@interface WOTworkSpaceLIstVC ()<UITableViewDelegate,UITableViewDataSource,WOTWorkSpaceMoreCityDelegate,UITextFieldDelegate>

@end

@implementation WOTworkSpaceLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.view.backgroundColor = MainColor;
    self.tableVIew.backgroundColor = CLEARCOLOR;
    self.tableVIew.showsVerticalScrollIndicator = NO;
    
    [WOTSingtleton shared].spaceCityArray = [NSMutableArray arrayWithObjects:@"全部", @"北京",@"上海",@"天津",@"深圳",@"北京",@"上海",@"天津",@"深圳",nil];
    [self configNav];
    [_tableVIew registerNib:[UINib nibWithNibName:@"WOTworkSpaceSearchCell" bundle:nil] forCellReuseIdentifier:@"WOTworkSpaceSearchCellID"];
    [_tableVIew registerNib:[UINib nibWithNibName:@"WOTworkSpaceCommonCell" bundle:nil] forCellReuseIdentifier:@"WOTworkSpaceCommonCellID"];
    [_tableVIew registerNib:[UINib nibWithNibName:@"WOTSpaceCityScrollView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"WOTSpaceCityScrollViewID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)configNav{
    
    [self configNaviBackItem];
    self.navigationItem.title = @"空间列表";
   
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return _dataSource.count;
            break;
            
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return 40;
                case 1:
                    return 130;
                case 2:
                    return 100;
                    break;
                    
                default:
                    break;
            }
            break;
        case 1:
            return 190;
            break;
            
        default:
            break;
    }
    return  0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 45;
            
        default:
            break;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    WOTSpaceCityScrollView *view = [[NSBundle mainBundle]loadNibNamed:@"WOTSpaceCityScrollView" owner:nil options:nil].lastObject;
    view.delegate = self;
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *commoncell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WOTworkSpaceSearchCell *searchcell = [tableView dequeueReusableCellWithIdentifier:@"WOTworkSpaceSearchCellID" forIndexPath:indexPath];
            searchcell.searchBarBlock = ^(NSString *searchText){
                [MBProgressHUDUtil showLoadingWithMessage:@"" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
                    [_dataSource removeAllObjects];
                    [self getDataSourceFromWebFWithCity:searchText complete:^{
                        [hud setHidden:YES];
                    }];
                }];
                
            };
            commoncell = searchcell;
        } else if (indexPath.row == 1){
            WOTworkSpaceScrollVIewCell *scrollcell = [tableView dequeueReusableCellWithIdentifier:@"WOTworkSpaceScrollVIewCellID" forIndexPath:indexPath];
            scrollcell.collectionImageViewBlock = ^(NSInteger index){
                
                //MARK:选择顶部城市筛选  修改数据源  修改sectionview的选中城市
                
                [_dataSource removeAllObjects];
                [self selectSpaceWithCity:index othersBlock:^{
                   NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                    [_tableVIew reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                    NSIndexPath *dd = [NSIndexPath indexPathForRow:index inSection:0];
                    NSDictionary *dic = @{@"cityindex":dd};
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"scrollToDestinationCity" object:nil userInfo:dic];
                }];
                
               
                
            };
            commoncell = scrollcell;
        } else {
            WOTworkSpacenearCell *nearcell = [tableView dequeueReusableCellWithIdentifier:@"WOTworkSpacenearCellID" forIndexPath:indexPath];
            commoncell = nearcell;
        }
    } else{
        WOTworkSpaceCommonCell *spacecell = [tableView dequeueReusableCellWithIdentifier:@"WOTworkSpaceCommonCellID" forIndexPath:indexPath];
        spacecell.lineVIew.hidden = indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1 ? YES:NO;
        
        spacecell.workSpaceName.text = _dataSource[indexPath.row].spaceName;

        spacecell.workSpaceLocation.text = _dataSource[indexPath.row].spaceSite;
        spacecell.stationNum.text = [_dataSource[indexPath.row].fixPhone stringByAppendingString:@"工位可预订"];
    
        [spacecell.workSpaceImage sd_setImageWithURL:[[_dataSource[indexPath.row].spacePicture separatedWithString:@","][0] ToUrl] placeholderImage:[UIImage imageNamed:@"spacedefault"]];
        NSLog(@"图片地址：%@",[NSString stringWithFormat:@"%@%@",HTTPBaseURL,[_dataSource[indexPath.row].spacePicture separatedWithString:@","][0]]);
        commoncell = spacecell;
    }
    return commoncell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTworkSpaceDetailVC *detailvc = [[UIStoryboard storyboardWithName:@"spaceMain" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTworkSpaceDetailVC"];
    detailvc.url = @"http://219.143.170.100:8012/makerSpace/activity.html";
    [self.navigationController pushViewController:detailvc animated:YES];
}
//切换城市headerview 点击更多action
-(void)showMoreCityVC{
    //TODO:跳转到城市列表页面
}
-(void)selectWithCity:(NSInteger)index{
    /**
     * @param 选择的城市的index， 在系统单利中索引即可
     */
    //TODO:根据城市进行筛选空间列表
    [_dataSource removeAllObjects];
    [self selectSpaceWithCity:index othersBlock:^{
        [self.tableVIew reloadData];
    }];
}
#pragma textfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

//从网络获取数据
-(void)getDataSourceFromWebFWithCity:( NSString * __nullable )city complete:(void(^)())complete{
    
    [WOTHTTPNetwork getAllSpaceWithCity:city block:^(id bean, NSError *error) {
         complete();
        if (bean != nil) {
            
           
            WOTSpaceModel_msg *dd = (WOTSpaceModel_msg *)bean;
            _dataSource = dd.msg;
            [self.tableVIew reloadData];
   
        }
        if (error) {
            [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
        }
        
    }];
    
}

//MARK:根据城市进行筛选空间列表
-(void)selectSpaceWithCity:(NSInteger)cityindex othersBlock:(void(^)())othersBlock{
    
    if (cityindex == 0) {
        [self getDataSourceFromWebFWithCity:nil complete:^{
            othersBlock();
            
        }];
    } else {
        [self getDataSourceFromWebFWithCity:[WOTSingtleton shared].spaceCityArray[cityindex] complete:^{
            othersBlock();
            
        }];
    }
    
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
