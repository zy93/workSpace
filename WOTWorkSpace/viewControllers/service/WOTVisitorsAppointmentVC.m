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
#import "WOTPhotosBaseUtils.h"
#import "WOTWorkspaceListVC.h"
#import "WOTVisitorsAppointmentSubmitCell.h"
#import "WOTRadioView.h"
#import "WOTDatePickerView.h"
#import "WOTVisitorsModel.h"
#import "WOTConstants.h"

@interface WOTVisitorsAppointmentVC () <UITableViewDelegate, UITableViewDataSource, WOTVisitorsAppointmentSubmitCellDelegate, WOTVisitorsAppointmentCellDelegate, WOTVisitTypeCellDelegate>
{
    NSArray *tableList;
    NSArray *tableSubtitleList;
    NSMutableArray *contentList;
    NSString *time;
    UIImage *headImage;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) WOTDatePickerView *datepickerview;

@end

@implementation WOTVisitorsAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    [self setupView];
    [self addData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"访客预约";
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

-(void)setupView
{
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
        NSLog(@"%ld年%ld月%ld日",year,month,day);
        time = [NSString stringWithFormat:@"%02d/%02d/%02d 00:00:00",(int)year, (int)month, (int)day];
    };
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden = YES;

}

-(void)addData
{
    tableList = @[@"访客照片", @"姓名", @"性别", @"手机号码", @"访问社区", @"访问类型", @"受访对象", @"来访事由", @"到访人数", @"到访日期", @"提交"];
    contentList = [NSMutableArray new];
    for (int i=0; i<tableList.count; i++) {
        [contentList addObject:@""];
    }
    [contentList replaceObjectAtIndex:2 withObject:@"男"];
    [contentList replaceObjectAtIndex:5 withObject:@(2)];
    tableSubtitleList = @[@"", @"必填", @"MAN", @"必填", @"请选择", @"", @"请输入", @"请选择", @"必填", @"请选择"];
    [self.table reloadData];
}



