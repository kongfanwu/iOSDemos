//
//  MzzYejihuafenView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/11.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzYejihuafenView.h"
#import "SimulateActionSheet.h"
#import "MzzCustomerRequest.h"
#import "ShareWorkInstance.h"
#import "SLRequest.h"
#import "MzzYangongFenpeiView.h"
#import "FWDSelectView.h"
#import "FWDYeJGuiShuModel.h"
#import "UserManager.h"
#import "RolesTools.h"

@interface MzzYejihuafenView ()<SimulateActionSheetDelegate,UIPickerViewDataSource,UITextFieldDelegate>
//@property (nonatomic ,strong) SimulateActionSheet *sheet;
@property (nonatomic ,strong)NSArray *arrays;

@property (nonatomic ,strong)UIButton *activeBtn;
@property (nonatomic ,strong)MzzStoreList *storeList;
@property (nonatomic ,strong)SLSearchManagerModel *dianzhangList;
@property (nonatomic ,strong)MLJishiSearchModel *yuangongList;
@property (strong, nonatomic)MLJiShiModel * jisModel;
@property (nonatomic ,strong)FWDSelectView * select;

@end

@implementation MzzYejihuafenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(MLJiShiModel *)jisModel
{
    if (!_jisModel) {
        _jisModel = [[MLJiShiModel alloc]init];
    }
    return _jisModel;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    _gonggongyeji.delegate = self;
    _gonggongyeji.keyboardType = UIKeyboardTypeDefault;

//    _arrays = [NSArray array];
    _yuangongArrays = [NSMutableArray array];
    if ([[RolesTools getUserAllRoles]containsObject:@"8"]||[[RolesTools getUserAllRoles]containsObject:@"9"]||[[RolesTools getUserAllRoles]containsObject:@"10"]) {
        self.jisModel.name =[ShareWorkInstance shareInstance].share_data.name;
        self.jisModel.account=[ShareWorkInstance shareInstance].share_data.account;
        self.jisModel.ID=[ShareWorkInstance shareInstance].share_data.ID;
        [_yuangongArrays addObject:self.jisModel];
    }
    [self reloadYuangongList];
    [self mendianguishuList];
}
-(void)setSuperVc:(UIViewController *)superVc{
    _superVc = superVc;
//    _sheet = [SimulateActionSheet styleDefault];
//    _sheet.delegate = self;
    WeakSelf;
    _select = [[FWDSelectView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _select.hidden = YES;
    [_select setFWDSelectViewBlock:^(id obj) {
        if ([obj isKindOfClass:[FWDYeJGuiShuModel class]]) {
            FWDYeJGuiShuModel * yejiguishu = (FWDYeJGuiShuModel *) obj;
            _selectYejiguishu =yejiguishu.showName;
            [weakSelf.activeBtn setTitle:weakSelf.selectYejiguishu forState:UIControlStateNormal];
        }
        if ([obj isKindOfClass:[MzzStoreModel class]]) {
            _selectStoreModel = (MzzStoreModel *)obj;
            [weakSelf.activeBtn setTitle:weakSelf.selectStoreModel.store_name forState:UIControlStateNormal];
            //清除店长归属
            _selectManagerModel = nil;
            [weakSelf.dianzhangguishu setTitle:@"请选择" forState:UIControlStateNormal];
        }
        if ([obj isKindOfClass:[SLManagerModel class]]) {
            _selectManagerModel = (SLManagerModel *)obj;
            [weakSelf.activeBtn setTitle:weakSelf.selectManagerModel.name forState:UIControlStateNormal];
        }
        if ([obj isKindOfClass:[MLJiShiModel class]]) {
            _selectJiShiModel = (MLJiShiModel *)obj;
            BOOL have = NO;
            for (MLJiShiModel *jishiModel in weakSelf.yuangongArrays) {
                if (jishiModel.ID == _selectJiShiModel.ID) {
                    have = YES;
                }
            }
            if (have) {
                [MzzHud toastWithTitle:@"提示" message:@"已添加该技师"];
            }else{

                [weakSelf.yuangongArrays addObject:weakSelf.selectJiShiModel];
                [weakSelf reloadYuangongList];
            }
        }
    }];
    [_superVc.view addSubview:_select];
}
- (IBAction)yejiguishuClick:(UIButton *)sender {
     _activeBtn = sender;
    _select.hidden = NO;
    FWDYeJGuiShuModel * model = [[FWDYeJGuiShuModel alloc]init];
    model.showName = @"售前业绩";
    model.belong = @"1";
    FWDYeJGuiShuModel * model1 = [[FWDYeJGuiShuModel alloc]init];
    model1.showName = @"售中业绩";
    model1.belong = @"2";
    FWDYeJGuiShuModel * model2 = [[FWDYeJGuiShuModel alloc]init];
    model2.showName = @"售后业绩";
    model2.belong = @"3";
     _arrays = [NSArray arrayWithObjects:model,model1,model2, nil];
    [_select setListModel:_arrays];
//    [_sheet.pickerView reloadAllComponents];
//    [_sheet show:self.superVc];
    
}
-(void)mendianguishuList
{
    WeakSelf;
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    if (join_code) {
        [parms setValue:join_code forKey:@"join_code"];
    }
    //门店归属
    [MzzCustomerRequest requestStoreListParams:parms resultBlock:^(MzzStoreList *listModel, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _storeList = listModel;
            for (int i = 0; i< listModel.list.count; i++) {
                MzzStoreModel * model = listModel.list[i];
                if ([model.store_code isEqualToString:_storeCode]) {
                    _selectStoreModel = model;
                }
            }
//            _selectStoreModel = _storeList.list[0];
            [weakSelf.mendianguishu setTitle:_selectStoreModel.store_name forState:UIControlStateNormal];
        }
    }];
}
- (IBAction)dianzhangguishuClick:(UIButton *)sender {
    _activeBtn = sender;
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
   
    if (join_code) {
        [parms setValue:join_code forKey:@"join_code"];
    }
    [parms setValue:_storeList.list[0].store_code forKey:@"store_code"];
    
    //店长
    [SLRequest   requesSearchManagerParams:parms resultBlock:^(SLSearchManagerModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _dianzhangList = model;
            _arrays = _dianzhangList.list;
            [_select setListModel:model];
             _select.hidden = NO;
        }
    }];
}
- (IBAction)yuangongguishuClick:(UIButton *)sender {
    
    _activeBtn = nil;
    LolUserInfoModel *model =  [UserManager getObjectUserDefaults:userLogInInfo];
    NSString * join_code = [ShareWorkInstance shareInstance].join_code;
    NSMutableDictionary *parms = [[NSMutableDictionary alloc]init];
    NSString *store_code = [ShareWorkInstance shareInstance].store_code;
    if (join_code) {
        [parms setValue:join_code forKey:@"join_code"];
    }
    if (store_code) {
        [parms setValue:store_code forKey:@"store_code"];
    }
    NSString * framId = [NSString stringWithFormat:@"%ld",model.data.join_code[0].fram_id];
    [parms setValue:framId?framId:@"" forKey:@"fram_id"];
    //员工
    [SLRequest requesSearchJisParams:parms resultBlock:^(MLJishiSearchModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _yuangongList = model;
            _arrays = _yuangongList.list;
//            [_sheet.pickerView reloadAllComponents];
//            [_sheet show:self.superVc];
            [_select setListModel:model];
            _select.hidden = NO;
        }
    }];
}

