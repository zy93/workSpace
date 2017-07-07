//
//  WOTCreateEnterpriseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTCreateEnterpriseVC.h"
#import "WOTCerateEnterpriseCell.h"
@interface WOTCreateEnterpriseVC ()<UIActionSheetDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)NSArray *tableViewTitles;

@end

@implementation WOTCreateEnterpriseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataSource];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTCerateEnterpriseCell" bundle:nil] forCellReuseIdentifier:@"WOTCerateEnterpriseCellID"];
    
     // Do any additional setup after loading the view.
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
    cell.textfield.placeholder = self.tableViewTitles[1][indexPath.row];
    cell.cameraImage.hidden = indexPath.row == 0?NO:YES;
    cell.nextImage.hidden = indexPath.row == 0?YES:NO;
    [cell.textfield setUserInteractionEnabled:indexPath.row == 1?YES:NO];
    cell.textfield.hidden = indexPath.row == 0?YES:NO;
    return cell;
}



-(void)createDataSource {
    NSArray *title = @[@"企业logo",@"企业名称",@"企业类型·",@"联系人信息"];
    NSArray *subTitle = @[@"企业logo",@"请输入企业名称",@"请选择",@"点击输入"];
    self.tableViewTitles = @[title,subTitle];
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self showSelectedPhotoSheet];
            break;
        case 1:
            
        case 2:
            //TODO:进入选择企业类型页面
        case 3:
            
        default:
            break;
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

-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField  = NO;
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
