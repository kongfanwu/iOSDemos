//
//  XMHAwardContentVC.m
//  xmh
//
//  Created by 杜彩艳 on 2019/3/31.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHAwardContentVC.h"
#import "XMHNumberView.h"
#import "XMHAwardContentCell.h"
#import "SASaleListModel.h"
#import "XMHSaleOrderRequest.h"
#import "XMHAwardCollectionVIew.h"

@interface XMHAwardContentVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *awardArr;
@property (nonatomic, strong)NSMutableArray *section0Arr;
@property (nonatomic, strong)XMHNumberView *numberView;
@property (nonatomic, assign)NSInteger mzzAwardCount;//每个奖赠数量
@property (nonatomic, assign)CGFloat mzzAwardTotlePrice;//每个奖赠价值
@property (nonatomic, strong)SaleModel *sectin0Model;
@property (nonatomic, strong)SaleModel *awardModel;
@property (nonatomic, assign) CGFloat setion1CellH;

@property (nonatomic, strong) UIView *typeLine;
@property (nonatomic, strong) UIView *contentLine;
@property (nonatomic, strong) UIView *topLine;

/** NO 赠奖类型  */
@property (nonatomic) BOOL isShowType;
/** NO 赠奖内容  */
@property (nonatomic) BOOL isShowContent;
@end

