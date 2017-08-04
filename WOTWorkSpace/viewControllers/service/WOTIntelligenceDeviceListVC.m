//
//  WOTIntelligenceDeviceListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTIntelligenceDeviceListVC.h"
#import "WOTAirconditioningCell.h"
#import "WOTInteligenceDeviceCommonCell.h"
#import "WOTCurtainCell.h"
#import "WOTLightCell.h"
@interface WOTIntelligenceDeviceListVC ()<UITableViewDelegate,UITableViewDataSource,WOTAirconditioningDelegate,WOTLightCellDelegate,WOTCurtainCellDelegate>{
    BOOL airConditionOpen;
    BOOL curtainsOpen;
    BOOL lightOpen;
    NSInteger lightcellindex;
    NSMutableArray *lightSelectedindex;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation WOTIntelligenceDeviceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设备列表";
    [_tableView registerNib:[UINib nibWithNibName:@"WOTAirconditioningCell" bundle:nil] forCellReuseIdentifier:@"WOTAirconditioningCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"WOTInteligenceDeviceCommonCell" bundle:nil] forCellReuseIdentifier:@"WOTInteligenceDeviceCommonCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"WOTCurtainCell" bundle:nil] forCellReuseIdentifier:@"WOTCurtainCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"WOTLightCell" bundle:nil] forCellReuseIdentifier:@"WOTLightCell"];
    airConditionOpen = NO;
    curtainsOpen = NO;
    lightOpen = NO;
    lightSelectedindex = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                  return airConditionOpen?350:50;
            } else if (indexPath.row == 1){
                return curtainsOpen? 190:50;
            }
            break;
        case 1:
            if (lightOpen) {
                  return lightcellindex == indexPath.row?175:50;
            } else {
                return 50;
            }
          
        break;
        case 2:
            return 60;
            break;
        default:
            break;
    }
    return  0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0.01;
    } else {
        return  10;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commoncell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WOTAirconditioningCell *aircell = [tableView dequeueReusableCellWithIdentifier:@"WOTAirconditioningCellID" forIndexPath:indexPath];
            aircell.delegate = self;
            [aircell.cellSwitch setOn:airConditionOpen];
            aircell.bgview.hidden = !airConditionOpen;
            [aircell.lowBtn setTitleColor:aircell.lowBtn.isSelected?InteligenceDeviceSelectedColor:HighTextColor forState:UIControlStateNormal];
            
            commoncell = aircell;
        } else {
           WOTCurtainCell  *cutaincell = [tableView dequeueReusableCellWithIdentifier:@"WOTCurtainCell" forIndexPath:indexPath];
            cutaincell.titleLab.text = @"窗帘";
            cutaincell.delegate = self;
            [cutaincell.switchSW setOn:curtainsOpen];
            cutaincell.contentBGView.hidden = !curtainsOpen;
            commoncell = cutaincell;
        }
            
    } else if (indexPath.section == 2) {
        
        WOTInteligenceDeviceCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTInteligenceDeviceCommonCellID" forIndexPath:indexPath];
        cell.cellImage.image = [UIImage imageNamed:@"jack"];
        cell.cellTitle.text = @[@"1号插座",@"2号插座"][indexPath.row];
        commoncell = cell;
    } else if (indexPath.section == 1) {
        WOTLightCell *lightCell = [tableView dequeueReusableCellWithIdentifier:@"WOTLightCell" forIndexPath:indexPath];
        lightCell.iconImg.image = [UIImage imageNamed:@"lights"];
        lightCell.titleLab.text = @[@"1号灯",@"2号灯"][indexPath.row];
        lightCell.index = indexPath.row;
        lightCell.delegate = self;
        
      
        if (lightcellindex == indexPath.row && lightOpen ) {
              lightCell.contentBGView.hidden = NO;
            [lightCell.switchSW setOn:YES];
        } else {
              lightCell.contentBGView.hidden = YES;
            [lightCell.switchSW setOn:NO];
        }
        if (indexPath.row == lightcellindex) {
            [lightCell.switchSW setOn:lightOpen];
        }
        
        commoncell = lightCell;
    }
    return  commoncell;
}

/**
 *  aircondition delegate
*/
-(void)switchChangeState:(BOOL)switchState{
    airConditionOpen = switchState;
    if (airConditionOpen) {
        curtainsOpen = NO;
        lightOpen = NO;
    }
    [_tableView reloadData];
    
}
-(void)curtaincellOfSwitch:(WOTCurtainCell *)cell option:(BOOL)isOn{
    curtainsOpen = isOn;
    if (curtainsOpen) {
        airConditionOpen = NO;
        lightOpen = NO;
    }
    [_tableView reloadData];
}
-(void)lightcellOfSwitch:(NSInteger)index option:(BOOL)isOn{
    lightOpen = isOn;
    if (lightOpen) {
        airConditionOpen = NO;
        curtainsOpen = NO;
    }
    lightcellindex = index;
    if (isOn == YES ) {
        [lightSelectedindex addObject:[NSString stringWithFormat:@"%ld",index]];
    }
    if ([lightSelectedindex containsObject:[NSString stringWithFormat:@"%ld",index]] && isOn == NO) {
        [lightSelectedindex removeObject:[NSString stringWithFormat:@"%ld",index]];
    }
    [_tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}
//*/

@end
