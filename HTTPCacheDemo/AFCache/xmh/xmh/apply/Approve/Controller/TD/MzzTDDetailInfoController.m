//
//  MzzTDDetailInfoController.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/2/5.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "MzzTDDetailInfoController.h"
#import "MzzTDIconView.h"
#import <YYWebImage/YYWebImage.h>
#import "SPSearchStoreUserModel.h"
#import "ShareWorkInstance.h"
#import "SPRequest.h"
#import "SPGetTdPersonModel.h"
#import "MzzTDSelectStoreController.h"
#import "SPGetStoresModel.h"
#import "MzzTDSelectTypeController.h"
#import "UserManager.h"
#import "ApproveController.h"
#import "MzzSelectApprovalController.h"
#import "BaseModel.h"
#import "UITextView+XMHPlaceholder.h"

@interface MzzTDDetailInfoController ()<UITextViewDelegate>
@property (nonatomic ,strong)UIView *bottomView;
@property (nonatomic ,strong)SPChangeStoreModel *model;
@property (nonatomic ,strong)SPGetTdPersonModel *spModel;
@property (nonatomic ,strong)SPStoresModel *selectStoreModel;
@property (nonatomic ,strong)UIView *spView;
@property (nonatomic ,strong)UIButton *selectBtn;
@property (nonatomic ,strong)UIButton *typeBtn;
@property (nonatomic ,strong)NSMutableDictionary *params;
@property (nonatomic ,strong)MzzTDIconView *spIconView;
@property (nonatomic ,strong)UIView *customerView;
@property (nonatomic ,strong)UIView *titleView;
@property (nonatomic ,strong)SPPersonModel *selectPersonModel;
@property (nonatomic ,copy)NSString *outcode;
@end

@implementation MzzTDDetailInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self creatNav];
    self.view.backgroundColor = kBackgroundColor;
    [self.navView setNavViewTitle:@"会员调店审批" backBtnShow:YES];
    self.navView.backgroundColor = kBtn_Commen_Color;
    
    [self creatRequestData];
}
- (void)creatNav{
    customNav *nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"会员调店审批" withleftImageStr:@"back" withRightStr:nil];
    [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nav];
}
- (void)creatRequestData{
    _params = [NSMutableDictionary dictionary];
}
- (void)pop{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupOutCode:(NSString *)outcode{
    _outcode = outcode;
}
- (void)setupData:(SPChangeStoreModel *)data {
    _model = data;
    [self setupUI];
}
- (void)requestData{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    params[@"store_code"] = _selectStoreModel.code;
    [SPRequest requestgetTdPersonParams:params resultBlock:^(SPGetTdPersonModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        _spModel = model;
        [self setupSPUI:model];
    }];
    
}
- (void)setupSPUI:(SPGetTdPersonModel*)model{
    [_spIconView removeFromSuperview];
    _selectPersonModel = nil;
    MzzTDIconView *View = [[[NSBundle mainBundle] loadNibNamed:@"MzzTDIconVIew" owner:nil options:nil] lastObject];
    [View.iconImg cornerRadius:45 / 2.f];
    _spIconView = View;
    [_spIconView.nameLbl setTextColor:kLabelText_Commen_Color_9];
    if (model.approvalPerson.count ==1) {
        _selectPersonModel = model.approvalPerson.firstObject;
        [View.iconImg yy_setImageWithURL:[NSURL URLWithString:model.approvalPerson.firstObject.head_img] placeholder:kDefaultJisImage];
        [View.nameLbl setText:model.approvalPerson.firstObject.name];
        
    }else if ((model.approvalPerson.count > 1)){
        [View.iconImg setImage:[UIImage imageNamed:@"stspyytajiantupian"]];
        [View.nameLbl setText:@""];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spOnclick:)];
        [View addGestureRecognizer:tap];
       
    }else{
        [View.iconImg setImage:nil];
        [View.nameLbl setText:@""];
    }
    View.frame = CGRectMake(10, 40, 45, 70);
    [_spView addSubview:View];
}