@implementation XMHAwardContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *headerView = [[UIView alloc]init];//WithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"order_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:closeBtn];
    closeBtn.backgroundColor = [UIColor whiteColor];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));//CGSizeMake(14, 14)
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-kMargin);
        make.bottom.mas_equalTo(headerView.mas_bottom);
    }];
    
    
    self.topLine = [[UIView alloc]init];
    self.topLine.backgroundColor = kSeparatorLineColor;
    self.topLine.hidden = YES;
    self.typeLine = [[UIView alloc]init];
    self.typeLine.backgroundColor = kSeparatorLineColor;
    self.contentLine = [[UIView alloc]init];
    self.contentLine.backgroundColor = kSeparatorLineColor;

    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 69) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.whiteColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 
    // 隐藏UITableViewStyleGrouped上边多余的间隔
    self.tableView.sectionFooterHeight = 0;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
     self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];

    [self.view addSubview:self.tableView];

    [self initValue];
    [self createFooterView];
    
    
}
- (void)initValue
{
    self.dataArr = [NSMutableArray array];
    self.section0Arr = [NSMutableArray array];
    SaleModel *model = [[SaleModel alloc]init];
    model.name = @"项目";
    model.isBaoHan = NO;
    [self.section0Arr safeAddObject:model];
    
    SaleModel *model1 = [[SaleModel alloc]init];
    model1.name = @"产品";
    model1.isBaoHan = NO;
    [self.section0Arr safeAddObject:model1];
    [self.dataArr safeAddObject:self.section0Arr];
   
    self.awardArr = [NSMutableArray array];
    // 添加奖增内容
    [self.dataArr safeAddObject:self.awardArr];
    
    WeakSelf
    self.numberView = [[XMHNumberView alloc]init];
    self.numberView.didChangeBlock = ^(XMHNumberView * _Nonnull numberView) {
        weakSelf.mzzAwardCount = numberView.currentNumber;
        [weakSelf.tableView reloadData];
    };
    self.numberView.currentNumber = 0;
    self.numberView.minNumber = 0;

}
- (void)createFooterView
{
    UIView *footerView = [[UIView alloc]init];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(69);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.right.mas_equalTo(self.view);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = kSeparatorLineColor;
    [footerView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.right.mas_equalTo(footerView);
        make.top.mas_equalTo(footerView.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelbtn.titleLabel.font = [UIFont systemFontOfSize:17];
    cancelbtn .backgroundColor = kColorTheme;
    [cancelbtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cancelbtn.layer.cornerRadius = 4;
    [footerView addSubview:cancelbtn];
    
    UIButton *addbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addbtn setTitle:@"添加" forState:UIControlStateNormal];
    addbtn.titleLabel.font = [UIFont systemFontOfSize:17];
    addbtn .backgroundColor = kColorTheme;
    [addbtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addbtn.layer.cornerRadius = 4;
    [footerView addSubview:addbtn];
    
    CGFloat w = (SCREEN_WIDTH - 45) * 0.5;
    
    [cancelbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(kMargin);
        make.centerY.mas_equalTo(footerView.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(w);
    }];
    
    [addbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(cancelbtn.mas_right).offset(kMargin);
        make.centerY.mas_equalTo(footerView.mas_centerY);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(w);
    }];
    
}
#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (_isShowType) {
            self.typeLine.hidden = YES;
            return 2;
        }else{
             self.typeLine.hidden = NO;
           return 0;
        }
       
    }else if (section == 1){
        if (_isShowContent) {
             self.contentLine.hidden = YES;
            self.topLine.hidden = NO;
            return 1;
        }else{
            self.contentLine.hidden = NO;
             self.topLine.hidden = YES;
            return 0;
        }
    }else{
        return 0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 49;
    }else if (indexPath.section == 1){
        return self.setion1CellH;
    }
    return 0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        XMHAwardContentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[XMHAwardContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XMHAwardContentCellID"];
        }
        SaleModel *model = [self.section0Arr safeObjectAtIndex:indexPath.row];
        if ([self.sectin0Model.name isEqualToString:model.name]) {
            model.isBaoHan =  self.sectin0Model.isBaoHan;
        }else{
            model.isBaoHan = NO;
        }
        WeakSelf
        cell.selectedAwardType = ^(SaleModel *model) {
            weakSelf.numberView.currentNumber = 0;
             weakSelf.sectin0Model = model;
            if (!model.isBaoHan) {
                [weakSelf resetData];
                [weakSelf.awardArr removeAllObjects];
                weakSelf.setion1CellH = 0;
            }else{
                [weakSelf.awardArr removeAllObjects];
                [weakSelf requestData];
            }
            [weakSelf.tableView reloadData];
        };
        [cell refreshCellModel:model];
        
       
        return cell;
    }
    else if (indexPath.section == 1){

        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        XMHAwardCollectionVIew *view = [[XMHAwardCollectionVIew alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.setion1CellH)];
        view.dataArr = self.awardArr;
        view.model = self.awardModel;
        WeakSelf
        view.selectAwardItemModel = ^(SaleModel * _Nonnull model) {
            
            weakSelf.awardModel = model;
            weakSelf.mzzAwardTotlePrice = weakSelf.awardModel.price_list.pro_11.price.integerValue;
            //重置数量
            weakSelf.mzzAwardCount =  weakSelf.numberView.currentNumber = 0;
            
            [weakSelf.tableView reloadData];
        };
        [cell.contentView addSubview:view];
        return cell;
    }

    return UITableViewCell.new;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 49;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    if (section == 0) {
        
        UIButton *sectionTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sectionTitleBtn.tag = section + 100;
        sectionTitleBtn.backgroundColor = UIColor.whiteColor;
        [sectionTitleBtn addTarget:self action:@selector(sectionTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:sectionTitleBtn];
        [sectionTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(headerView);
        }];
        
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"奖赠类型";
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = kLabelText_Commen_Color_3;
        lab.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:lab];
        [lab sizeToFit];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.left.mas_equalTo(kMargin);
            make.centerY.mas_equalTo(headerView.mas_centerY);
        }];
        
        UIImageView *arrow = [[UIImageView alloc]init];//WithFrame:CGRectMake(SCREEN_WIDTH - 30, (49 - 11) * 0.5, 5, 11)];
        
        arrow.image = [UIImage imageNamed:@"gengduo.png"];
        [headerView addSubview:arrow];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(5, 11));
            make.centerY.mas_equalTo(headerView.mas_centerY);
            make.right.mas_equalTo(-kMargin);
        }];
        
       
