//
//  LBillReviseController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/8.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LBillReviseController.h"
#import "ApproveRequest.h"
#import "Base64.h"
@interface LBillReviseController ()

@end

@implementation LBillReviseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
    [self uploadImages];
    
}
- (void)requset14{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    //        params[@"token"] = @"13b0a3bcdca0d0d6fb103ea094a67696";
    params[@"id"] = @"109203";
    params[@"content"] = @"备注";
    NSMutableArray *imgs = [NSMutableArray array];
    UIImage *image = kDefaultImage;
    NSData *imageData = UIImagePNGRepresentation(image);
    [imgs addObject:[Base64 stringByEncodingData:imageData]];
    [imgs addObject:[Base64 stringByEncodingData:imageData]];
    [imgs addObject:[Base64 stringByEncodingData:imageData]];
    params[@"img"] = imgs;
//    [SLRequest requestSerImgParams:params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
//
//    }];
}
- (void)uploadImages
{
    UIImage * img =kDefaultImage;
    UIImage * img1 =[UIImage imageNamed:@"meilidingzhi"];
    NSData  * imgData = UIImagePNGRepresentation(img);
     NSData  * imgData1 = UIImagePNGRepresentation(img1);
    [ApproveRequest requestUploadImg:@[[Base64 stringByEncodingData:imgData],[Base64 stringByEncodingData:imgData1]] resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            
        }
    }];
}
- (void)initSubViews
{
    [self createNav];
}
- (void)createNav
{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"账单校正" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}


- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
