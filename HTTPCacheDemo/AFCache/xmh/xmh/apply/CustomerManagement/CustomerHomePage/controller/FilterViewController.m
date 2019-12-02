//
//  FilterViewController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/30.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FilterViewController.h"
#import "MzzFilterTbSectionHeaderViewCommon.h"
#import "MzzFilterTbSectionHeaderViewTextfiled.h"
#import "JasonSearchView.h"
#import "MzzfilterCell.h"
#import "MzzFilterDatePickerCell.h"
#import "MzzCustomerRequest.h"
#import "MzzLevelModel.h"
#import "MzzCardsModel.h"
#import "MzzFilterCommitModel.h"
#import "MzzFilterModel.h"
#import "MzzFilterBaseModel.h"
#import "MzzDengjiModel.h"
#import "ShareWorkInstance.h"
@interface FilterViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FilterViewController
{
    NSArray * _titlesArr;
    JasonSearchView * _searchView;
    NSMutableArray * _btnTitleArr;
    NSInteger _section;
    UITableView * _tb;
    BOOL _isSelect;
    NSMutableArray * _selectArr;
    UIButton * _selectBtn;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _selectArr = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor redColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
//
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
 
}

- (void)setCommitModel:(MzzFilterCommitModel *)commitModel{
    _commitModel = commitModel;
    if (!_commitModel) {
         _commitModel = [[MzzFilterCommitModel alloc] init];
    }
    [self initData];
    [self initSubViews];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"join_code"] =  [ShareWorkInstance shareInstance].join_code;
    [MzzCustomerRequest requestCardListParams:params resultBlock:^(ESRootClass *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if(listModel.data.count > 0){
            [_btnTitleArr replaceObjectAtIndex:5 withObject:listModel.data];
        }
    }];
    [MzzCustomerRequest requestCustomerLevelParams:params resultBlock:^(MzzDengjiModel *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (listModel.list.count > 0) {
            [_btnTitleArr replaceObjectAtIndex:10 withObject:listModel.list];
        }
    }];
}
- (void)tap{}
- (void)initData
{
    _titlesArr = @[@"按时间",@"按消费",@"按消耗",@"按负债",@"按服务余次",@"按卡项",@"到店频次",@"单卡项目数",@"均次消耗单价",@"按消费时间",@"按顾客等级",@"按顾客年龄阶段"];
     _btnTitleArr = [[NSMutableArray alloc] initWithArray:@[@[],@[],@[],@[],@[],@[],@[@"1次",@"2次",@"3次",@"4次",@"4次以上"],@[@"1个",@"2个",@"3个",@"4个",@"4个以上"],@[@"200元以下",@"200元",@"300元",@"400元",@"400元以上"],@[@"1-3个月",@"4-6个月",@"7-9个月",@"10-12个月",@"12个月以上"],@[@"一星会员",@"二星会员",@"标准会员",@"准a客",@"a客",@"aa客",@"3a客",@"4a客",@"大a客"],@[@"66年以上",@"66-70",@"71-75",@"76-80",@"81-85",@"86-90",@"91年以后"]]];
    NSMutableArray * arr1 = [[NSMutableArray alloc] init];
    NSArray * a1 = @[@"1",@"2",@"3",@"4",@"4-"];
    for (int i = 0 ; i < ((NSArray *)_btnTitleArr[6]).count;i++) {
        MzzFilterModel * model = [[MzzFilterModel alloc] init];
        model.title = _btnTitleArr[6][i];
        model.code = a1[i];
        [arr1 addObject:model];
    }
    [_btnTitleArr replaceObjectAtIndex:6 withObject:arr1];
    
    NSMutableArray * arr2 = [[NSMutableArray alloc] init];
    NSArray * a2 = @[@"1",@"2",@"3",@"4",@"4-"];
    for (int i = 0 ; i < ((NSArray *)_btnTitleArr[7]).count;i++) {
        MzzFilterModel * model = [[MzzFilterModel alloc] init];
        model.title = _btnTitleArr[7][i];
        model.code = a2[i];
        [arr2 addObject:model];
    }
    [_btnTitleArr replaceObjectAtIndex:7 withObject:arr2];
    
    NSMutableArray * arr3 = [[NSMutableArray alloc] init];
    NSArray * a3 = @[@"-200",@"200",@"300",@"400",@"400-"];
    for (int i = 0 ; i < ((NSArray *)_btnTitleArr[8]).count;i++) {
        MzzFilterModel * model = [[MzzFilterModel alloc] init];
        model.title = _btnTitleArr[8][i];
        model.code = a3[i];
        [arr3 addObject:model];
    }
    [_btnTitleArr replaceObjectAtIndex:8 withObject:arr3];
    
    NSMutableArray * arr4 = [[NSMutableArray alloc] init];
    NSArray * a4 = @[@"1-3",@"4-6",@"7-9",@"10-12",@"12-"];
    for (int i = 0 ; i < ((NSArray *)_btnTitleArr[9]).count;i++) {
        MzzFilterModel * model = [[MzzFilterModel alloc] init];
        model.title = _btnTitleArr[9][i];
        model.code = a4[i];
        [arr4 addObject:model];
    }
    [_btnTitleArr replaceObjectAtIndex:9 withObject:arr4];
    
    NSMutableArray * arr5 = [[NSMutableArray alloc] init];
    for (NSString * title in _btnTitleArr[10]) {
        MzzFilterModel * model = [[MzzFilterModel alloc] init];
        model.title = title;
        [arr5 addObject:model];
    }
    [_btnTitleArr replaceObjectAtIndex:10 withObject:arr5];
    
    NSArray * a6 = @[@"-66",@"66-70",@"71-75",@"76-80",@"81-85",@"86-90",@"90-"];
    NSMutableArray * arr6 = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < ((NSArray *)_btnTitleArr[11]).count;i++) {
        MzzFilterModel * model = [[MzzFilterModel alloc] init];
        model.title = _btnTitleArr[11][i];
        model.code = a6[i];
        [arr6 addObject:model];
    }
    [_btnTitleArr replaceObjectAtIndex:11 withObject:arr6];