- (void)spOnclick:(UITapGestureRecognizer *)sender{
    MzzSelectApprovalController * next = [[MzzSelectApprovalController alloc] init];
    [next setApprocePersonList:_spModel.approvalPerson];
    next.LSelectApprovalControllerBlock = ^(SPPersonModel *model) {
        _selectPersonModel = model;
       [_spIconView.iconImg yy_setImageWithURL:[NSURL URLWithString:model.head_img] placeholder:kDefaultJisImage];
        [_spIconView.nameLbl setText:model.name];
    };
    [self.navigationController pushViewController:next animated:NO];
}
- (void)setupUI{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 68, SCREEN_WIDTH, 68)];
    _bottomView = bottomView;
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(68);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(12, 12, bottomView.width - 24, bottomView.height - 24);
    [sureBtn setBackgroundColor:kBtn_Commen_Color];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sureBtn];
    [sureBtn cornerRadius:3];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Heigh_Nav, SCREEN_WIDTH, kNavContentHeight - bottomView.height)];
//    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    scrollView.backgroundColor = kColorF5F5F5;
    [self.view addSubview:scrollView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 110)];
    _titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
    [titleView cornerRadius:5];
    
    [scrollView addSubview:titleView];
    
    UILabel *codeLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, 20)];
    [codeLbl setText:[NSString stringWithFormat:@"审批编号：%@",_model.code]];
    [titleView addSubview:codeLbl];

    codeLbl.font = FONT_SIZE(14);
    codeLbl.textColor = kColor6;
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(codeLbl.frame) +10, SCREEN_WIDTH, Separator_Line_Height)];
    [line setBackgroundColor:[ColorTools colorWithHexString:@"e5e5e5"]];
    [titleView addSubview:line];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame) +10, SCREEN_WIDTH, 20)];
    [name setTextColor:kLabelText_Commen_Color_6];
    [name setText:[NSString stringWithFormat:@"品牌名称：%@",_model.join_name]];
    name.font = FONT_SIZE(14);
    name.textColor = kColor9;
    [titleView addSubview:name];
    
    UILabel *initiator = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(name.frame) +10, SCREEN_WIDTH, 20)];
    initiator.font = name.font;
    initiator.textColor = name.textColor;
    [initiator setText:[NSString stringWithFormat:@"审批发起人：%@", _model.initiator]];
    [titleView addSubview:initiator];
    if (!_model.user) {
//调入门店
        UILabel *customerName = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(initiator.frame) +10, SCREEN_WIDTH, 20)];
        [customerName setTextColor:kLabelText_Commen_Color_9];
        customerName.font = [UIFont systemFontOfSize:14];
        [customerName setText:[NSString stringWithFormat:@"顾客名称：%@", _model.name]];
        [titleView addSubview:customerName];
        
        UILabel *mobile = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(customerName.frame) +10, SCREEN_WIDTH, 20)];
        [mobile setTextColor:kLabelText_Commen_Color_9];
        mobile.font = [UIFont systemFontOfSize:14];
        [mobile setText:[NSString stringWithFormat:@"手机：%@", _model.mobile]];
        [titleView addSubview:mobile];
        
        UILabel *mdname = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(mobile.frame) +10, SCREEN_WIDTH, 20)];
        [mdname setTextColor:kLabelText_Commen_Color_9];
        mdname.font = [UIFont systemFontOfSize:14];
        [mdname setText:[NSString stringWithFormat:@"所属门店：%@", _model.mdname]];
        [titleView addSubview:mdname];
        
        UILabel *js_name = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(mdname.frame) +10, SCREEN_WIDTH, 20)];
        [js_name setTextColor:kLabelText_Commen_Color_9];
        js_name.font = [UIFont systemFontOfSize:14];
        [js_name setText:[NSString stringWithFormat:@"所属技师：%@", _model.jis_name]];
        [titleView addSubview:js_name];
        
        titleView.height = 235;
    }
    if (_model.user) {
        CGFloat ccH = (_model.user.count % 5) ? 80.f : 0;
        CGFloat cH = (_model.user.count / 5) * 80.f ;
        CGFloat customerH = 40.f + cH + ccH + 10;
        UIView *customerView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleView.frame) + 10, scrollView.width - 20, customerH)];
        [customerView setBackgroundColor:[UIColor whiteColor]];
        [scrollView addSubview:customerView];
        _customerView = customerView;
        [customerView cornerRadius:5];
        
        UILabel *nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, 20)];
        [nameLbl setText:@"调店顾客"];
        [customerView addSubview:nameLbl];
        
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLbl.frame) + 10, SCREEN_WIDTH, Separator_Line_Height)];
        [line setBackgroundColor:[ColorTools colorWithHexString:@"e5e5e5"]];
        [customerView addSubview:line];
        
        [self setupStatistics:customerView];
        nameLbl.font = FONT_SIZE(14);
        nameLbl.textColor = kColor6;
    }
    
    CGFloat setViewY;
    if (_customerView) {
        setViewY = _customerView.bottom + 10 ;
    }else{
        setViewY = _titleView.bottom + 10;
    }
    UIView *setView = [[UIView alloc] initWithFrame:CGRectMake(10, setViewY, scrollView.width - 20, 160)];
    setView.backgroundColor = [UIColor whiteColor];
    [setView cornerRadius:5];
    [scrollView addSubview:setView];
    NSArray *titleArr = @[@"调店设置",@"调出门店",@"调至门店",@"调店类型"];
