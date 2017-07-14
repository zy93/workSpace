//
//  WOTCreateEnterpriseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTCreateEnterpriseVC.h"
#import "WOTCerateEnterpriseCell.h"
#import "WOTEnterpriseTypeVC.h"
#import "WOTEnterpriseConnectsInfoVC.h"
@interface WOTCreateEnterpriseVC ()<UIActionSheetDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)NSArray *tableViewTitles;
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)WOTEnterpriseConnectsInfoVC *connectvc;
@property(nonatomic,strong)NSString *enterpriseType;
@property(nonatomic,strong)NSString *enterpriseConntects;
@property(nonatomic,strong)UIImage *enterpriseLogo;
@end

@implementation WOTCreateEnterpriseVC

- (void)viewDidLoad {
    
    __weak typeof(self) weakSelf = self;
    [super viewDidLoad];
    [self createDataSource];
    self.navigationItem.title = @"创建企业";
    [self configNaviRightItemWithTitle:@"保存" textColor:[UIColor redColor]];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTCerateEnterpriseCell" bundle:nil] forCellReuseIdentifier:@"WOTCerateEnterpriseCellID"];
    
    
    _connectvc = [[UIStoryboard storyboardWithName:@"My" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTEnterpriseConnectsInfoVCID"];
    _connectvc.view.frame = self.view.frame;
    
    _connectvc.cancelBlokc  = ^{
        [weakSelf setViewHidden];
    };
    _connectvc.okBlock = ^(NSString *name,NSString *tel, NSString *email){
        _enterpriseConntects = name;
        [self.tableView reloadData];
        [weakSelf setViewHidden];
        //TODO:保存输入的企业信息
    };
    _maskView = [[UIView alloc]initWithFrame:self.view.bounds];
    _maskView.backgroundColor = Black;
    _maskView.alpha = 0.5;
    [self.view addSubview:_maskView];
    [self.view addSubview:_connectvc.view];
    [self setViewHidden];
    // Do any additional setup after loading the view.
}
-(void)rightItemAction{
    //TODO:调用接口保存企业信息
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTCerateEnterpriseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTCerateEnterpriseCellID" forIndexPath:indexPath];
    cell.titleLabel.text = self.tableViewTitles[0][indexPath.row];
    if (indexPath.row == 2) {
        cell.textfield.placeholder = _enterpriseType?_enterpriseType:self.tableViewTitles[1][indexPath.row];
    }
    if (indexPath.row == 3) {
        cell.textfield.placeholder = _enterpriseConntects?_enterpriseConntects:self.tableViewTitles[1][indexPath.row];
    }
    

    cell.textfield.delegate  = self;
    cell.cameraImage.image = _enterpriseLogo?_enterpriseLogo : [UIImage imageNamed:@"camera_icon"];
    cell.cameraImage.hidden = indexPath.row == 0?NO:YES;
    cell.nextImage.hidden = indexPath.row == 0?YES:NO;
    [cell.textfield setUserInteractionEnabled:indexPath.row == 1?YES:NO];
    cell.textfield.hidden = indexPath.row == 0?YES:NO;
    cell.imageWidth.constant = _enterpriseLogo?45:25;
    cell.imageHeight.constant = _enterpriseLogo?45:20;
    return cell;
}



-(void)createDataSource {
    NSArray *title = @[@"企业logo",@"企业名称",@"企业类型",@"联系人信息"];
    NSArray *subTitle = @[@"企业logo",@"请输入企业名称",@"请选择",@"点击输入"];
    self.tableViewTitles = @[title,subTitle];
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self showSelectedPhotoSheet];
    } else if (indexPath.row == 2) {
        WOTEnterpriseTypeVC *typevc = [[UIStoryboard storyboardWithName:@"My" bundle:nil]instantiateViewControllerWithIdentifier:@"WOTEnterpriseTypeVCID"];
        typevc.gobackBlokc = ^(NSString *type){
            _enterpriseType = type;
            [self.tableView reloadData];
        };
        [self.supervc.navigationController pushViewController:typevc animated:YES];
    } else if (indexPath.row == 3){
        [self showView];
    }
}

-(void)showSelectedPhotoSheet{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [self addActionTarget:alert title:@"拍照" color: [UIColor blackColor] action:^(UIAlertAction *action) {
        [self openCamera];
    }];
    [self addActionTarget:alert title:@"从相册中选择" color:[UIColor blackColor] action:^(UIAlertAction *action) {
        [self openPhotoLibrary];
    }];
    [self addCancelActionTarget:alert title:@"取消"];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)addActionTarget:(UIAlertController *)alertController title:(NSString *)title color:(UIColor *)color action:(void(^)(UIAlertAction *action))actionTarget
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        actionTarget(action);
    }];
    [action setValue:color forKey:@"_titleTextColor"];
    [alertController addAction:action];
}

-(void)addCancelActionTarget:(UIAlertController*)alertController title:(NSString *)title
{
    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    [action setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    [alertController addAction:action];
}


//textfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}


/** 
 
 * 打开相机
 
 */
- (void)openCamera

{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    //判断是否可以打开照相机
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
    }
    
    else
        
    {
        
        [MBProgressHUDUtil showMessage:@"摄像头不可用" toView:self.view];
        
    }
    
}



/**
 
 *  打开相册
 
 */

-(void)openPhotoLibrary

{
// 进入相册
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        
    {
      
        UIImagePickerController *imageVC = [[UIImagePickerController alloc]init];
        
        imageVC.allowsEditing = YES;
        imageVC.delegate = self;
        imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
   
        
        [self presentViewController:imageVC animated:YES completion:^{
            
            NSLog(@"打开相册");
            
        }];
        
    }
    
    else
        
    {
        
        NSLog(@"不能打开相册");
        
    }
    
}



#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)

{

    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        
    {

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        
    }
    _enterpriseLogo = image;
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)setViewHidden{
    [_connectvc.view setHidden:YES];
    [_maskView setHidden:YES];
}

-(void)showView{
    [_connectvc.view setHidden:NO];
    [_maskView setHidden:NO];
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