//    _btnTitleArr = [[NSMutableArray alloc] initWithArray:@[@[],@[],@[],@[],@[],@[],arr1,arr2,arr3,arr4,arr5,arr6]];
}
- (void)initSubViews
{
//    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 75, self.view.height)];
//    backView.backgroundColor = [UIColor darkGrayColor];
//    backView.alpha = 0.7;
//    [self.view addSubview:backView];
    UITableView * tb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-75, self.view.height) style:UITableViewStylePlain];
    UIView * tableViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-75, 100)];
    UILabel * lb = [[UILabel alloc] init];
    lb.text = @"筛选范围";
    lb.textColor = kLabelText_Commen_Color_6;
    lb.font = FONT_SIZE(15);
    [lb sizeToFit];
    lb.frame = CGRectMake(15, 20, lb.width, lb.height);
    [tableViewHeader addSubview:lb];
    
    _searchView = [[JasonSearchView alloc]initWithFrame:CGRectMake(0, lb.bottom + 10, SCREEN_WIDTH-75, 45)withPlaceholder:@"姓名/手机号"];
    _searchView.searchBar.btnRightBlock = ^{
        //搜索
    };
    [tableViewHeader addSubview:_searchView];
    [_searchView.searchBar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    tb.tableHeaderView = tableViewHeader;
    
    UIView * tablViewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH - 75, 70)];
    UIButton * bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt1 setTitle:@"取消" forState:UIControlStateNormal];
    bt1.layer.cornerRadius = 3;
    bt1.layer.borderWidth = 0.5;
    bt1.layer.masksToBounds = YES;
    bt1.layer.borderColor = kBtn_Commen_Color.CGColor;
    bt1.frame = CGRectMake(15, 15, 130, 44);
    [bt1 setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    [bt1 addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [tablViewFooter addSubview:bt1];
    
    UIButton * bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt2 setTitle:@"取消" forState:UIControlStateNormal];
    [bt2 setTitle:@"确定" forState:UIControlStateNormal];
    bt2.frame = CGRectMake(bt1.right + 10, 15, 130, 44);
    bt2.backgroundColor = kBtn_Commen_Color;
    [bt2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tablViewFooter addSubview:bt2];
    [bt2 addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    tb.tableFooterView = tablViewFooter;
    tb.dataSource = self;
    tb.delegate =self;
    _tb = tb;
    [self.view addSubview:tb];
}
- (void)submit:(UIButton *)btn{
    if ([btn.currentTitle isEqualToString:@"取消"]) {
        if (_FilterViewControllerBlock) {
            _FilterViewControllerBlock(nil);
        }
    }else{
        if (_FilterViewControllerBlock) {
            _FilterViewControllerBlock(_commitModel);
        }
      
    }
    
}
- (void)textFieldDidChange:(UITextField *) TextField
{
    //动态搜索
    _commitModel.q = TextField.text;
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
    MzzFilterTbSectionHeaderViewCommon * view = (MzzFilterTbSectionHeaderViewCommon *)tap.view;
    UIButton * btn = view.btn;
    _isSelect = btn.selected = !btn.selected;
    _selectBtn = btn;
    if ([_selectArr containsObject:@(btn.tag)]) {
        [_selectArr removeObject:@(btn.tag)];
    }else{
        [_selectArr addObject:@(btn.tag)];
    }
    [_tb reloadData];
}
- (void)click:(UIButton *)btn
{
    _isSelect = btn.selected = !btn.selected;
    _selectBtn = btn;
    if ([_selectArr containsObject:@(btn.tag)]) {
        [_selectArr removeObject:@(btn.tag)];
    }else{
        [_selectArr addObject:@(btn.tag)];
    }
    [_tb reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_selectArr containsObject:@(section)]) {
        return 1;
    }else{
        return 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *cellName = @"cell";
     static NSString *cellDatePicker = @"cellDatePicker";
    MzzFilterDatePickerCell * cell;
    MzzfilterCell *  Fcell;
    if (indexPath.section ==0) {
        if (!cell) {
            cell = [[MzzFilterDatePickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDatePicker];
        }
            cell.MzzFilterDatePickerCellBlock = ^(NSString *startStr, NSString *endStr) {
            _commitModel.start_date = startStr;
            _commitModel.end_date = endStr;
            };
        cell.startStr = _commitModel.start_date;
        cell.endStr = _commitModel.end_date;
        return cell;
    }else{
        if (!Fcell) {
            Fcell = [[MzzfilterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
            Fcell.contentArr = _btnTitleArr[indexPath.section];
            Fcell.MzzfilterCellBlock = ^(NSInteger index) {
                MzzFilterBaseModel * content = _btnTitleArr[indexPath.section][index];
                for (int i = 0; i < ((NSMutableArray *)_btnTitleArr[indexPath.section]).count; i++) {
                    MzzFilterBaseModel * model = _btnTitleArr[indexPath.section][i];
                    if (index == i) {
                        model.isSelect = !model.isSelect;
                    }else{
                        model.isSelect = NO;
                    }
                }
                [_tb reloadData];
                if ([content isKindOfClass:[MzzFilterModel class]]){
                    MzzFilterModel * model = (MzzFilterModel *)content;
                    NSString * title = _titlesArr[indexPath.section];
                    if ([title isEqualToString:@"到店频次"]) {
                        _commitModel.dao = model.code;
                    }else if ([title isEqualToString:@"均次耗卡单价"]){
                        _commitModel.pro_use_price = model.code;
                    }else if ([title isEqualToString:@"按消费时间"]){
                        _commitModel.pro_use_time = model.code;
                    }else if ([title isEqualToString:@"单卡项目数"]){
                        _commitModel.pro_use_num = model.code;
                    }else if ([title isEqualToString:@"按顾客年龄阶段"]){
                        _commitModel.agree = model.code;
                    }
                }else if([content isKindOfClass:[MzzDengji class]]){
                    MzzDengji *dengji = (MzzDengji *)content;
                    _commitModel.grade = [NSString stringWithFormat:@"%ld",dengji.key];
                }else{
                    MzzCardsModel * model =(MzzCardsModel *)content;
                    _commitModel.card_code = model.code;
                    _commitModel.card_type = model.type;
                }
            };
            return Fcell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MzzFilterTbSectionHeaderViewTextfiled * view = [[[NSBundle mainBundle]loadNibNamed:@"MzzFilterTbSectionHeaderViewTextfiled" owner:nil options:nil]lastObject];
    switch (section) {
        case 0:{
            break;
        }
        case 1:{
            view.tf1.text = _commitModel.start_sales;
            view.tf2.text = _commitModel.end_sales;
            break;
        }
        case 2:{
            view.tf1.text = _commitModel.start_use;
            view.tf2.text = _commitModel.end_use;
            break;
        }
        case 3:{
            view.tf1.text = _commitModel.start_serv;
            view.tf2.text = _commitModel.end_serv;
            break;
        }
        case 4:{
            view.tf1.text = _commitModel.start_serv_over;
            view.tf2.text = _commitModel.end_serv_over;
            break;
        }
        default:
            break;
    }
    view.MzzFilterTbSectionHeaderViewTextfiledBlock = ^(NSString *title, NSString *start, NSString *end) {
        if (start.length>0) {
            NSLog(@"........%@........%@.....%@",title,start,end);
            if([title isEqualToString:@"按消费"]) {
                _commitModel.start_sales = start;
                _commitModel.end_sales = end;
            }else if ([title isEqualToString:@"按消耗"]){
                _commitModel.start_use = start;
                _commitModel.end_use = end;
            }else if ([title isEqualToString:@"按负债"]){
                _commitModel.start_serv = start;
                _commitModel.end_serv = end;
            }else if ([title isEqualToString:@"按服务余次"]){
                _commitModel.start_serv_over = start;
                _commitModel.end_serv_over = end;
            }
        }else{
            NSLog(@"请先选择前面数值");
        }
    };
    
    MzzFilterTbSectionHeaderViewCommon * view1 = [[[NSBundle mainBundle]loadNibNamed:@"MzzFilterTbSectionHeaderViewCommon" owner:nil options:nil]lastObject];
    if (section ==_selectBtn.tag ) {
       view1.btn.selected = _isSelect;
    }
    view1.btn.tag = section;
    [view1.tap addTarget:self action:@selector(tap:)];
    [view1.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    if(section > 0 && section<5){
        view.lb.text = _titlesArr[section];
        return view;
    }else{
        view1.lb.text = _titlesArr[section];
        return view1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 240;
    }else if(indexPath.section > 0 && indexPath.section < 5){
        return 44;
    }else {
        NSInteger count = ((NSArray *)(_btnTitleArr[indexPath.section])).count;
        if (count >0) {
            if (count%3 ==0) {
                return  30 * count/3 + (count/3 -1)* 11;
            }else{
                return  30 * (count/3 + 1) + count/3* 11;
            }
        }
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