//    NSArray *detailArr = @[@"",_model.outStore?_model.outStore:@"",@"选择门店 ＞",@"选择调店类型 ＞"];
    NSArray *detailArr = @[@"",_model.outStore?_model.outStore:@"",@"选择门店 ",@"选择调店类型 "];
    for (int i = 0; i<4; i++) {
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, i * 40, SCREEN_WIDTH, kSeparatorHeight)];
        [line setBackgroundColor:[ColorTools colorWithHexString:@"e5e5e5"]];
        [setView addSubview:line];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 +i * 40, 100, 20)];
        [title setTextAlignment:NSTextAlignmentLeft];
        [title setText: [titleArr objectAtIndex:i]];
        title.font = FONT_SIZE(14);
        title.textColor = kColor6;
        [setView addSubview:title];
        
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailBtn.frame = CGRectMake(setView.width - 150 - 10, 10 +i * 40, 150, 20);
        detailBtn.tag = i;
        [detailBtn setTitle:[detailArr objectAtIndex:i] forState:UIControlStateNormal];
        [detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        detailBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [setView addSubview:detailBtn];
        [detailBtn addTarget:self action:@selector(detailBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 2 || i == 3) {
            detailBtn.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft; // 左右翻转
            detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; // 内容靠右
            detailBtn.titleLabel.textAlignment = NSTextAlignmentLeft; // 靠左，以显示label后边的空格间距
            [detailBtn setImage:UIImageName(@"shouye-xiaojiantou-min") forState:UIControlStateNormal];
//            detailBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        }
        
//        self.dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_dateButton setTitle:@"请选择时间 " forState:UIControlStateNormal];
//        [_dateButton setTitleColor:kColor9 forState:UIControlStateNormal];
//        [_dateButton setImage:UIImageName(@"shouye-xiaojiantou-min") forState:UIControlStateNormal];
//        _dateButton.titleLabel.font = FONT_SIZE(14);
//        _dateButton.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft; // 左右翻转
//        _dateButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; // 内容靠右
//        _dateButton.titleLabel.textAlignment = NSTextAlignmentLeft; // 靠左，以显示label后边的空格间距
//        _dateButton.titleLabel.adjustsFontSizeToFitWidth = YES;
//        [_dateButton addTarget:self action:@selector(selectDateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_dateBgView addSubview:_dateButton];
//        [_dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(dateLogoImageView.mas_right);
//            make.top.bottom.equalTo(_dateBgView);
//            make.right.mas_equalTo(-5);
//        }];
        
        if (i ==2) {
            _selectBtn = detailBtn;
            [_selectBtn setTitleColor:kColorC forState:UIControlStateNormal];
        }
        if (i ==3) {
            _typeBtn = detailBtn;
            [_typeBtn setTitleColor:kColorC forState:UIControlStateNormal];
        }
    }
 
    UIView *resonView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(setView.frame)+10, scrollView.width - 20, 55)];
    resonView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:resonView];
    [resonView cornerRadius:5];
    
    UILabel *resonLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 7.8, 100, 20)];
    [resonLbl setText:@"调店原因:"];
    [resonView addSubview:resonLbl];
    resonLbl.font = FONT_SIZE(14);
    resonLbl.textColor = kColor6;
    [resonLbl sizeToFit];
