//
//  CommonHeaderView.m
//  xmh
//
//  Created by ald_ios on 2018/10/15.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CommonHeaderView.h"
#import "LDatePickView.h"
#import "organizationalStructureView.h"
#import "ShareWorkInstance.h"
#define kCommonHeaderViewMargin 40
@interface CommonHeaderView ()
@property (nonatomic, strong)LDatePickView * datePickView;
@property (nonatomic, strong)organizationalStructureView * organzieView;
@property (nonatomic, strong)NSArray * titleArr;
@property (nonatomic, strong)COrganizeModel * organizeModel;
@property (nonatomic, strong)NSString * module;
@end
@implementation CommonHeaderView
{
    UISegmentedControl * _segment;
    BOOL _isShow; //层级按钮是否显示
    BOOL _isHaveOrganizeData;
    BOOL _isFirst;
}
- (instancetype)initWithFrame:(CGRect)frame module:(NSString *)module
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _module = module;
        _isFirst = YES;
        _organizeModel = [[COrganizeModel alloc] init];
        [self addSubview:self.datePickView];
        [self addSubview:self.organzieView];
        
    }
    return self;
}
- (LDatePickView *)datePickView
{
    WeakSelf
    if (!_datePickView) {
        _datePickView = [[LDatePickView alloc] initWithFrame:CGRectMake(15, 0, (SCREEN_WIDTH - kCommonHeaderViewMargin)*3/7 , 34) dateBlock:^(NSString *start, NSString *end) {
            [_organizeModel updateModelWithStartTime:start endTime:end];
            if (_isHaveOrganizeData) {//判断组织架构是否含有数据
                [weakSelf createSegmentControl];
//                if (_CommonHeaderViewBlock) {
//                    _CommonHeaderViewBlock(_organizeModel,YES);
//                }
            }
        }];
        _datePickView.backgroundColor = [UIColor whiteColor];
    }
    return _datePickView;
}
- (organizationalStructureView *)organzieView
{
    WeakSelf
    if (!_organzieView) {
        _organzieView = [[organizationalStructureView alloc]initWithFrame:CGRectMake(_datePickView.right + 10, _datePickView.top, (SCREEN_WIDTH - kCommonHeaderViewMargin)*4/7, 34)];
        _organzieView.organizationalStructureViewBlock = ^(NSString *join_code, NSString *oneClick, NSString *twoClick, NSString *twoListId, NSString *inId,NSInteger level,NSInteger main_role,List*listInfo) {
            [weakSelf.organizeModel updateModelWithOneClick:oneClick twoClick:twoClick twoListId:twoListId inId:inId joinCode:join_code level:level mainrole:main_role listInfo:listInfo];
            _isHaveOrganizeData = YES;
            [weakSelf createSegmentControl];
        };
    }
    return _organzieView;
}
- (void)createSegmentControl
{
    [_segment removeFromSuperview];
    _segment = nil;
    _isShow = YES;
    //不同的权限展示的按钮名称
    if (_organizeModel.main_role == 1) {//管理层
        _titleArr = @[@"层级",@"门店",@"员工"];
    }else if(_organizeModel.main_role == 3){
        _titleArr = @[@"门店",@"员工",@"顾客"];
    }else{
        _isShow = NO;
        if ([_module isEqualToString:@"DDGL"] &&_isFirst) {
            NSArray * roles = @[@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
            NSString * mainrole = [NSString stringWithFormat:@"%ld",_organizeModel.main_role];
            if([roles containsObject:mainrole])
            {
                _organizeModel.twoClick = @"all";
                _organizeModel.twoListId = @"-1";
            }
            _isFirst = NO;
        }
        if (_CommonHeaderViewBlock) {
            _CommonHeaderViewBlock(_organizeModel,_isShow);
        }
        return;
    }
    _segment = [[UISegmentedControl alloc] initWithItems:_titleArr];
    [_segment addTarget:self action:@selector(valueTap:) forControlEvents:UIControlEventValueChanged];
//    if ([_module isEqualToString:@"DDGL"] && (_organizeModel.main_role ==4 ||_organizeModel.main_role ==5 ||_organizeModel.main_role ==6 ||_organizeModel.main_role ==7) ) {
//        _segment.selectedSegmentIndex = _titleArr.count - 1;
//    }else if ([_module isEqualToString:@"GKGL"] && _organizeModel.main_role ==7) {
//        _segment.selectedSegmentIndex = _titleArr.count - 1;
//    }else{
//        _segment.selectedSegmentIndex = 0;
//    }
    //tangyifeng -- begin
        if ([_module isEqualToString:@"DDGL"]) {
            NSArray * roles = @[@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
            NSString * mainrole = [NSString stringWithFormat:@"%ld",_organizeModel.main_role];
             if([roles containsObject:mainrole])
             {
                _organizeModel.twoClick = @"all";
                _organizeModel.twoListId = @"-1";
                 if (_CommonHeaderViewBlock) {
                     _CommonHeaderViewBlock(_organizeModel,_isShow);
                 }
            }
        }
  //tangyifeng --end
    _segment.selectedSegmentIndex = 0;
    _segment.height = 25;
    _segment.top = _datePickView.bottom + 26;
    if (_titleArr.count ==2) {
        _segment.width = 180;
    }
    if (_titleArr.count ==3) {
        _segment.width = 225;
    }
    _segment.centerX = self.width/2;
    _segment.tintColor = kBtn_Commen_Color;
    [_segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: kBtn_Commen_Color} forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [_segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateSelected];
    [self valueTap:_segment];
    [self addSubview:_segment];
//    if (_CommonHeaderViewBlock) {
//        _CommonHeaderViewBlock(_organizeModel,_isShow);
//    }
}
//不同的点击 设定参数
- (void)valueTap:(UISegmentedControl *)segment
{
    COrganizeModel * model = [[COrganizeModel alloc] init];
    [model updateOrganizeModel:_organizeModel];
    NSString * selectTitle = _titleArr[segment.selectedSegmentIndex];
    if ([selectTitle isEqualToString:@"层级"]) {
        model.twoClick = @"all";
        model.twoListId = [self getNextFramIdByFramID:model.twoListId];
    }else if ([selectTitle isEqualToString:@"门店"]){
        model.twoClick = @"all";
        model.twoListId = [self getFramIdBylevel:0];
    }else if ([selectTitle isEqualToString:@"员工"]){
        model.twoClick = @"all";
        model.twoListId = [self getFramIdBylevel:-2];
    }else if ([selectTitle isEqualToString:@"顾客"]){
        model.twoClick = @"all";
        model.twoListId = @"-1";
    }else{
        
    }
    if (_CommonHeaderViewBlock) {
        _CommonHeaderViewBlock(model,_isShow);
    }
}
//用选择的的framId 获取framList 内下一个framId
- (NSString *)getNextFramIdByFramID:(NSString *)framId
{
    NSArray * framList = [ShareWorkInstance shareInstance].share_join_code.fram_list;
    for (int i = 0; i < framList.count; i++) {
        Fram_List * subList = framList[i];
        if (subList.fram_name_id == framId.integerValue) {
            Fram_List * returnSubList = framList[i+1];
            return [NSString stringWithFormat:@"%ld",returnSubList.fram_name_id];
        }
    }
    return @"";
}
//用level 去登陆的framList 内获取对应的 framId
- (NSString *)getFramIdBylevel:(NSInteger)level
{
    NSArray * framList = [ShareWorkInstance shareInstance].share_join_code.fram_list;
    for (int i = 0; i < framList.count; i++) {
        Fram_List * subList = framList[i];
        if (subList.level == level) {
            return [NSString stringWithFormat:@"%ld",subList.fram_name_id];
        }
    }
    return @"";
}
@end