//        UIView *line = [[UIView alloc]init];
//        line.backgroundColor = kSeparatorLineColor;
        [headerView addSubview:self.typeLine];
        [self.typeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kMargin);
            make.right.mas_equalTo(headerView.mas_right).mas_offset(-kMargin);
            make.bottom.mas_equalTo(headerView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
//        self.typeLine = line;
        
    }else if (section == 1){
 
        
        UIButton *sectionTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sectionTitleBtn.tag = section + 100;
        sectionTitleBtn.backgroundColor = UIColor.whiteColor;
        [sectionTitleBtn addTarget:self action:@selector(sectionTitleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:sectionTitleBtn];
        [sectionTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(headerView);
        }];
        
        
        UIImageView *arrow = [[UIImageView alloc]init];
        arrow.image = [UIImage imageNamed:@"gengduo.png"];
        [headerView addSubview:arrow];
        
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(5, 11));
            make.centerY.mas_equalTo(headerView.mas_centerY);
            make.right.mas_equalTo(-kMargin);
        }];

        [headerView addSubview: self.contentLine];
        [self.contentLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kMargin);
            make.right.mas_equalTo(headerView.mas_right).mas_offset(-kMargin);
            make.bottom.mas_equalTo(headerView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"奖赠内容";
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = kLabelText_Commen_Color_3;
        lab.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:lab];
        [lab sizeToFit];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.left.mas_equalTo(kMargin);
            make.centerY.mas_equalTo(headerView.mas_centerY);
        }];
        
        [headerView addSubview:self.topLine];
        [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kMargin);
            make.right.mas_equalTo(headerView.mas_right).mas_offset(-kMargin);
            make.top.mas_equalTo(headerView.mas_top);
            make.height.mas_equalTo(0.5);
        }];
        //        self.topLine = topLine;
       
        
    }else if (section == 2){
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"奖赠数量";
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = kLabelText_Commen_Color_3;
        lab.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:lab];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = kSeparatorLineColor;
        [headerView addSubview:line];


        [headerView addSubview:self.numberView];
        [self.numberView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(headerView .mas_centerY);
            make.size.mas_equalTo(CGSizeMake(26 * 2 + 40, 30));
            make.right.mas_equalTo(-kMargin);
            
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(kMargin);
            make.right.mas_equalTo(headerView.mas_right).mas_offset(-kMargin);
            make.bottom.mas_equalTo(headerView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.left.mas_equalTo(kMargin);
            make.centerY.mas_equalTo(headerView.mas_centerY);
        }];
    }else if (section == 3){
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"奖赠价值";
        lab.font = [UIFont systemFontOfSize:16];
        lab.textColor = kLabelText_Commen_Color_3;
        lab.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:lab];
        [lab sizeToFit];
        
        UILabel *priceLab = [[UILabel alloc]init];
        
        CGFloat pice =  self.mzzAwardCount * self.mzzAwardTotlePrice;
        priceLab.text = [NSString stringWithFormat:@"￥%.2f",pice];
        priceLab.font = [UIFont systemFontOfSize:16];
        priceLab.textColor = kLabelText_Commen_Color_3;
        priceLab.textAlignment = NSTextAlignmentRight;
        [headerView addSubview:priceLab];
    
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(200);
            make.right.mas_equalTo(-kMargin);
            make.centerY.mas_equalTo(headerView.mas_centerY);
        }];
        
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.left.mas_equalTo(kMargin);
            make.centerY.mas_equalTo(headerView.mas_centerY);
        }];
    }
    
    return headerView;
}



#pragma mark -- request
- (void)requestData
{
    NSString *type = self.sectin0Model.name;
    if ([type isEqualToString:@"产品"]) {
         type = @"goods";
    }else{
         type = @"pro";
    }
    WeakSelf
    [self.awardArr removeAllObjects];
    [XMHSaleOrderRequest requestAwardContentStore_code:_store_code type:type user_id:_user_id resultBlock:^(SASaleListModel * _Nonnull model, BOOL isSuccess, NSDictionary * _Nonnull errorDic) {
        for (int i = 0; i < model.list.count; i++) {
            SaleModel *saleModel = [model.list objectAtIndex:i];
            [saleModel setType:(XMHServiceOrderType)type];
            [weakSelf.awardArr safeAddObject:saleModel];
        }
        [self resetData];
        NSInteger maxNum = 2;//一行显示2个item
        NSInteger row = weakSelf.awardArr.count % maxNum + weakSelf.awardArr.count / maxNum;
        CGFloat itemH = 20 * row + kMargin *(row - 1);
        weakSelf.setion1CellH = itemH + 1;
        [weakSelf.dataArr safeAddObject:weakSelf.awardArr];
        [weakSelf.tableView reloadData];
    }];

}

- (void)resetData{
    self.awardModel = nil;
    self.mzzAwardCount =  self.numberView.currentNumber =0;
    self.mzzAwardTotlePrice = 0;
}
#pragma mark -- event
- (void)sectionTitleBtnClick:(UIButton *)sectionTitleBtn
{
    if (sectionTitleBtn.tag ==100) {
        _isShowType = !_isShowType;
    }else if (sectionTitleBtn.tag == 101){
        _isShowContent = !_isShowContent;
    }
    [self.tableView reloadData];
    
}

- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)closeBtnClick{[self cancelBtnClick];}
- (void)addBtnClick
{
    self.awardModel.mzzAwardTotlePrice =  self.mzzAwardCount * self.mzzAwardTotlePrice;
    self.awardModel.mzzAwardCount = self.mzzAwardCount;
    if (_selectedAward) {
        _selectedAward(self.awardModel);
    }
    [self closeBtnClick];
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
