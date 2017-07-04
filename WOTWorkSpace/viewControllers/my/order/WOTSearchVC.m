//
//  WOTSearchVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSearchVC.h"

#import "WOTOrderCell.h"
@interface WOTSearchVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WOTSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviBackItem];
    [self configNaviView:@"请输入关键字" block:^(){
        
    }];
    [self loadSubViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setDataSource:(NSArray *)dataSource{
    if (dataSource) {
         dataSource = [[NSArray alloc]init];
    }
   
}
-(void)loadSubViews{
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = White;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"WOTOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"orderlistCellID"];
    [self.view addSubview:_tableView];
    
}

-(void)viewWillLayoutSubviews{
    [self.tableView layoutConstraintsToView:self.view];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTOrderCell *companycell = (WOTOrderCell *)[tableView dequeueReusableCellWithIdentifier:@"orderlistCellID"];
    

    return companycell;
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
