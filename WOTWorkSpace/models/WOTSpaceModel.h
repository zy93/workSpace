//
//  WOTSpaceModel.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/13.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface WOTSpaceModel : JSONModel
@property(nonatomic,assign)NSNumber* spaceId;
@property(nonatomic,strong)NSString *spaceName;
@property(nonatomic,strong)NSString *spaceDescribe;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *spaceSite;
@property(nonatomic,strong)NSString *fixPhone;
@property(nonatomic,strong)NSString *relationTel;
@property(nonatomic,assign)NSNumber *spaceState;
@property(nonatomic,strong)NSString *creationTime;
@property(nonatomic,strong)NSString *spacePicture;


-(instancetype)initWithSpaceId:(long)spaceId spaceName:(NSString *)spaceName spaceDescribe:(NSString *)spaceDescribe  city:(NSString *)city spaceSite:(NSString *)spaceSite fixPhone:(NSString *)fixPhone relationTel:(NSString *)relationTel spaceState:(long)spaceState creationTime:(NSString *)creationTime spacePicture:(NSString *)spacePicture lng:(long)lng lat:(long)lat;
@end

@interface WOTSpaceModel_msg : JSONModel
@property(nonatomic,strong)NSString *code;
@property(nonatomic,strong)NSArray<WOTSpaceModel *> *msg;

@end
