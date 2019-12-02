//
//  LFrameView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/23.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "LFrameView.h"
#import "LFrameSelectTitleView.h"
#import "LFrameTitleView.h"
#import "LFrameCell.h"
#import "LolUserInfoModel.h"
#import "UserManager.h"
#import "ShareWorkInstance.h"
#import "OnLineRequest.h"
#import "OnFramListModel.h"
#import "UserInfoRequest.h"
@interface LFrameView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation LFrameView
{
    UIView * _bgView;
    UIView * _bgContainer;
    UILabel * _lbPointer;
    NSMutableArray * _titleArr;
    UIImageView *_lineRed;
    NSMutableArray *_btnArray;
    LolUserInfoModel *_LolUserInfoModelmodel;
    Join_Code *_join_Code;
    OnFramListModel *_frameModel;
    UITableView * _tb;
    NSMutableArray *_sourceArr;
    NSString * _id0;
    
    Fram_List * _selectFrame; //选择的层级
    List * _selectSubFrame;   //选择层级下的职位
    
    NSString * _oneClick;
    NSString * _twoClick;
    NSString * _twoListId;
    NSString * _thirdClick;
    NSString * _fourthClick;
    
    LFrameTitleView * _titleView;
    NSString * _preTwoListId;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        _titleArr = @[@"门店1",@"阿拉丁神灯",@"享美会",@"三里屯太古里",@"门店1",@"阿拉丁神灯",@"享美会",@"三里屯太古里"];
        _btnArray = [[NSMutableArray alloc] init];
        _sourceArr = [[NSMutableArray alloc] init];
        [self initBaseData];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame ParameBlock:(LFrameViewBlock)parameBlock
{
    if (self = [super initWithFrame:frame]) {
        //        _titleArr = @[@"门店1",@"阿拉丁神灯",@"享美会",@"三里屯太古里",@"门店1",@"阿拉丁神灯",@"享美会",@"三里屯太古里"];
        _btnArray = [[NSMutableArray alloc] init];
        _sourceArr = [[NSMutableArray alloc] init];
        [self initBaseData];
        NSString * oneClick = [NSString stringWithFormat:@"%ld",_join_Code.fram_id];
     
        NSString * twoListId = @"";
        if (_join_Code.fram_id_level.intValue == -2) {
            twoListId = @"-1";
        }else{
//            twoListId = [NSString stringWithFormat:@"%ld",_join_Code.fram_list[1].fram_name_id];
            twoListId = [NSString stringWithFormat:@"%ld",_join_Code.fram_name_id];
            _twoListId = twoListId;
        }
        if (!(_thirdClick.length > 0)){
            _thirdClick = @"-1";
        }
        if (!(_fourthClick.length > 0)){
            _fourthClick = @"-1";
        }
        COrganizeModel * model = [COrganizeModel createModelWithOneClick:oneClick twoClick:@"all" twoListId:twoListId inId:@"" thirdClick:_thirdClick forthClick:_fourthClick joinCode:_join_Code.code level:0 mainrole:0];
        parameBlock(model);
        _LFrameViewBlock = parameBlock;
    }
    return self;
}
- (void)initBaseData
{
    _LolUserInfoModelmodel =  [UserManager getObjectUserDefaults:userLogInInfo];
    _join_Code =  [ShareWorkInstance shareInstance].share_join_code;
    _titleArr = [[NSMutableArray alloc] initWithArray:_join_Code.fram_list];
    _id0 = [NSString stringWithFormat:@"%ld",_LolUserInfoModelmodel.data.ID];
    _oneClick = [NSString stringWithFormat:@"%ld",_join_Code.fram_id];
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for (int i = 0; i< _join_Code.fram_list.count; i++) {
        Fram_List *fram = _join_Code.fram_list[i];
        if (fram.level >=0) {
            [temp addObject:fram];
        }
    }
    if (_frameModel) {
        return;
    }
    [OnLineRequest requestOnlineFrameId:[NSString stringWithFormat:@"%ld",_join_Code.fram_id] resultBlock:^(OnFramListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _frameModel = model;
            for (int i = 0; i < model.list.count; i++) {
                Fram_List *fram = model.list[i];
                [temp addObject:fram];
            }
            _titleArr = temp;
            [self initSubViews];
        }
    }];
    
}
- (void)initSubViews
{
    [self createFrameTitleView];
//    [self createBgContainer];
    
}
- (void)createBgContainer
{
    _bgContainer = [[UIView alloc] init];
    _bgContainer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:_bgContainer];
    [self initBlackGroundView];
    [self createShowView];
}
- (void)initBlackGroundView
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor darkGrayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapH)];
    [view addGestureRecognizer:tap];
    view.alpha = 0.7;
    _bgView = view;
    [_bgContainer addSubview:view];
}
- (void)tapH
{
    [_bgContainer removeFromSuperview];
}
- (void)createFrameTitleView
{
    LFrameTitleView * title = [[[NSBundle mainBundle]loadNibNamed:@"LFrameTitleView" owner:nil options:nil]lastObject];
    title.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:title];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [title addGestureRecognizer:tap];
    _titleView = title;
    _titleView.lbName1.text = _join_Code.fram_id_name;
}
- (void)tap
{
    [self createBgContainer];
}
- (void)createShowView
{
    UIView * container = [[UIView alloc] init];
    container.frame = CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2);
    container.backgroundColor = [UIColor whiteColor];
    [_bgContainer addSubview:container];
    
    LFrameSelectTitleView * titleView = [[[NSBundle mainBundle]loadNibNamed:@"LFrameSelectTitleView" owner:nil options:nil]lastObject];
    [titleView.btnSure addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [titleView.btnCancel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    [container addSubview:titleView];
   
    UIScrollView * scroll = [[UIScrollView alloc] init];
    scroll.frame = CGRectMake(0, titleView.bottom, SCREEN_WIDTH, 50);
    scroll.showsHorizontalScrollIndicator = NO;
    [container addSubview:scroll];
    
    CGFloat  totoWidth = 0;
    for (int i = 0; i < _titleArr.count; i++) {
        Fram_List * framList = _titleArr[i];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((50)*i,0,0, 49)];
        btn.tag = 1000+i;
        [btn setTitle:framList.name forState:UIControlStateNormal];
        [btn setTitle:framList.name forState:UIControlStateSelected];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [btn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
        btn.titleLabel.font = FONT_SIZE(13);
        CGSize titleSize = [framList.name sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        titleSize.height = 49;
        float btnwidth = titleSize.width + 20;
        btn.frame = CGRectMake(totoWidth ,0, btnwidth, 49);
        [scroll addSubview:btn];
        totoWidth = totoWidth+btnwidth;
        scroll.contentSize = CGSizeMake(totoWidth, 50);
        if (i == 0) {
            btn.selected = YES;
            _lineRed = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, btnwidth, 1)];
            _lineRed.backgroundColor= [ColorTools colorWithHexString:@"#f10180"];
            [scroll addSubview:_lineRed];
            _lineRed.center = CGPointMake(btn.center.x, _lineRed.center.y);
            btn.selected = YES;
            [self btnpositionEvent:btn];
        }
        [_btnArray addObject:btn];
        [btn addTarget:self action:@selector(btnpositionEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UITableView * tb = [[UITableView alloc] initWithFrame:CGRectMake(0, scroll.bottom + 20, SCREEN_WIDTH, SCREEN_HEIGHT/2 - scroll.bottom - 20) style:UITableViewStylePlain];
    tb.separatorStyle = UITableViewCellSeparatorStyleNone;
    tb.delegate = self;
    tb.dataSource = self;
    _tb = tb;
    [container addSubview:tb];
}
- (void)click:(UIButton *)btn
{
    if (btn.tag == 200) { // 取消
        
    }else{//确定
        
        if (_selectFrame.level == -102 && _thirdClick.length<=0) {
            _thirdClick = @"-1";
        }
        if (_selectFrame.level == -103 && _fourthClick.length<=0) {
            _fourthClick = @"-1";
        }
        if (!_selectSubFrame) {
            _twoClick = [NSString stringWithFormat:@"%ld",_join_Code.fram_id];
        }else{
            if ([_selectSubFrame.name isEqualToString:@"全部"]) {
                _twoClick = @"all";
            }else{
                _twoClick = [NSString stringWithFormat:@"%ld",_selectSubFrame.fram_id];
            }
        }
        if (_fourthClick.length<=0) {
            _fourthClick = @"-1";
        }
         COrganizeModel * model = [COrganizeModel createModelWithOneClick:_oneClick twoClick:_twoClick twoListId:_twoListId inId:@"" thirdClick:_thirdClick forthClick:_fourthClick joinCode:_join_Code.code level:0 mainrole:0];
        //给标题赋值
        if ([_selectSubFrame.name isEqualToString:@"全部"]) {
            _titleView.lbName2.text = [NSString stringWithFormat:@"全部%@",_selectFrame.name];
        }else{
            if (_selectSubFrame) {
                _titleView.lbName2.text = _selectSubFrame.name;
            }else{
                _titleView.lbName2.text = [NSString stringWithFormat:@"全部%@",_selectFrame.name];
            }
        }
        if (_LFrameViewBlock) {
            _LFrameViewBlock(model);
        }
    }
    [self tapH];
}
- (void)btnpositionEvent:(UIButton *)btn
{
    for (UIButton *btnTemp in _btnArray) {
        btnTemp.selected = NO;
    }
    btn.selected = YES;
    NSInteger i = btn.tag - 1000;
    _lineRed.frame = CGRectMake(0, 49, btn.width, 1);
    _lineRed.center = CGPointMake(btn.center.x, _lineRed.center.y);
    Fram_List *fram = _titleArr[i];
    _selectFrame = fram;
    if ((fram.fram_name_id == -2)||(fram.fram_name_id == -3)) {
        _preTwoListId = _twoListId;
    }else{
        _preTwoListId = [NSString stringWithFormat:@"%ld",fram.fram_name_id];
    }
    if (i == 0) {
        List * list = [List createListWithName:[NSString stringWithFormat:@"%@",_join_Code.fram_id_name] framId:[NSString stringWithFormat:@"%ld",_join_Code.fram_id] cId:[NSString stringWithFormat:@"%ld",_join_Code.function_id]];
        if (_sourceArr.count) {
            [_sourceArr removeAllObjects];
        }
        [_sourceArr addObject:list];
        [_tb reloadData];
    }else{
        
        NSInteger frameId = _selectSubFrame.fram_id?_selectSubFrame.fram_id:1;
        NSString * cId = @"";
        if (fram.level <= -103) {
            if (_selectSubFrame) {
                if ([_selectSubFrame.name isEqualToString:@"全部"]) {
                    cId = _selectSubFrame.ID;
                }else{
                   cId = @"all";
                }
            }else{
                cId = @"all";
            }
        }else{
             cId = @"1";
        }
        [[[UserInfoRequest alloc]init] requestZhuzhi:fram.fram_name_id Fram_id:frameId ID:cId resultBlock:^(ZhuzhiModel *zhuzhiModel, BOOL isSuccess, NSDictionary *errorDic) {
            if (isSuccess) {
                if (_sourceArr.count >0) {
                    [_sourceArr removeAllObjects];
                }
                List *info = [List createListWithName:@"全部" framId:@"all" cId:@""];
                [_sourceArr addObject:info];
                [_sourceArr addObjectsFromArray:zhuzhiModel.data.list];
                [_tb reloadData];
            }
        }];
        
        
    }
//    _selectFrame = nil;
    _selectSubFrame = nil;
    
}
#pragma mark --- UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFrameCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"LFrameCell" owner:nil options:nil]lastObject];
    if (_sourceArr.count > indexPath.row) {
        cell.model = _sourceArr[indexPath.row];
    }
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _twoListId = _preTwoListId;
    
    if (_sourceArr.count > indexPath.row) {
        _selectSubFrame = _sourceArr[indexPath.row];
        _twoClick = [NSString stringWithFormat:@"%ld",_selectSubFrame.fram_id];
    }
    if (_twoClick.length<=0) {
        _twoClick = @"all";
    }
    if (_selectFrame.level == - 102) {
        if (indexPath.row ==0) {
            _thirdClick = @"all";
        }else{
            _thirdClick = _selectSubFrame.ID;
        }
    }
    if (_selectFrame.level == - 103) {
        if (indexPath.row ==0) {
            _fourthClick = @"all";
        }else{
            _fourthClick = _selectSubFrame.ID;
        }
    }
}
@end
