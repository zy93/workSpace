//
//  WORTMyEnterpriseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WORTMyEnterpriseVC.h"

#import "WOTJoiningEnterpriseVC.h"
#import "WOTCreateEnterpriseVC.h"
@interface WORTMyEnterpriseVC ()<UIScrollViewDelegate>

@property(nonatomic,strong)WOTJoiningEnterpriseVC *joinvc;
@property(nonatomic,strong)WOTCreateEnterpriseVC *createvc;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIew;

@property (weak, nonatomic) IBOutlet UILabel *joinLabel;
@property (weak, nonatomic) IBOutlet UILabel *createLabel;
@end

@implementation WORTMyEnterpriseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNavi];
    [self loadScrollViewSubviews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}
-(void)configNavi{
    [self configNaviBackItem];
    self.navigationItem.title = @"我的企业";
    
}

- (IBAction)joiningEnterprise:(id)sender {
    self.joinLabel.textColor = MainOrangeColor;
    self.createLabel.textColor = HighTextColor;
   [self.scrollVIew setContentOffset:CGPointMake(0,0) animated:YES];
}

- (IBAction)createEnterprise:(id)sender {
    
    self.joinLabel.textColor = HighTextColor;
    self.createLabel.textColor = MainOrangeColor;
    [self.scrollVIew setContentOffset:CGPointMake(self.scrollVIew.frame.size.width,0) animated:YES];
    
}

-(void)viewDidLayoutSubviews{
    
    self.scrollVIew.contentSize = CGSizeMake(2*self.scrollVIew.frame.size.width, self.scrollVIew.frame.size.height);
}

-(void)loadScrollViewSubviews{
    _joinvc = [[WOTJoiningEnterpriseVC alloc]init];
    _joinvc.view.frame = CGRectMake(0, 0, self.scrollVIew.frame.size.width, self.scrollVIew.frame.size.height);
    
    
    _createvc = [[WOTCreateEnterpriseVC alloc]init];
    _createvc.view.frame = CGRectMake(self.scrollVIew.frame.size.width,0,self.scrollVIew.frame.size.width,self.scrollVIew.frame.size.height);
    self.scrollVIew.showsHorizontalScrollIndicator = NO;
    [self.scrollVIew addSubview:_joinvc.view];
    [self.scrollVIew addSubview:_createvc.view];
    
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
