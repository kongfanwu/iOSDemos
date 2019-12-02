//
//  MzzAddPortraitViewController.m
//  xmh
//
//  Created by Ss H on 2018/11/17.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzAddPortraitViewController.h"
#import "BeeTagView.h"
#import "MzzCustomerRequest.h"
#import "MzzTags.h"

@interface MzzAddPortraitViewController ()
@property (nonatomic,strong)BeeTagView *beetagView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSString *uid;
@property (nonatomic,strong)NSString *storCode;
@property (nonatomic,strong)NSString *joinCode;

@end

@implementation MzzAddPortraitViewController
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _beetagView = [[BeeTagView alloc]initWithTextArr:self.dataArray TextColor:[UIColor grayColor] CellBackColor:nil CellBorderColor:[UIColor grayColor]];
    _beetagView.cellCornerRadius = 5;
    _beetagView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    WeakSelf;
    _beetagView.didselectBlock = ^(NSMutableArray *selectArray) {
        [weakSelf selectAdd:selectArray];
    };
    _beetagView.popToRoot = ^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    [self.view addSubview:_beetagView];
}
-(void)withUserId:(NSString *)userId andWithJsonCode:(NSString *)jsonCode andStroeCode:(NSString *)storeCode
{
    [self requsetDataWithId:userId andWithJsonCode:jsonCode andWithStoreCode:storeCode];
}
/**
 获取获取标签列表接口
 */

- (void)requsetDataWithId:(NSString *)uid andWithJsonCode:(NSString *)jsonCode andWithStoreCode:(NSString *)storeCode
{
    self.uid = uid;
    self.joinCode = jsonCode;
    self.storCode = storeCode;

    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:uid,@"user_id",jsonCode,@"join_code",storeCode,@"store_code", nil];
    WeakSelf;
    [MzzCustomerRequest requestCustomerTagsParams:dic resultBlock:^(MzzTagDatas *lolCalendarModelList, BOOL isSuccess, NSDictionary *errorDic) {
        [self.dataArray addObjectsFromArray:lolCalendarModelList.list];
        weakSelf.beetagView.tagArr = self.dataArray;
        [weakSelf.beetagView.myCollectionView reloadData];
    }];
}
/**
 添加标签请求接口
 */
-(void)selectAdd:(NSMutableArray *)array{

        NSString *string = [array componentsJoinedByString:@","];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.uid,@"user_id",self.joinCode,@"join_code",self.storCode,@"store_code",string,@"content_id", nil];
        WeakSelf;
        [MzzCustomerRequest requestSelectAddParams:dic resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            [weakSelf.navigationController popViewControllerAnimated:NO];
        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
