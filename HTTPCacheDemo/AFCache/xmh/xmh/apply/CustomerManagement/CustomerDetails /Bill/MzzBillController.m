//
//  MzzBillController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/11.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzBillController.h"
#import "MzzBillCell.h"
#import "MzzBillDetailController.h"
#import "MzzCustomerRequest.h"
#import "MzzBillInfoListModel.h"
@interface MzzBillController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *billView;
@property (nonatomic ,strong)MzzBillInfoListModel *listModel;
@property (nonatomic ,copy)NSString *type;
@property (nonatomic ,copy)NSString *cardName;
@end

@implementation MzzBillController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self creatNav];
    self.view.backgroundColor = kBackgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"账单" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
    nav.lbTitle.textColor = [UIColor whiteColor];
    nav.backgroundColor = kBtn_Commen_Color;
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setUserID:(NSInteger)userID andType:(NSString *)type andTypeID:(NSInteger )typeID andCardName:(NSString *)cardName{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"user_id"] = [NSString stringWithFormat:@"%ld",userID];
    params[@"type"] = type;
    params[@"type_id"] =  [NSString stringWithFormat:@"%ld",typeID];
    _type = type;
    _cardName = cardName;
    [MzzCustomerRequest requestBillInfoParams:params resultBlock:^(MzzBillInfoListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _listModel = model;
        [self creatTableview];
    }];
}
- (void)creatTableview{
    _billView = [[UITableView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 10, SCREEN_WIDTH, Heigh_View_normal) style:UITableViewStylePlain];
    _billView.backgroundColor = kBackgroundColor;
    _billView.delegate = self;
    _billView.dataSource = self;
    _billView.tableFooterView = [[UIView alloc] init];
    _billView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_billView registerNib:[UINib nibWithNibName:@"MzzBillCell" bundle:nil] forCellReuseIdentifier:@"billcell"];
    [self.view addSubview:_billView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listModel.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static  NSString *ident = @"billcell";
    MzzBillCell *billcell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    if (!billcell) {
        billcell = [[[NSBundle mainBundle] loadNibNamed:@"MzzBillCell" owner:nil options:nil] firstObject];
    }
    MzzBillInfoModel *model = [_listModel.list objectAtIndex:indexPath.row];
    [billcell setupModel:model andType:_type andCardName:_cardName];
    return billcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MzzBillDetailController *detailVc = [[MzzBillDetailController alloc] init];
    detailVc.user_id = _user_id;
    [detailVc setupModel: [_listModel.list objectAtIndex:indexPath.row] andType:_type andCardName:_cardName];
    [self.navigationController pushViewController:detailVc animated:NO];
}


@end
