//
//  LanternPlanToAddTheGoodsVC.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/12/26.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternPlanToAddTheGoodsVC.h"
#import "SaleListRequest.h"
#import "SALeftModelList.h"
#import "ServiceLeftCell.h"
#import "SASaleListModel.h"
#import "LanternPlanProTableViewCell.h"

@interface LanternPlanToAddTheGoodsVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) IBOutlet UITextField *txtFeld;

@end

@implementation LanternPlanToAddTheGoodsVC
{
    SALeftModelList *_Gudingmodel;
    NSMutableDictionary *_dicRight;
    NSIndexPath     *_lastindexPath;
    NSString    *_typeStrRight;
    SaleModel *_ChangeSaleModelmodel;
    NSIndexPath *_ChangeindexPath;
    NSMutableArray *_GDKDProSelfTempArr;
    
    NSMutableArray *_GuDingSearchArr;
    BOOL _isGuDingSearch;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.topConstraint.constant = Heigh_Nav;
    _dicRight = [[NSMutableDictionary alloc]init];
    _GDKDProSelfTempArr = [[NSMutableArray alloc]init];
    _GuDingSearchArr = [[NSMutableArray alloc]init];

    self.txtFeld.delegate = self;
    self.leftTableView.dataSource = self;
    self.rightTableView.dataSource = self;
    self.leftTableView.delegate = self;
    self.rightTableView.delegate = self;
    WeakSelf
    [self.navView setNavViewTitle:self.titleStr backBtnShow:YES rightBtnTitle:@""];
    self.navView.backgroundColor = kBtn_Commen_Color;
    self.navView.NavViewBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:NO];
    };
    if ([self.titleStr isEqualToString:@"销售商品"]) {
        [self requestLeftData];
    }else{
        
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_GuDingSearchArr removeAllObjects];
    if (textField.text && (![textField.text isEqualToString:@""])) {
        _isGuDingSearch = YES;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS %@", textField.text];
        NSArray *arr = _dicRight[_typeStrRight];
        NSArray *temp = [arr filteredArrayUsingPredicate:predicate];
        [_GuDingSearchArr addObjectsFromArray:temp];
    }else{
        _isGuDingSearch = NO;
    }
    
}

-(void)requestLeftData{
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    [parms setValue:self.model.join_code forKey:@"join_code"];
    [parms setValue:[NSString stringWithFormat:@"%ld",self.model.user_id] forKey:@"user_id"];

    [SaleListRequest requestLeftJoinCode:@"SJ000003" type:@"1" resultBlock:^(SALeftModelList *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _Gudingmodel = model;
            [self.leftTableView reloadData];
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
            [self tableView:self.leftTableView didSelectRowAtIndexPath:index];
        }
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return _Gudingmodel.list.count;
    }else{
        NSArray * arr;
        if (_isGuDingSearch) {
            arr = _GuDingSearchArr;
        } else{
            arr = _dicRight[_typeStrRight];
        }
        return arr.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.leftTableView) {
        return 49;
    }else{
        return 80;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.leftTableView) {
        ServiceLeftCell *cell;
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ServiceLeftCell" owner:nil options:nil] firstObject];
        }else{
            cell  = [tableView dequeueReusableCellWithIdentifier:@"ServiceLeftCell"];
        }
        if (indexPath.row<_Gudingmodel.list.count) {
            SALeftModel *model = _Gudingmodel.list[indexPath.row];
            cell.lbTitle.text = model.name;
        }
        return cell;
    }else{
        LanternPlanProTableViewCell *cell;
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LanternPlanProTableViewCell" owner:nil options:nil] firstObject];
        }else{
            cell  = [tableView dequeueReusableCellWithIdentifier:@"LanternPlanProTableViewCell"];
        }
        NSArray *arr;
        if (_isGuDingSearch) {
            arr = _GuDingSearchArr;
        } else{
            arr = _dicRight[_typeStrRight];
        }
        if (arr &&(arr.count > 0)) {
            if (indexPath.row<arr.count) {
                SaleModel *model = arr[indexPath.row];
                [cell freshGuDingProOneCell:model];
                __weak LanternPlanProTableViewCell *weakcell = cell;
                cell.btnGDKDReduiceAddBlock = ^(SaleModel *model, NSInteger addflag) {
                    switch (addflag) {
                        case 1:
                        {
                            for (NSMutableDictionary *tempDic in _GDKDProSelfTempArr) {
                                if ([tempDic[@"code"] isEqualToString:model.code]) {
                                    if (model.addnum == 0) {
                                        [_GDKDProSelfTempArr removeObject:tempDic];
                                    }else{
                                        tempDic[@"num"] = @(model.addnum);
                                        
                                    }
                                    break;
                                }
                            }
                        }
                            break;
                        case 2:
                        {
                            BOOL isFind = NO;
                            for (NSMutableDictionary *tempDic in _GDKDProSelfTempArr) {
                                if ([tempDic[@"code"] isEqualToString:model.code]) {
                                    tempDic[@"num"] = @(model.addnum);
                                    isFind = YES;
                                    break;
                                }
                            }
                            if (!isFind) {
                                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                                dic[@"name"] = model.name;
                                dic[@"code"] = model.code;
                                dic[@"price"] = weakcell.priceLabel.text;
                                dic[@"type"] = _typeStrRight;
                                dic[@"num"] = @(model.addnum);
                                [_GDKDProSelfTempArr addObject:dic];
                            }
                        }
                            break;
                        default:
                            break;
                    }
                    [self.rightTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                };
                
            }
        }
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.leftTableView) {
        if (_lastindexPath) {
            ServiceLeftCell *cell = [self.leftTableView cellForRowAtIndexPath:_lastindexPath];
            cell.lbTitle.textColor = kLabelText_Commen_Color_3;
            cell.contentView.backgroundColor = kBackgroundColor;
        }
        ServiceLeftCell *cell = [self.leftTableView cellForRowAtIndexPath:indexPath];
        cell.lbTitle.textColor = kBtn_Commen_Color;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        _lastindexPath = indexPath;
        [self reloadData:indexPath.row];
    }
}
- (void)reloadData:(NSInteger)row{
    SALeftModel *model = _Gudingmodel.list[row];
    _typeStrRight = model.type;
    _isGuDingSearch = NO;
    [self requestRightData:_typeStrRight];
}
- (void)requestRightData:(NSString *)typeStr{
    NSArray *arr = _dicRight[typeStr];
    if (arr &&(arr.count > 0)) {
        [self.rightTableView reloadData];
        return;
    }
    [SaleListRequest requestSaleListJoinCode:@"SJ000003" store_code:@"MD000022" type:typeStr user_id:22373 resultBlock:^(SASaleListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            if (model.list && (model.list.count > 0)) {
                [_dicRight setValue:model.list forKey:typeStr];
            }
            [self.rightTableView reloadData];
        }
    }];
}
- (IBAction)sureButtonAction:(id)sender {
    
    if (_LanternPlanAddModelBlock) {
        _LanternPlanAddModelBlock(_GDKDProSelfTempArr);
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
