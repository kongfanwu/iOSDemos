     //
//  FWDRecordController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDRecordController.h"
#import "FWDCommentCell.h"
#import "FWDRecordCell.h"
#import "FWDCommitView.h"
#import "SLRequest.h"
#import "Base64.h"
#import "OrderManagementViewController.h"
#import "BookBillHomeVC.h"
@interface FWDRecordController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FWDRecordController
{
    UITableView * _tb;
    NSString * _content;
    NSMutableArray * _imsArr;
    NSMutableArray * _imsArrT;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    [self initSubViews];
}
- (void)initSubViews
{
    [self creatNav];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav+30) withTitleStr:@"执行效果记录" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lineImageView.hidden = YES;
    nav.backgroundColor = kBtn_Commen_Color;
    nav.lbTitle.textColor = [UIColor whiteColor];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
    [self createTableView];
}
- (void)pop
{
    //回到订单列表首页
    for (UIViewController * vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[OrderManagementViewController class]]) {
            [self.navigationController popToViewController:vc animated:NO];
        }
        if ([vc isKindOfClass:[BookBillHomeVC class]]) {
            [self.navigationController popToViewController:vc animated:NO];
        }
    }
}
- (void)createTableView
{
    _tb = [[UITableView alloc] initWithFrame:CGRectMake(15, Heigh_Nav, SCREEN_WIDTH-30, SCREEN_HEIGHT - Heigh_Nav) style:UITableViewStylePlain];
    _tb.delegate = self;
    _tb.dataSource = self;
    _tb.backgroundColor = [UIColor clearColor];
    _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tb];
    
    FWDCommitView * foot =  [[[NSBundle mainBundle]loadNibNamed:@"FWDCommitView" owner:nil options:nil]lastObject];
    [foot.btnCommit setTitle:@"确定" forState:UIControlStateNormal];
    [foot.btnCommit addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    foot.frame = CGRectMake(0, SCREEN_HEIGHT - 65, SCREEN_WIDTH, 65);
    [self.view addSubview:foot];
}
- (void)commit
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"id"] = _ordernum;
    params[@"content"] = _content;
    NSMutableArray *imgs = [NSMutableArray array];
    NSMutableArray *imgT = [NSMutableArray array];

    for (int i = 0; i < _imsArr.count; i ++) {
        UIImage *image = _imsArr[i];
        NSData *imageData = [image imageCompressToData];;
        [imgs addObject:[Base64 stringByEncodingData:imageData]];
    }
    for (int i = 0; i < _imsArrT.count; i ++) {
        UIImage *image = _imsArrT[i];
        NSData *imageData = [image imageCompressToData];;
        [imgT addObject:[Base64 stringByEncodingData:imageData]];
    }
    params[@"before_img"] = imgs;
    params[@"after_img"] = imgT;//需要后台设置

    if (imgs.count == 0||imgT.count == 0) {
        [XMHProgressHUD showOnlyText:@"图片为必填项，请先填充图片"];
        return ;
    }
    NSMutableDictionary * paramDic = [[NSMutableDictionary alloc] init];
    [paramDic setValue:params.jsonData forKey:@"data"];
    WeakSelf
    [SLRequest requestSerImgParams:paramDic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            [XMHProgressHUD showOnlyText:@"提交成功"];
            [weakSelf performSelector:@selector(pop) withObject:nil afterDelay:2];
        }
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        FWDRecordCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"FWDRecordCell" owner:nil options:nil]lastObject];
        cell.FWDRecordCellBlock = ^(NSMutableArray *imgs) {
            _imsArr = imgs;
        };
        cell.FWDRecordCellTBlock = ^(NSMutableArray *imgs) {
            _imsArrT= imgs;
        };
        return cell;
    }else{
        FWDCommentCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"FWDCommentCell" owner:nil options:nil]lastObject];
        cell.lbLimit.hidden = YES;
        cell.lb1.text = @"亲，可将执行的结果、顾客到店情况、项目执行情况，以及服务中需要注意的事项都填写于此，要知道认真的对待每一件事，才能更好的提升工作质量呦！";
        cell.lb1HeightConstraint.constant = 67;
        cell.FWDCommentCellBlock = ^(NSString *beizhu) {
            _content = beizhu;
        };
        return cell;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 300;
    }else{
        return 145;
    }
}
@end
