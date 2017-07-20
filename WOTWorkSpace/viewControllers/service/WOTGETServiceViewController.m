//
//  WOTGETServiceViewController.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTGETServiceViewController.h"
#import "WOTServiceProvidersCategoryVC.h"

@interface WOTGETServiceViewController ()
@property (weak, nonatomic) IBOutlet UITextView *describeText;
@property (weak, nonatomic) IBOutlet UIButton *selectServiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *tagsView;

@end

@implementation WOTGETServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [[WOTConfigThemeUitls shared] touchViewHiddenKeyboard:self.view];
    [WOTConfigThemeUitls shared].hiddenKeyboardBlcok = ^(){
        [self.describeText resignFirstResponder];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"获取服务";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"----- %@", self.selectServiceList);
}

#pragma mark - action 
- (IBAction)clickSelectServiceBtn:(id)sender {
    for (UIView *view in self.tagsView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    WOTServiceProvidersCategoryVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTServiceProvidersCategoryVC"];

    vc.selectServiceBlock = ^(NSArray *selectedServices){
    
        [[WOTConfigThemeUitls shared] loadtagsBtn:selectedServices superView:self.tagsView];
        [self viewWillLayoutSubviews];
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)clickSubmitBtn:(id)sender {
    
    if ([_describeText.text isEqualToString:@""] || self.selectServiceList.count == 0) {
        [MBProgressHUDUtil showMessage:UnInputServiceContentReminding toView:self.view];
    } else {
        [[WOTUserSingleton currentUser] setValues];
        NSString *dd = @"";
        for (NSString *text in _selectServiceList) {
            dd = [NSString stringWithFormat:@"%@%@%@",dd,text,@","];
        }
        [WOTHTTPNetwork postServiceRequestWithDescribe:self.describeText.text spaceId:[[NSNumber alloc]initWithInt:55 ] userId:[[NSNumber alloc]initWithInt:[[WOTUserSingleton currentUser].userId intValue]] facilitator_type:dd time:[NSDate date] response:^(id bean, NSError *error) {
            
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
