//
//  MzzAwardView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/14.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "MzzAwardView.h"
#import "SASaleListModel.h"
#import "MzzAwardCell.h"
#import "SaleListRequest.h"
#import "ShareWorkInstance.h"
#import "AppDelegate.h"

@interface MzzAwardView ()<UITableViewDelegate,UITableViewDataSource,LMJDropdownMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableView *awardTableview;
@property (nonatomic ,strong)NSMutableArray *arr;
@property (nonatomic ,strong)MzzHud *hud;
@property (nonatomic ,strong)SASaleListModel *saleListModel;
@property (nonatomic ,strong)SaleModel *selectedModel;
@property (nonatomic ,assign)NSInteger totlePrice;
@property (nonatomic ,strong)MzzTipAwardView *tipAwardView;
@end
@implementation MzzAwardView
- (void)awakeFromNib{
    [super awakeFromNib];
    if (_list == nil) {
         _list = [NSMutableArray array];
    }
}
- (void)setList:(NSMutableArray<SaleModel *> *)list{
    _list = list;
    [_awardTableview reloadData];
    if (_awardCommit) {
        self.awardCommit(_list,NO);
    }
}
- (IBAction)btnClick:(UIButton *)sender {
    
    _selectedModel = nil;
    _saleListModel = nil;
    MzzHud *hud = [[MzzHud alloc] initWithAwardClick:^(NSInteger index, id something) {
        
    }];
    _hud = hud;
    _tipAwardView = hud.tipAwardView;
    [hud.tipAwardView.jiangzengleixing setMenuTitles:@[@"产品",@"项目"] rowHeight:30];
    
    hud.tipAwardView.jiangzengleixing.delegate = self;
    hud.tipAwardView.jiangzengneirong.delegate = self;
    [hud.tipAwardView.quxiao addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    [hud.tipAwardView.tianjia addTarget:self action:@selector(tianjia:) forControlEvents:UIControlEventTouchUpInside];
    [hud.tipAwardView.jiahao addTarget:self action:@selector(jiahao) forControlEvents:UIControlEventTouchUpInside];
    [hud.tipAwardView.jianhao addTarget:self action:@selector(jianhao) forControlEvents:UIControlEventTouchUpInside];
   
    
    [hud show];
}
-(void)dropdownMenu:(LMJDropdownMenu *)menu selectedCellNumber:(NSInteger)number{
    if (menu.tag ==0) {
        _arr = [NSMutableArray array];
        //类型
        NSString *type;
        if (number == 0) {
            type = @"goods";
        }
        if (number == 1) {
            type = @"pro";
        }
        [SaleListRequest requestSaleListJoinCode:[ShareWorkInstance shareInstance].join_code store_code:_store_code type:type user_id:_user_id resultBlock:^(SASaleListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
            [_hud.tipAwardView.jiangzengneirong hideDropDown];
            _saleListModel = model;
            for (int i = 0; i < model.list.count; i++) {
                SaleModel *saleModel = [_saleListModel.list objectAtIndex:i];
                [saleModel setType:(XMHServiceOrderType)type];
                [_arr addObject:saleModel.name];
            }
            [_hud.tipAwardView.jiangzengneirong setMenuTitles:_arr rowHeight:30];
        }];
        _tipAwardView.jiangzengshuliang.text = @"0";
        _totlePrice = 0;
        _tipAwardView.jiangzengjiazhi.text = @"0";
    }
    
    
    if (menu.tag == 1) {
        //内容
        _selectedModel = [_saleListModel.list objectAtIndex:number];
        _tipAwardView.jiangzengshuliang.text = @"0";
        _totlePrice = 0;
        _tipAwardView.jiangzengjiazhi.text = @"0";
    }
}
- (void)jiahao{
    _selectedModel.mzzAwardCount = _tipAwardView.jiangzengshuliang.text.integerValue;
    _totlePrice =_selectedModel.mzzAwardCount * _selectedModel.price_list.pro_11.price.integerValue;
    _selectedModel.mzzAwardTotlePrice = _totlePrice;
    [_hud.tipAwardView.jiangzengjiazhi setText:[NSString stringWithFormat:@"%ld",_totlePrice]];
}
- (void)jianhao{
    _selectedModel.mzzAwardCount =_tipAwardView.jiangzengshuliang.text.integerValue;
    _totlePrice =_selectedModel.mzzAwardCount * _selectedModel.price_list.pro_11.price.integerValue;
    _selectedModel.mzzAwardTotlePrice = _totlePrice;
    [_hud.tipAwardView.jiangzengjiazhi setText:[NSString stringWithFormat:@"%ld",_totlePrice]];
}
- (void)quxiao:(UIButton *)sender{
    
}
- (void)tianjia:(UIButton *)sender{
    if (_selectedModel == nil) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择奖赠内容"];
        return;
    }
    if (_selectedModel.mzzAwardCount == 0) {
         [MzzHud toastWithTitle:@"提示" message:@"请选择奖赠数量"];
        return;
    }
    
    [_list addObject:_selectedModel];
    [_awardTableview reloadData];
    if (_awardCommit) {
        self.awardCommit(_list,NO);
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UILabel *jiangzengneirong = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 100, 20)];
    [jiangzengneirong setFont:[UIFont systemFontOfSize:14]];
    jiangzengneirong.textColor = kLabelText_Commen_Color_3;
    jiangzengneirong.text = @"奖赠内容";
    [sectionView addSubview:jiangzengneirong];
    
    UILabel *jiangzengshuliang = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH /2  - 30, 5, 100, 20)];
    jiangzengshuliang.text = @"奖赠数量";
    [jiangzengshuliang setFont:[UIFont systemFontOfSize:14]];
     jiangzengshuliang.textColor = kLabelText_Commen_Color_3;
    [sectionView addSubview:jiangzengshuliang];
    
    UILabel *jiangzengjiazhi = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -100, 5, 100, 20)];
    jiangzengjiazhi.text = @"奖赠价值";
    [jiangzengjiazhi setFont:[UIFont systemFontOfSize:14]];
     jiangzengjiazhi.textColor = kLabelText_Commen_Color_3;
    [sectionView addSubview:jiangzengjiazhi];
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MzzAwardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"award"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MzzAwardCell" owner:nil options:nil].firstObject;
    }
    [cell setModel: [_list objectAtIndex:indexPath.row]];
    cell.shanchu.tag = indexPath.row;
    [cell.shanchu addTarget:self action:@selector(shanchu:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)shanchu:(UIButton *)sender{
    [[[MzzHud alloc] initWithTitle:@"提示" message:@"是否删除已经添加的奖赠内容？" leftButtonTitle:@"取消" rightButtonTitle:@"确认删除" click:^(NSInteger index) {
        if (index == 1) {
            [_list removeObjectAtIndex:sender.tag];
            [_awardTableview reloadData];
            if (_awardCommit) {
                self.awardCommit(_list,YES);
            }
        }
    }]show];
}

@end
