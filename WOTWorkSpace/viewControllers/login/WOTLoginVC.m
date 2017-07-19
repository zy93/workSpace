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
#import "WOTLoginModel.h"

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
    [MBProgressHUDUtil showLoadingWithMessage:@"登录中..." toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        
        [hud setHidden:YES];
        
        [WOTHTTPNetwork userLoginWithTelOrEmail:self.accountText.text password:self.passwordText.text response:^(id bean,NSError *error) {
            
            if (bean) {
                
                WOTLoginModel *dd = (WOTLoginModel *)bean;
                
                NSLog(@"当前用户名字：%@",dd.userName);
               
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
                    NSDictionary * userdic = @{@"userId":dd.userId,@"userName":dd.userName,@"password":dd.password,@"realName":dd.realName,@"sex":dd.sex,@"headPortrait":dd.headPortrait,@"userType":dd.userType,@"site":dd.site,@"skill":dd.skill,@"interest":dd.interest,@"industry":dd.industry,@"spared1":dd.spared1,@"constellation":dd.constellation};
                    [[WOTUserSingleton currentUser] saveUserInfoToPlist:userdic];
                    
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:LOGIN_STATE_USERDEFAULT];
                });
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"是否登陆：%d",[WOTSingtleton shared].isuserLogin);
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
                
            }
          
            if (error) {
                [MBProgressHUDUtil showMessage:error.localizedDescription toView:self.view];
            }
        }];
        
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
