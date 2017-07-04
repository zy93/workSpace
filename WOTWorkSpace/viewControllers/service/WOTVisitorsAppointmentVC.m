//
//  WOTVisitorsAppointmentVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTVisitorsAppointmentVC.h"
#import "WOTVisitorsAppointmentCell.h"
#import "WOTVisitTypeCell.h"

@interface WOTVisitorsAppointmentVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableList;
    NSArray *tableSubtitleList;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WOTVisitorsAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self addData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"访客预约";
    
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)addData
{
    tableList = @[@"访客照片", @"姓名", @"手机号码", @"访问社区", @"访问类型", @"受访对象", @"来访事由", @"到访人数", @"到访日期"];
    tableSubtitleList = @[@"", @"必填", @"必填", @"请选择", @"", @"请输入", @"请选择", @"必填", @"请选择"];
    [self.table reloadData];
}


#pragma mark - table delegate & data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 4) {
        WOTVisitTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTVisitTypeCell"];
        if (cell == nil) {
            cell = [[WOTVisitTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTVisitTypeCell"];
        }
        [cell.titleLab setText:tableList[indexPath.row]];
        return  cell;
    }
    else {
        WOTVisitorsAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTVisitorsAppointmentCell"];
        if (cell == nil) {
            cell = [[WOTVisitorsAppointmentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTVisitorsAppointmentCell"];
        }
        [cell.titleLab setText:tableList[indexPath.row]];
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([tableView isEqual:self.table1]) {
//        WOTServiceProvidersCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        table2List = table1Dict[cell.titleLab.text];
//        [self.table2 reloadData];
//    }
//    else {
//    }
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
