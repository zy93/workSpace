//
//  WOTUserRegisterVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/6.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTUserRegisterVC.h"
#import "WOTSelectCityCodeVC.h"
#import "WOTRegisterModel.h"
#import "WOTGetVerifyModel.h"

@interface WOTUserRegisterVC ()

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *selectCityBtn;

@property (weak, nonatomic) IBOutlet UILabel *cityCodeLab;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *verificationPasswordText;

@property (weak, nonatomic) IBOutlet UITextField *verificationCodeText;
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerProcotol;

@end

@implementation WOTUserRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.registerBtn.layer.cornerRadius = 8;
    self.registerBtn.layer.borderColor = UIColorFromRGB(0x4088ef).CGColor;
    self.registerBtn.layer.borderWidth = 1.f;
    
    self.getVerificationCodeBtn.layer.cornerRadius = 8;
    self.getVerificationCodeBtn.layer.borderColor = UIColorFromRGB(0x888888).CGColor;
    self.getVerificationCodeBtn.layer.borderWidth = 1.f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    if (self.cityName) {
        [self.selectCityBtn setTitle:self.cityName forState:UIControlStateNormal];
        [self.cityCodeLab setText:self.cityCode];
    }
    
}

#pragma mark - action

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSelectBtn:(id)sender {
    WOTSelectCityCodeVC *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSelectCityCodeVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickGetVerificationCodeBtn:(id)sender {
    [WOTHTTPNetwork userGetVerifyWitTel:self.phoneText.text response:^(id bean, NSError *error) {
        WOTGetVerifyModel *model = bean;
        if (model.code.intValue == 200) {
            [MBProgressHUDUtil showMessage:@"发送成功" toView:self.view];
        }
        else {
            [MBProgressHUDUtil showMessage:@"发送失败，请稍后再试!" toView:self.view];
        }
    }];
}

- (IBAction)clickRegisterBtn:(id)sender {
    [WOTHTTPNetwork userRegisterWitUserNick:@"Tom" tel:self.phoneText.text password:self.passwordText.text response:^(id bean, NSError *error) {
        WOTRegisterModel *model = bean;
    }];
}

- (IBAction)clickProcotolBtn:(id)sender {
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
