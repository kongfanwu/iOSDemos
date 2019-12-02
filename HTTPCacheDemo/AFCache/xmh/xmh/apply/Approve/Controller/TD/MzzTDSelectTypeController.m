//
//  MzzTDSelectTypeController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/6.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTDSelectTypeController.h"
#import "DatePickerView.h"
#import "LYSDatePickerController.h"
#import "MzzSelectButtom.h"
@interface MzzTDSelectTypeController ()<LYSDatePickerSelectDelegate>
@property (nonatomic ,strong)MzzSelectButtom *currentBtn;
@property (nonatomic, strong)NSArray *linshiArr;
@property (nonatomic, strong)NSArray *yongjiuArr;
@property (nonatomic ,strong)UILabel *titleLbl;
@property (nonatomic ,strong)UILabel *detailLbl;
@property (nonatomic ,strong)UILabel *subtitle;
//@property (nonatomic ,strong)DatePickerView *dp;
@property (nonatomic ,strong)UIButton *startBtn;
@property (nonatomic ,strong)UIButton *endBtn;
@property (nonatomic ,strong)UIView *centerView;
@property (nonatomic ,assign)BOOL islinshi;
@end

@implementation MzzTDSelectTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _linshiArr = @[@"临时调店",@"调店期间客户在调入店购买和消耗业绩归调入店。",@"顾客数据仍归属调出店，调店期间调出店和调入店都可以查看顾客数据"];
    _yongjiuArr = @[@"永久调店",@"调店后客户在调入店购买和消耗业绩归调入店。",@"顾客数据归属调出店，调店后调入店可以查看顾客数据，调出店不能再查看顾客数据"];