//    CGFloat resonLblY = (resonView.height - resonLbl.height) / 2.f;
//    resonLbl.top = resonLblY;
    
//    UILabel *resonDeLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(resonLbl.frame) + 10, 10, 200, 20)];
//    [resonDeLbl setTextColor:kColorC];
//    [resonDeLbl setText:@"请输入顾客调店原因"];
//    resonDeLbl.font = [UIFont systemFontOfSize:14];
//    [resonView addSubview:resonDeLbl];
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(resonLbl.frame)+5, scrollView.width - 20, 55)];
//    textView.delegate = self;
////    textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    [resonView addSubview:textView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(resonLbl.frame),
                                                                        0,
                                                                        resonView.width - resonLbl.width - 10, 55)];
    textView.textColor = kColor6;
    textView.font = FONT_SIZE(14);
    textView.delegate = self;
    [resonView addSubview:textView];
    [textView xmhAddPlaceholder:@"请输入顾客调店原因"];
    
    UIView *spView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(resonView.frame)+10, scrollView.width - 20, 130)];
    spView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:spView];
    [spView cornerRadius:5];
    
    UILabel *spPerson = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    [spPerson setText:@"审批人"];
    spPerson.font = FONT_SIZE(15);
    spPerson.textColor = kColor3;
    [spView addSubview:spPerson];
    _spView = spView;
    
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(_spView.frame)+ 10);
    
}
- (void)textViewDidChange:(UITextView *)textView{
     _params[@"cause"] = textView.text;
}
- (void)detailBtn:(UIButton *)btn{
    WeakSelf;
    if (btn.tag == 2) {
        MzzTDSelectStoreController *selectVc = [[MzzTDSelectStoreController alloc] init];
        [selectVc setSureOnclick:^(SPStoresModel *model) {
            _selectStoreModel = model;
            [weakSelf.selectBtn setTitle:model.name forState:UIControlStateNormal];
             [weakSelf.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             [self requestData];
        }];
        [self.navigationController pushViewController:selectVc animated:NO];
    }else if (btn.tag ==3){
        MzzTDSelectTypeController *typeVc = [[MzzTDSelectTypeController alloc] init];
        [typeVc setSureOnclick:^(BOOL islinshi, NSString *startDate, NSString *endDate) {
            [weakSelf.typeBtn  setTitle:islinshi?@"临时调店":@"永久调店" forState:UIControlStateNormal];
            [weakSelf.typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            _params[@"chmdtype"] =islinshi?@"1":@"2";
            if (startDate !=nil && ![startDate isEqualToString:@"选择时间 ＞"]) {
                _params[@"chmd_starttime"] = startDate;
            }
            if (endDate !=nil && ![endDate isEqualToString:@"选择时间 ＞"]) {
                 _params[@"chmd_endtime"] = endDate;
            }
        }];
          [self.navigationController pushViewController:typeVc animated:NO];
    }else{
        
    }
}

- (void)sure{
    if (!_selectStoreModel) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择调至门店"];
        return;
    }
    if (!_params[@"chmdtype"]) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择调店类型"];
        return;
    }
    
    if ([_params[@"cause"] isEqualToString:@""] || _params[@"cause"] ==nil) {
        [MzzHud toastWithTitle:@"提示" message:@"请输入顾客调店原因"];
        return;
    }
    if (!_selectPersonModel) {
        [MzzHud toastWithTitle:@"提示" message:@"请选择审批人"];
        return;
    }
    
    LolUserInfoModel *infomodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _params[@"join_code"] = [ShareWorkInstance shareInstance].join_code;
    _params[@"code"] = _model.code?_model.code:@"";
    NSMutableArray *appArr = [NSMutableArray array];
    [appArr addObject:[NSString stringWithFormat:@"%ld",_selectPersonModel.ID]];

    NSMutableArray *dupArr = [NSMutableArray array];
    for (int i = 0; i <_spModel.duplicatePerson.count; i ++) {
        SPPersonModel *personModel = [_spModel.duplicatePerson objectAtIndex:i];
        [dupArr addObject:[NSString stringWithFormat:@"%ld",personModel.ID]];
    }
    _params[@"approvalPerson"] = [appArr componentsJoinedByString:@","];
    _params[@"duplicatePerson"] = [dupArr componentsJoinedByString:@","];
    _params[@"account_id"] = [NSString stringWithFormat:@"%ld",infomodel.data.ID];
    _params[@"account"] = infomodel.data.account? infomodel.data.account:@"";
    if (_outcode) {
        //调出
         _params[@"outStore"] = _outcode;
    }else{
        //调入
        _params[@"outStore"] = _model.store_code;
    }
  
    _params[@"inStore"] =_selectStoreModel.code ;
    
    if (_model.user) {
         //调出
        _params[@"chType"] = @"1";
        NSMutableArray *userArr = [NSMutableArray array];
        for (int i = 0; i <_model.user.count; i ++) {
            SPStoreUserModel *userModel = [_model.user objectAtIndex:i];
            [userArr addObject:[NSString stringWithFormat:@"%ld",userModel.ID]];
        }
        _params[@"user_id"] = [userArr componentsJoinedByString:@","];
    }else{
        //调入
        _params[@"user_id"] = _model.ID;
        _params[@"chType"] = @"2";
    }
    _params[@"user_store_id"] =_model.user_store_id ;

    [SPRequest requestPostChangeStoreParams:_params resultBlock:^(BaseModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (model.code ==1) {
            [[[MzzHud alloc] initWithTitle:@"提示" message:@"提交成功" centerButtonTitle:@"好的" click:^(NSInteger index) {
                for (UIViewController *temp in self.navigationController.viewControllers) {
                    if ([temp isKindOfClass:[ApproveController class]]) {
                        [self.navigationController popToViewController:temp animated:NO];
                    }
                }
            }]show];
        }else{
            [MzzHud toastWithTitle:@"提示" message:model.msg];
        }
    }];
}

