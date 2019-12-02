//
//  WorkTopView.m
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/9/27.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTopView.h"
#import "WorkTopdataView.h"
#import "WorkModel.h"
@implementation WorkTopView
{
    WorkTopdataView *oneView;
    WorkTopdataView *twoView;
    WorkTopdataView *threeView;
    WorkTopdataView *fourView;
    NSString *oneTitleStrO;
    NSString *oneTitleStrT;
    NSString *twoTitleStrO;
    NSString *twoTitleStrT;
    NSString *ThreeTitleStrO;
    NSString *ThreeTitleStrT;
    NSString *foureTitleStrO;
    NSString *foureTitleStrT;
    
    NSString *txtOneLabelO;
    NSString *txtOneLabelT;
    NSString *txtTwoLabelO;
    NSString *txtTwoLabelT;
    NSString *txtThreeLabelO;
    NSString *txtThreeLabelT;
    NSString *txtFoureLabelO;
    NSString *txtFoureLabelT;
    NSString *txtDayThree;
    NSString *txtMonthThree;
    NSString *txtDayF;
    NSString *txtMonthF;
    NSString *txtDayT;
    NSString *txtMonthT;
    NSString *txtDayO;
    NSString *txtMonthO;
    
    
    NSString *oneImageStr;
    NSString *twoImageStr;
    NSString *threeImageStr;
    NSString *foureImageStr;
    NSInteger roleModel;
    WorkHeardManagerModel *dataModel;
}
-(void)initWithUi
{
    if (roleModel == 7) {
        oneTitleStrO = @"今日业绩（元）";
        oneTitleStrT = @"月累计业绩（元）";
        twoTitleStrO = @"今日消耗（元）";
        twoTitleStrT = @"月累计消耗（元）";
        ThreeTitleStrO = @"今日总欠款顾客数（人）";
        ThreeTitleStrT = @"月累计总欠款顾客数（人）";
        foureTitleStrO = @"今日应收款（元）";
        foureTitleStrT = @"总应收款（元）";
        txtOneLabelO = dataModel.ach_d;
        txtOneLabelT = dataModel.ach_m;
        txtTwoLabelO = dataModel.exp_d;
        txtTwoLabelT = dataModel.exp_m;
        txtThreeLabelO = dataModel.debt_d;
        txtThreeLabelT = dataModel.debt_m;
        txtFoureLabelO = dataModel.fund_d;
        txtFoureLabelT = dataModel.fund_m;
        txtDayThree = @"";
        txtMonthThree = @"";
        txtDayF = @"";
        txtMonthF = @"";
        txtDayO = @"";
        txtMonthO = @"";
        txtDayT = @"";
        txtMonthT = @"";
        
    }else if (roleModel == 1||roleModel == 8||roleModel == 10||roleModel == 3){//管理层
        oneTitleStrO = @"今日业绩（元）";
        oneTitleStrT = @"月累计业绩（元）";
        twoTitleStrO = @"今日消耗（元）";
        twoTitleStrT = @"月累计消耗（元）";
        ThreeTitleStrO = @"今日客次(人)";
        ThreeTitleStrT = @"月累计客次（人）";
        foureTitleStrO = @"今日项目数（个）";
        foureTitleStrT = @"月累计项目数（个）";
        
        txtOneLabelO = dataModel.ach_d;
        txtOneLabelT = dataModel.ach_m;
        txtTwoLabelO = dataModel.exp_d;
        txtTwoLabelT = dataModel.exp_m;
        txtThreeLabelO = dataModel.num_d;
        txtThreeLabelT = dataModel.num_m;
        txtFoureLabelO = dataModel.pro_d;
        txtFoureLabelT = dataModel.pro_m;
        txtDayThree = [NSString stringWithFormat:@"%@%@%@",@"标准：",dataModel.num_bz,@"人"];
        txtMonthThree = @"";
        txtDayF = [NSString stringWithFormat:@"%@%@%@",@"标准：",dataModel.pro_bz,@"个"];
        txtMonthF = @"";
        txtDayO = @"";
        txtMonthO = @"";
        txtDayT = @"";
        txtMonthT = @"";
        
    }else if (roleModel == 4){
        oneTitleStrO = @"今日消耗（元）";
        oneTitleStrT = @"月累计消耗（元）";
        twoTitleStrO = @"今日项目（个）";
        twoTitleStrT = @"月累计项目（个）";
        ThreeTitleStrO = @"今日客次(人)";
        ThreeTitleStrT = @"月累计客次（人）";
        foureTitleStrO = @"今日处方规划消耗（元）";
        foureTitleStrT = @"月累计处方规划消耗（元）";
        
        txtOneLabelO = dataModel.exp_d;
        txtOneLabelT = dataModel.exp_m;
        txtTwoLabelO = dataModel.pro_d;
        txtTwoLabelT = dataModel.pro_m;
        txtThreeLabelO = dataModel.num_d;
        txtThreeLabelT = dataModel.num_m;
        txtFoureLabelO = dataModel.con_d;
        txtFoureLabelT = dataModel.con_m;
        txtDayO = @"";
        txtMonthO = @"";
        txtDayT = [NSString stringWithFormat:@"%@%@%@",@"标准：",dataModel.pro_bz,@"个"];
        txtMonthT = @"";
        txtDayThree = [NSString stringWithFormat:@"%@%@%@",@"标准：",dataModel.num_bz,@"人"];
        txtMonthThree = @"";
        txtDayF = @"";
        txtMonthF = @"";
        
    }else if (roleModel == 5){//销售店长
        oneTitleStrO = @"今日预约（个）";
        oneTitleStrT = @"月累计预约（个）";
        twoTitleStrO = @"今日客次（人）";
        twoTitleStrT = @"月累计客次（人）";
        ThreeTitleStrO = @"今日业绩（元）";
        ThreeTitleStrT = @"月累计业绩（元）";
        foureTitleStrO = @"今日项目（个）";
        foureTitleStrT = @"月累计项目（个）";
        
        txtOneLabelO = dataModel.app_d;
        txtOneLabelT = dataModel.app_m;
        txtTwoLabelO = dataModel.num_d;
        txtTwoLabelT = dataModel.num_m;
        txtThreeLabelO = dataModel.ach_d;
        txtThreeLabelT = dataModel.ach_m;
        txtFoureLabelO = dataModel.pro_d;
        txtFoureLabelT = dataModel.pro_m;
        txtDayO = [NSString stringWithFormat:@"%@%@%@",@"标准",dataModel.appo_bz,@"人"];
        txtMonthO = @"";
        txtDayT = [NSString stringWithFormat:@"%@%@%@",@"标准",dataModel.num_bz,@"人"];
        txtMonthT = @"";
        txtDayThree = @"";
        txtMonthThree = @"";
        txtDayF = [NSString stringWithFormat:@"%@%@%@",@"标准",dataModel.pro_bz,@"个"];
        txtMonthF = @"";
        
    }else if (roleModel == 6){
        oneTitleStrO = @"今日拓客人数（人）";
        oneTitleStrT = @"月累计拓客人数（人）";
        twoTitleStrO = @"今日转化人数（人）";
        twoTitleStrT = @"月累计转化人数（人）";
        ThreeTitleStrO = @"今日业绩（元）";
        ThreeTitleStrT = @"月累计业绩（元）";
        foureTitleStrO = @"今日成交人数（人）";
        foureTitleStrT = @"月累计成交人数（人）";
        
        txtOneLabelO = dataModel.tok_d;
        txtOneLabelT = dataModel.tok_m;
        txtTwoLabelO = dataModel.con_d;
        txtTwoLabelT = dataModel.con_m;
        txtThreeLabelO = dataModel.ach_d;
        txtThreeLabelT = dataModel.ach_m;
        txtFoureLabelO = dataModel.dea_d;
        txtFoureLabelT = dataModel.dea_m;
        txtDayO = [NSString stringWithFormat:@"%@%@%@",@"标准",dataModel.tok_bz,@"人"];
        txtMonthO = @"";
        txtDayT = @"";
        txtMonthT = @"";
        txtDayThree = @"";
        txtMonthThree = @"";
        txtDayF = [NSString stringWithFormat:@"%@%@%@",@"标准",dataModel.dea_bz,@"个"];
        txtMonthF = @"";
        
    }else if (roleModel == 9){
        oneTitleStrO = @"今日业绩（元）";
        oneTitleStrT = @"月累计业绩（元）";
        twoTitleStrO = @"今日预约（个）";
        twoTitleStrT = @"月累计预约（个）";
        ThreeTitleStrO = @"今日客次(人)";
        ThreeTitleStrT = @"月累计客次（人）";
        foureTitleStrO = @"今日项目数（个）";
        foureTitleStrT = @"月累计项目数（个）";
        
        txtOneLabelO = dataModel.ach_d;
        txtOneLabelT = dataModel.ach_m;
        txtTwoLabelO = dataModel.app_d;
        txtTwoLabelT = dataModel.app_m;
        txtThreeLabelO = dataModel.num_d;
        txtThreeLabelT = dataModel.num_m;
        txtFoureLabelO = dataModel.pro_d;
        txtFoureLabelT = dataModel.pro_m;
        txtDayO = @"";
        txtMonthO = @"";
        txtDayT = [NSString stringWithFormat:@"%@%@%@",@"标准",dataModel.appo_bz,@"个"];
        txtMonthT = @"";
        txtDayThree = [NSString stringWithFormat:@"%@%@%@",@"标准",dataModel.num_bz,@"人"];
        txtMonthThree = @"";
        txtDayF = [NSString stringWithFormat:@"%@%@%@",@"标准",dataModel.pro_bz,@"个"];
        txtMonthF = @"";
    }
    
    if (roleModel == 1 || roleModel == 3||roleModel == 8||roleModel == 10) {
        oneImageStr = @"huigongzuo_ye_ji";
        twoImageStr = @"huigongzuo_xiaohao";
        threeImageStr = @"huigongzuo_keci";
        foureImageStr = @"huigongzuo_xiangmushu";
    }else if (roleModel == 4){
        oneImageStr = @"huigongzuo_xiaohao";
        twoImageStr = @"huigongzuo_xiangmushu";
        threeImageStr = @"huigongzuo_keci";
        foureImageStr = @"jishudianzhang_jinrichufangguihuaxiaohao";
    }else if (roleModel == 5){
        oneImageStr = @"kuaijierukou_yijianyuyue";
        twoImageStr = @"huigongzuo_keci";
        threeImageStr = @"huigongzuo_ye_ji";
        foureImageStr = @"huigongzuo_xiangmushu";
    }else if (roleModel == 6){
        oneImageStr = @"huigongzuo_tuoke";
        twoImageStr = @"huigongzuo_zhuanhua";
        threeImageStr = @"huigongzuo_ye_ji";
        foureImageStr = @"huigongzuo_chengjiao";
    }else if (roleModel == 7){
        oneImageStr = @"huigongzuo_ye_ji";
        twoImageStr = @"huigongzuo_xiaohao";
        threeImageStr = @"huigongzuo_keci";
        foureImageStr = @"qiantai_jinriyingshou";
    }else if (roleModel == 9){
        oneImageStr = @"huigongzuo_ye_ji";
        twoImageStr = @"kuaijierukou_yijianyuyue";
        threeImageStr = @"huigongzuo_keci";
        foureImageStr = @"huigongzuo_xiangmushu";
    }
   
}
- (instancetype)initWithFrame:(CGRect)frame withMessageArray:(WorkHeardManagerModel *)model andRole:(NSInteger)role
{
    self = [super initWithFrame:frame];
    if (self) {
        roleModel = role;
        dataModel = model;
        [self initWithUi];
        oneView = [[WorkTopdataView alloc]initWithDataFram:CGRectMake(0, 0,325, 75) withTitleOne:oneTitleStrO anOneTxt:txtOneLabelO withTitleTwo:oneTitleStrT andTwoText:txtOneLabelT andRole:roleModel andImage:oneImageStr withDayBiaoZhu:txtDayO andMonthBiaoZhu:txtMonthO];
        
        twoView = [[WorkTopdataView alloc] initWithDataFram:CGRectMake(0, 30,325, 75)withTitleOne:twoTitleStrO anOneTxt:txtTwoLabelO withTitleTwo:twoTitleStrT andTwoText:txtTwoLabelT andRole:roleModel andImage:twoImageStr withDayBiaoZhu:txtDayT andMonthBiaoZhu:txtMonthT];
        
        threeView = [[WorkTopdataView alloc] initWithDataFram:CGRectMake(0, 60,325, 75)withTitleOne:ThreeTitleStrO anOneTxt:txtThreeLabelO withTitleTwo:ThreeTitleStrT andTwoText:txtThreeLabelT andRole:roleModel andImage:threeImageStr withDayBiaoZhu:txtDayThree andMonthBiaoZhu:txtMonthThree];
        
        fourView = [[WorkTopdataView alloc] initWithDataFram:CGRectMake(0, 90,325, 75)withTitleOne:foureTitleStrO anOneTxt:txtFoureLabelO withTitleTwo:foureTitleStrT andTwoText:txtFoureLabelT andRole:roleModel andImage:foureImageStr withDayBiaoZhu:txtDayF andMonthBiaoZhu:txtMonthF];
        [self addSubview:oneView];
        [self addSubview:twoView];
        [self addSubview:threeView];
        [self addSubview:fourView];
        [self updateLoad:frame withNum:2 withModel:model andRole:role];
    }
    return self;
}
-(void)updateLoad:(CGRect)frame withNum:(NSInteger)num withModel:(WorkHeardManagerModel *)model andRole:(NSInteger)role
{
    self.frame = frame;
    roleModel = role;
    dataModel = model;
    oneView.hidden = NO;
    twoView.hidden = NO;
    if (num == 2) {
        threeView.hidden = YES;
        fourView.hidden = YES;
    }else{
        threeView.hidden = NO;
        fourView.hidden = NO;
    }
    [self initWithUi];
    [oneView updateViewOnetext:txtOneLabelO andTwoText:txtOneLabelT wihtDay:txtDayO andMonth:txtMonthO];
    [twoView updateViewOnetext:txtTwoLabelO andTwoText:txtTwoLabelT wihtDay:txtDayT andMonth:txtMonthT];
    [threeView updateViewOnetext:txtThreeLabelO andTwoText:txtThreeLabelT wihtDay:txtDayThree andMonth:txtMonthThree];
    [fourView updateViewOnetext:txtFoureLabelO andTwoText:txtFoureLabelT wihtDay:txtDayF andMonth:txtMonthF];
}
@end
