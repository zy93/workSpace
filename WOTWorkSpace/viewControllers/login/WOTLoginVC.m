//
//  WOTLoginVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/5.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTLoginVC.h"

#import "WOTSelectCityCodeVC.h"
#import "WOTUserRegisterVC.h"

@interface WOTLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *cityBtn;
@property (weak, nonatomic) IBOutlet UIButton *showPasswordBtn;
@property (weak, nonatomic) IBOutlet UILabel *areaCodeLab;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordBtn;

@end

@implementation WOTLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginBtn.layer.cornerRadius = 8;
    self.registerBtn.layer.cornerRadius = 8;
    self.registerBtn.layer.borderColor = UIColorFromRGB(0x4088ef).CGColor;
    self.registerBtn.layer.borderWidth = 1.f;
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
        [self.cityBtn setTitle:self.cityName forState:UIControlStateNormal];
        [self.areaCodeLab setText:self.cityCode];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - action

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickSelectCityBtn:(id)sender {
    WOTSelectCityCodeVC *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSelectCityCodeVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickShowPassBtn:(id)sender {
    UIButton *btn = sender;
    if (btn.isSelected) {
        self.passwordText.secureTextEntry = YES;
    }
    else {
        self.passwordText.secureTextEntry = NO;
    }
    btn.selected = !btn.isSelected;
}

- (IBAction)clickForgetPassBtn:(id)sender {
}

- (IBAction)clickLoginBtn:(id)sender {
    [WOTHTTPNetwork userLoginWithTelOrEmail:self.accountText.text password:self.passwordText.text response:^(id bean) {
        NSLog(@"====%@", bean);
    }];
}
- (IBAction)clickRegisterBtn:(id)sender {
    
    
    WOTUserRegisterVC *vc = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTUserRegisterVC"];
    [self.navigationController pushViewController:vc animated:YES];

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