- (void)setupStatistics:(UIView *)superView {
    //读取app中信息个数,即应用个数
    NSUInteger totalCount = _model.user.count;;
    //    //创建app索引
    int index;
    //设定界面总列数
    int totalCol = 5;
    int distanceX ;
    int distanceY = 40 + 10;
    
    for ( index = 0; index<totalCount; index++) {
        
        SPStoreUserModel *model = [_model.user objectAtIndex:index];
        //直接创建自定义YJappView类型的appView;
        MzzTDIconView *View = [[[NSBundle mainBundle] loadNibNamed:@"MzzTDIconVIew" owner:nil options:nil] lastObject];
        [View.iconImg cornerRadius:View.iconImg.width / 2.f];
        [View.iconImg yy_setImageWithURL:[NSURL URLWithString:model.headimgurl] placeholder:kDefaultCustomerImage];
        [View.nameLbl setText:model.name];
        
        //计算当前index对应的行号和列号
        int currentRow = index/totalCol;
        int currentCol = index%totalCol;
        
        //间距随xib文件中frame数据动态改变
        distanceX = (SCREEN_WIDTH-totalCol*View.frame.size.width)/(totalCol+1);
        
        //appView原点对应的X值
        CGFloat appViewX = distanceX +currentCol*(View.frame.size.width + distanceX);
        //appView原点对应的Y值
        CGFloat appViewY = distanceY +currentRow*(View.frame.size.height + 10);
        View.frame = CGRectMake(appViewX - 10, appViewY, View.frame.size.width, View.frame.size.height);
        //添加appView
        [superView addSubview:View];
    }
    
}
@end