#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
//    enterpriseLogoPath = editingInfo[UIImagePickerControllerReferenceURL];
//    tableInputDatadic[@"firmLogo"] = enterpriseLogoPath;
    headImage = image;
    [self.table reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - cell delegate
-(void)submitVisitorInfo:(WOTVisitorsAppointmentSubmitCell *)cell
{
    NSString *visitorName = contentList[1];
    NSString *sex = contentList[2];
    NSString *tel = contentList[3];
    NSNumber *spaceId = self.spaceId;
    NSNumber *type = contentList[5];
    NSString *userName = contentList[6];
    NSString *visitorInfo =contentList[7];
    NSNumber *number = contentList[8];
    NSString *tim = time;
    
    if (strIsEmpty(visitorName)) {
        [MBProgressHUDUtil showMessage:@"姓名不能为空" toView:self.view];
        return;
    }else if (strIsEmpty(tel)) {
        [MBProgressHUDUtil showMessage:@"电话不能为空" toView:self.view];
        return;
    }else if (spaceId.integerValue<=0) {
        [MBProgressHUDUtil showMessage:@"请选择访问社区" toView:self.view];
        return;
    }else if (strIsEmpty(userName)) {
        [MBProgressHUDUtil showMessage:@"请选择访问对象" toView:self.view];
        return;
    }else if (strIsEmpty(visitorInfo)) {
        [MBProgressHUDUtil showMessage:@"请输入访问事由" toView:self.view];
        return;
    }else if (number.integerValue<=0) {
        [MBProgressHUDUtil showMessage:@"请输入到访人数" toView:self.view];
        return;
    }else if (strIsEmpty(tim)){
        [MBProgressHUDUtil showMessage:@"请选择到访日期" toView:self.view];
        return;
    }
    
    
    [WOTHTTPNetwork visitorAppointmentWithVisitorName:visitorName headPortrait:headImage sex:sex papersType:@(0) papersNumber:@"123456" tel:tel spaceId:spaceId accessType:type userName:userName visitorInfo:visitorInfo peopleNum:number visitTime:tim response:^(id bean, NSError *error) {
        WOTVisitorsModel *model = bean;
    }];
}

-(void)textFiledEndEnter:(WOTVisitorsAppointmentCell *)cell text:(NSString *)text
{
    if (!text) {
        return;
    }
    [contentList replaceObjectAtIndex:cell.index.row withObject:text];
}

-(void)selectVisitType:(WOTVisitTypeCell *)cell type:(NSInteger)type
{
    [contentList replaceObjectAtIndex:cell.index.row withObject:@(type)];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = tableList[indexPath.row];
    if ([str isEqualToString:@"访问类型"] || [str isEqualToString:@"提交"]) {
        return 80;
    }
    
    return 50;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 10;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = tableList[indexPath.row];

    
    if ([str isEqualToString:@"访问类型"]) {
        WOTVisitTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTVisitTypeCell"];
        if (cell == nil) {
            cell = [[WOTVisitTypeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTVisitTypeCell"];
        }
        [cell.titleLab setText:tableList[indexPath.row]];
        cell.delegate = self;
        cell.index = indexPath;
        return  cell;
    }
    else if ([str isEqualToString:@"提交"]) {
        WOTVisitorsAppointmentSubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTVisitorsAppointmentSubmitCell"];
        if (cell == nil) {
            cell = [[WOTVisitorsAppointmentSubmitCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTVisitorsAppointmentSubmitCell"];
        }
        cell.delegate = self;
        return  cell;
    }
    else {
        WOTVisitorsAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTVisitorsAppointmentCell"];
        if (cell == nil) {
            cell = [[WOTVisitorsAppointmentCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WOTVisitorsAppointmentCell"];
        }
        if ([str isEqualToString:@"访客照片"]) {
            cell.headImg.hidden = NO;
            if (headImage) {
                [cell.headImg setImage:headImage];
            }
        }
        else {
            cell.headImg.hidden = YES;
        }
        
        if ([str isEqualToString:@"访问社区"] || [str isEqualToString:@"到访日期"]) {
            cell.contentText.enabled = NO;
        }
        else {
            cell.contentText.enabled = YES;
        }
        if ([str isEqualToString:@"性别"]) {
            cell.contentText.hidden = YES;
            cell.headImg.hidden = YES;
            cell.manBtn.hidden = NO;
            cell.womBtn.hidden = NO;
        }
        else {
            cell.contentText.hidden = NO;
            cell.headImg.hidden = cell.headImg.isHidden;
            cell.manBtn.hidden = YES;
            cell.womBtn.hidden = YES;
        }
        if (self.spaceName && [str isEqualToString:@"访问社区"]) {
            cell.contentText.text = self.spaceName;
        }
        
        cell.delegate = self;
        cell.index = indexPath;
        [cell.titleLab setText:tableList[indexPath.row]];
        cell.contentText.placeholder = tableSubtitleList[indexPath.row];
        return  cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *str = tableList[indexPath.row];
    
    if (indexPath.row==0) {
        WOTPhotosBaseUtils *photo = [[WOTPhotosBaseUtils alloc]init];
        photo.onlyOne = YES;
        photo.vc = self;
        
        [photo showSelectedPhotoSheet];
    }
    else  if ([str isEqualToString:@"访问社区"]) {
        WOTWorkspaceListVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTWorkspaceListVC"];
        __weak typeof(self) weakSelf = self;
        vc.selectSpaceBlock = ^(NSNumber *spaceId, NSString *spaceName){
            weakSelf.spaceId = spaceId;
            weakSelf.spaceName = spaceName;
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([str isEqualToString:@"到访日期"]) {
        _datepickerview.hidden  = NO;
        [tableView becomeFirstResponder];
    }
}


//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [UIView new];
//    return view;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
