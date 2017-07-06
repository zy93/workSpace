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

@interface WOTworkSpaceLIstVC ()<UITableViewDelegate,UITableViewDataSource,WOTWorkSpaceMoreCityDelegate>

@end

@implementation WOTworkSpaceLIstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = White;
    self.tableVIew.backgroundColor = CLEARCOLOR;
   
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
    [self configNaviRightItemWithImage:[UIImage imageNamed:@"share"]];
}

-(void)rightItemAction{
    //TODO:分享到朋友圈等
    NSLog(@"分享到朋友圈去");
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
            return 10;
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
            commoncell = searchcell;
        } else if (indexPath.row == 1){
            WOTworkSpaceScrollVIewCell *scrollcell = [tableView dequeueReusableCellWithIdentifier:@"WOTworkSpaceScrollVIewCellID" forIndexPath:indexPath];
            commoncell = scrollcell;
        } else {
            WOTworkSpacenearCell *nearcell = [tableView dequeueReusableCellWithIdentifier:@"WOTworkSpacenearCellID" forIndexPath:indexPath];
            commoncell = nearcell;
        }
    } else{
        WOTworkSpaceCommonCell *spacecell = [tableView dequeueReusableCellWithIdentifier:@"WOTworkSpaceCommonCellID" forIndexPath:indexPath];
        commoncell = spacecell;
    }
    return commoncell;
}

//切换城市headerview 点击更多action
-(void)showMoreCityVC{
    //TODO:跳转到城市列表页面
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
