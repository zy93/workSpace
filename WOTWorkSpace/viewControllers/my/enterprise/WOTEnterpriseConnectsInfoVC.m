//
//  WOTEnterpriseConnectsInfoVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseConnectsInfoVC.h"

@interface WOTEnterpriseConnectsInfoVC ()<UITextFieldDelegate>

@end

@implementation WOTEnterpriseConnectsInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bgview setCorenerRadius:10 borderColor:CLEARCOLOR];
    _nameTextfield.delegate  = self;
    _telTextfield.delegate = self;
    _emailTextfield.delegate = self;
    [self touchViewHiddenKeyboard];

    
  
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelClick:(id)sender {
    if (_cancelBlokc) {
        self.cancelBlokc();
    }
   
    [self keyboardHidden];
}


- (IBAction)okClick:(id)sender {
    if (_okBlock) {
        self.okBlock(self.nameTextfield.text, self.telTextfield.text, self.emailTextfield.text);
    }
    [self keyboardHidden];
}

//添加屏幕触摸方法，完成收键盘
-(void)touchViewHiddenKeyboard{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:) ];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self keyboardHidden];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}


-(void)keyboardHidden{
    [_nameTextfield resignFirstResponder];
    [_telTextfield resignFirstResponder];
    [_emailTextfield resignFirstResponder];
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