-(void)actionCancle{
//    [_sheet dismiss:self.superVc];
//    [_select removeFromSuperview];
//    _select =nil;
    _select.hidden = YES;
}

- (void)reloadYuangongList{
    WeakSelf;
    [_YuangongguishuListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _yuangongguishuHeight.constant = _yuangongArrays.count * 25;
    [self confirmTotalBfb];
    if (_clickJs) {
        self.clickJs(_yuangongArrays.count);
    }
    for (int i = 0; i < _yuangongArrays.count; i++) {
        MLJiShiModel *jishiModel = [_yuangongArrays objectAtIndex:i];
        MzzYangongFenpeiView *yuangongView = [[[NSBundle mainBundle] loadNibNamed:@"MzzYangongFenpeiView" owner:nil options:nil] lastObject];
        yuangongView.tag = i;
        yuangongView.frame = CGRectMake(0,  i * 25, _YuangongguishuListView.frame.size.width, 25);
        [yuangongView setJishiModel:jishiModel];
        [yuangongView setDeleteClick:^(NSInteger index) {
            [_yuangongArrays removeObjectAtIndex:index];
            [weakSelf reloadYuangongList];
        }];
        [yuangongView setValue:^(NSInteger value, MLJiShiModel *jishiModel,UITextField *textField) {
             jishiModel.bfb = textField.text.floatValue;
            [weakSelf confirmTotalBfb];
        }];
        
        [_YuangongguishuListView addSubview:yuangongView];
    }
}

- (void)confirmTotalBfb{
    float totalValue = _gonggongyejiBfb;
    for (int i = 0; i < _yuangongArrays.count; i++) {
        MLJiShiModel *jishiModel = [_yuangongArrays objectAtIndex:i];
        totalValue  += jishiModel.bfb;
    }
    _totalBfb = totalValue;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _arrays.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    id obj = [_arrays objectAtIndex:row];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    if ([obj isKindOfClass:[MzzStoreModel class]]) {
        MzzStoreModel *storeModel = (MzzStoreModel *)obj;
        return storeModel.store_name;
    }
    if ([obj isKindOfClass:[SLManagerModel class]]) {
        SLManagerModel *managerModel = (SLManagerModel *)obj;
        return managerModel.name;
    }
    if ([obj isKindOfClass:[MLJiShiModel class]]) {
        MLJiShiModel *jiShiModel = (MLJiShiModel *)obj;
        return jiShiModel.name;
    }
    return nil;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
   _gonggongyejiBfb = textField.text.floatValue;
    [self confirmTotalBfb];
}
- (IBAction)commint:(UIButton *)sender {
}


//点击确定的回调接口
-(void)actionDone {}
@end