//    [self creatNav];
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"选择调店类型" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self setupUi];
    [self setupDatePicker];
    // Do any additional setup after loading the view.
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"选择调店类型" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setupUi{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, Heigh_Nav + 10, SCREEN_WIDTH, 180)];
    topView.backgroundColor = UIColor.clearColor;
    [self.view addSubview:topView];
    
    UIView *selectBgView = UIView.new;
    selectBgView.backgroundColor = UIColor.whiteColor;
    [selectBgView cornerRadius:5];
    [topView addSubview:selectBgView];
    [selectBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    MzzSelectButtom *linshi = [MzzSelectButtom buttonWithType:UIButtonTypeCustom];
    linshi.tag =0;
    [linshi setTitle:@"临时调店" forState:UIControlStateNormal];
    [linshi setImage:[UIImage imageNamed:@"syspyyzhifuxuanzeweixuan"] forState:UIControlStateNormal];
    [linshi setTitle:@"临时调店" forState:UIControlStateSelected];
    [linshi setImage:[UIImage imageNamed:@"syspyyzhifuxuanze"] forState:UIControlStateSelected];
    [linshi setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [linshi.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [linshi setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
    linshi.frame = CGRectMake(15, 15, 150, 20);
    linshi.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [linshi addTarget:self action:@selector(linshiOnclick:) forControlEvents:UIControlEventTouchUpInside];
//    _currentBtn = linshi;
//    _islinshi = YES;
//    [_currentBtn setSelected:YES];
    [selectBgView addSubview:linshi];
    linshi.hidden = YES;
    
    MzzSelectButtom *yongjiu = [MzzSelectButtom buttonWithType:UIButtonTypeCustom];
    yongjiu.tag =1;
    [yongjiu setTitle:@"永久调店" forState:UIControlStateNormal];
    [yongjiu setImage:[UIImage imageNamed:@"syspyyzhifuxuanzeweixuan"] forState:UIControlStateNormal];
    [yongjiu setTitle:@"永久调店" forState:UIControlStateSelected];
    [yongjiu setImage:[UIImage imageNamed:@"syspyyzhifuxuanze"] forState:UIControlStateSelected];
    [yongjiu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [yongjiu.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [yongjiu setTitleColor:kLabelText_Commen_Color_3 forState:UIControlStateNormal];
//    yongjiu.frame = CGRectMake(SCREEN_WIDTH/2, 15, 150, 20);
    yongjiu.frame = CGRectMake(15, 15, 150, 20);
    yongjiu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [yongjiu addTarget:self action:@selector(yongjiuOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [selectBgView addSubview:yongjiu];
    
    
    _currentBtn = yongjiu;
    _islinshi = NO;
    [_currentBtn setSelected:YES];

    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(yongjiu.frame) + 10, SCREEN_WIDTH, Separator_Line_Height)];
    line.backgroundColor = Separator_LineColor;
    [selectBgView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(Separator_Line_Height);
        make.left.right.bottom.equalTo(selectBgView);
    }];
    line.hidden = YES;
    
    UIView *detailBgView = UIView.new;
    detailBgView.backgroundColor = UIColor.whiteColor;
    [detailBgView cornerRadius:5];
    [topView addSubview:detailBgView];
    [detailBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(selectBgView.mas_bottom).offset(10);
        make.left.right.equalTo(selectBgView);
        make.height.mas_equalTo(120);
    }];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
    titleLbl.textColor = kColor3;
    [titleLbl setFont:[UIFont systemFontOfSize:14]];
    _titleLbl = titleLbl;
    [detailBgView addSubview:titleLbl];
    
    UILabel *detailLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLbl.frame) + 10, SCREEN_WIDTH - 40, 20)];
    [detailLbl setTextColor:kLabelText_Commen_Color_6];
    _detailLbl = detailLbl;
    [detailLbl setFont:[UIFont systemFontOfSize:13]];
    [detailBgView addSubview:detailLbl];
    
    UILabel *subtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(detailLbl.frame) , SCREEN_WIDTH - 40, 40)];
    subtitle.numberOfLines = 2;
     [subtitle setTextColor:kLabelText_Commen_Color_6];
    _subtitle = subtitle;
     [subtitle setFont:[UIFont systemFontOfSize:13]];
    [detailBgView addSubview:subtitle];
    if (_currentBtn == linshi) {
         [titleLbl setText:_linshiArr[0]];
         [detailLbl setText:_linshiArr[1]];
         [subtitle setText:_linshiArr[2]];
    }else{
        [titleLbl setText:_yongjiuArr[0]];
        [detailLbl setText:_yongjiuArr[1]];
        [subtitle setText:_yongjiuArr[2]];
    }
    
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(topView.frame) + 10, SCREEN_WIDTH - 20, 120 - 40)];
    _centerView = centerView;
    centerView.clipsToBounds = YES;
    [centerView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:centerView];
    [centerView cornerRadius:5];
    
    UILabel *dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    [dateLbl setText:@"设置调店时间"];
    dateLbl.textColor = kColor6;
    dateLbl.font = [UIFont systemFontOfSize:14];
    [centerView addSubview:dateLbl];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, dateLbl.bottom + 10 , SCREEN_WIDTH, Separator_Line_Height)];
    line3.backgroundColor = kSeparatorLineColor;
    [centerView addSubview:line3];
    
    UILabel *startDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 20)];
    [startDateLbl setText:@"调店开始时间"];
    [startDateLbl setFont:[UIFont systemFontOfSize:14]];
    [centerView addSubview:startDateLbl];
    startDateLbl.textColor = kColor6;
    
    UILabel *endDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 20)];
    [endDateLbl setText:@"调店结束时间"];
    [endDateLbl setFont:[UIFont systemFontOfSize:14]];
    [centerView addSubview:endDateLbl];
    endDateLbl.textColor = kColor6;
    endDateLbl.hidden = YES;
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, (CGRectGetMinY(endDateLbl.frame) -CGRectGetMaxY(startDateLbl.frame))/2 +CGRectGetMaxY(startDateLbl.frame) , SCREEN_WIDTH, Separator_Line_Height)];
    line2.backgroundColor = kSeparatorLineColor;
    [centerView addSubview:line2];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(centerView.width - 10  - 150, 50, 150, 20);
    startBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [startBtn setTitle:@"选择时间 " forState:UIControlStateNormal];
    [startBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [startBtn addTarget:self action:@selector(dateOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [startBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    startBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft; // 左右翻转
    startBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; // 内容靠右
    startBtn.titleLabel.textAlignment = NSTextAlignmentLeft; // 靠左，以显示label后边的空格间距
    [startBtn setImage:UIImageName(@"shouye-xiaojiantou-min") forState:UIControlStateNormal];
    _startBtn = startBtn;
    [centerView addSubview:startBtn];
//    UIImageView *startImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(startBtn.frame)+5, 50, 15, 28)];
//    [startImg setImage:[UIImage imageNamed:@"gengduo"]];
//    [centerView addSubview:startImg];
    
    UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     endBtn.frame = CGRectMake(centerView.width - 10  - 150, 90, 150, 20);
    endBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [endBtn setTitle:@"选择时间 ＞" forState:UIControlStateNormal];
    [endBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
     [endBtn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(dateOnclick:) forControlEvents:UIControlEventTouchUpInside];
    _endBtn = endBtn;
    [centerView addSubview:endBtn];
    endBtn.hidden = YES;
//    UIImageView *endImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(endBtn.frame)+5, 90, 15, 28)];
//    [endImg setImage:[UIImage imageNamed:@"gengduo"]];
//    [centerView addSubview:endImg];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 68, SCREEN_WIDTH, 68)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(68);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(12, 12, bottomView.width - 24, bottomView.height - 24);
    [sureBtn setBackgroundColor:kBtn_Commen_Color];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
    [sureBtn cornerRadius:3];
    
}
- (void)linshiOnclick:(MzzSelectButtom *)btn{
    if (btn.selected) {
        return;
    }
    [_titleLbl setText:_linshiArr[0]];
    [_detailLbl setText:_linshiArr[1]];
    [_subtitle setText:_linshiArr[2]];
    _islinshi = YES;
    [btn setSelected:YES];
    [_currentBtn setSelected:NO];
    _currentBtn = btn;
    _centerView.height = 120;
//    _dp.simple = NO;
    
}
- (void)yongjiuOnclick:(MzzSelectButtom *)btn{
    if (btn.selected) {
        return;
    }
    [_titleLbl setText:_yongjiuArr[0]];
    [_detailLbl setText:_yongjiuArr[1]];
    [_subtitle setText:_yongjiuArr[2]];
    _islinshi = NO;
    [btn setSelected:YES];
    [_currentBtn setSelected:NO];
    _currentBtn = btn;
    _centerView.height = 80;
//     _dp.simple = YES;
}

- (void)setupDatePicker{
    DatePickerView *dp = [[DatePickerView alloc] init];
    dp.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    _dp = dp;
    //    [dp.btnCancel addTarget:self action:@selector(btnCancel) forControlEvents:UIControlEventTouchUpInside];
    //    [dp.btnSure addTarget:self action:@selector(btnSure) forControlEvents:UIControlEventTouchUpInside];
    dp.DatePickerViewBlcok = ^(NSString *start, NSString *end) {
        [_startBtn setTitle:start forState:UIControlStateNormal];
        [_startBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_endBtn setTitle:end forState:UIControlStateNormal];
        [_endBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_endBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    };
    [self.view addSubview:dp];
    [dp hidenDatePickerView];
}
- (void)dateOnclick:(UIButton *)sender{
//    if (_dp) {
//        [_dp showDatePickerView];
//    }
    
    [LYSDatePickerController alertDatePickerInWindowRootVC];
    [LYSDatePickerController customPickerDelegate:self];
    [LYSDatePickerController customdidSelectDatePicker:^(NSDate *date) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *currentDate = [dateFormat stringFromDate:date];
        if (sender == _startBtn) {
            [_startBtn setTitle:currentDate forState:UIControlStateNormal];
            [_startBtn setImage:nil forState:UIControlStateNormal];
        }
        if (sender == _endBtn) {
            [_endBtn setTitle:currentDate forState:UIControlStateNormal];
        }
    }];
}

- (void)sure{
    if (_sureOnclick) {
        self.sureOnclick(_islinshi, _startBtn.currentTitle, _endBtn.currentTitle);
    }
    [self.navigationController popViewControllerAnimated:NO];
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
