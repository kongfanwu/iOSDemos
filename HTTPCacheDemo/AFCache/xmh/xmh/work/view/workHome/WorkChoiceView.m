//
//  WorkChoiceView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/14.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "WorkChoiceView.h"
#import "ShareWorkInstance.h"
#import "LolUserInfoModel.h"
#import "UserInfoRequest.h"
#import "ZhuzhiModel.h"
#import "WorkChoiceCell.h"
#import "WorkChoiceModel.h"
#import "OnLineRequest.h"
#import "OnFramListModel.h"
#import "COrganizeModel.h"
@implementation WorkChoiceView{
    UITableView  *_tbChoice;
    NSArray *_positionArrayTitle;//职位标题数组
    NSMutableArray *_positionArray;
    UIScrollView *_positionScroll;
    UIImageView *_line1;
    UIImageView *_line2;
    UIImageView *_line3;
    UIImageView *_lineRed;
    UILabel *_lbLeftTitle;
    
    NSArray *_arrSource;
    
    Join_Code *_join_Code;
    NSInteger _fram_id;
    NSInteger _NowInteger;
    
    NSMutableArray *_sourceArr;
    NSIndexPath *_lastindexPath;
    NSMutableArray *_selectArr;
    NSString    *_title1;
    NSString    *_title2;
    NSString *_pinpaistr;
    NSString    *_title2Header;
    //--
    NSString *cjoin_code;
    Fram_List *fram_list0;
    Fram_List *fram_list1;

    NSString *coneClick;
    NSString *ctwoClick;
    NSString *ctwoListId;
    NSString *cinId;
    NSInteger level;
    NSInteger main_role;
    NSString * cthirdClick;
    NSString * cfourClick;
    OnFramListModel * _onLine;
    LolUserInfoModel *_LolUserInfoModelmodel;
    Fram_List *info;
    
    COrganizeModel * _orgainzeModel;
    List *_Listinfo;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化数据
        _LolUserInfoModelmodel =  [UserManager getObjectUserDefaults:userLogInInfo];
        _join_Code =  [ShareWorkInstance shareInstance].share_join_code;
        _positionArrayTitle = _join_Code.fram_list;
        [self initBaseData];
        
    }
    return self;
}
- (void)setIsOnLine:(BOOL)isOnLine
{
    _isOnLine = isOnLine;
    NSMutableArray * temp = [[NSMutableArray alloc] init];
    for (int i = 0; i< _join_Code.fram_list.count; i++) {
        Fram_List *fram = _join_Code.fram_list[i];
        if (fram.level >=0) {
            [temp addObject:fram];
        }
    }
    [OnLineRequest requestOnlineFrameId:[NSString stringWithFormat:@"%ld",_fram_id] resultBlock:^(OnFramListModel *model, BOOL isSuccess, NSDictionary *errorDic) {
        if (isSuccess) {
            _onLine = model;
            for (int i = 0; i < model.list.count; i++) {
                Fram_List *fram = model.list[i];
                [temp addObject:fram];
            }
            _positionArrayTitle = temp;
            [self initBaseData];
        }
    }];
}
- (void)initBaseData
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self initSubviews];
    
    _title1 = _join_Code.fram_id_name;
    _fram_id = _join_Code.fram_id;
    _selectArr = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i<_positionArrayTitle.count; i++) {
        WorkChoiceModel *model = [[WorkChoiceModel alloc]init];
        [_selectArr addObject:model];
    }
    if (_selectArr.count) {
        WorkChoiceModel *modelone = _selectArr[0];
        modelone.fram_name_id = _join_Code.fram_name_id;
        modelone.fram_id = _fram_id;
        modelone.select = YES;
    }
    
    List *infoOne = [[List alloc]init];
    infoOne.name = _join_Code.fram_id_name;
    infoOne.fram_id = _join_Code.fram_id;
    infoOne.main_role = _join_Code.framework_function_main_role;
    _sourceArr = [[NSMutableArray alloc]init];
    [_sourceArr addObject:infoOne];
    [_tbChoice reloadData];
    [self performSelector:@selector(autoDelayMethod) withObject:nil afterDelay:1];
}
- (void)autoDelayMethod{

    cjoin_code = _join_Code.code;
    if (_join_Code.fram_list.count > 0) {
        fram_list0 = _join_Code.fram_list[0];
    }
    if (_join_Code.fram_list.count > 1) {
        fram_list1 = _join_Code.fram_list[1];
    }
    level = fram_list0.level;
    main_role = fram_list0.main_role;
    coneClick = [NSString stringWithFormat:@"%@",@(_join_Code.fram_id)];
    ctwoClick = @"all";
    ctwoListId = [NSString stringWithFormat:@"%@",@(fram_list1.fram_name_id)];
    cinId = _LolUserInfoModelmodel.data.account;
    //全局保存默认值
    [ShareWorkInstance shareInstance].coneClick = coneClick;
    [ShareWorkInstance shareInstance].ctwoClick = ctwoClick;
    [ShareWorkInstance shareInstance].ctwoListId = ctwoListId;
    [ShareWorkInstance shareInstance].cinId = cinId;
    [ShareWorkInstance shareInstance].level = level;
    [ShareWorkInstance shareInstance].main_role = main_role;
    if (_join_Code.fram_list.count > 1) {
        Fram_List *fram_list1 = _join_Code.fram_list[1];
        _title2 = fram_list1.name;
    }
    if (_WorkChoiceViewBlock) {
        _WorkChoiceViewBlock(cjoin_code,coneClick,ctwoClick,ctwoListId,cinId,level,main_role,_title1,_title2,_Listinfo);
    }
    if (_isOnLine) {
        COrganizeModel * model = [COrganizeModel createModelWithOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId thirdClick:ctwoClick forthClick:ctwoListId joinCode:_join_Code.code level:level mainrole:main_role];
        if (_WorkChoiceBlock) {
            _WorkChoiceBlock(model);
        }
    }
}
- (void)initSubviews{
    self.backgroundColor = [UIColor whiteColor];
    //
    _line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 1)];
    _line1.backgroundColor= kBackgroundColor;
    [self addSubview:_line1];
    
    _lbLeftTitle = [[UILabel alloc]init];
    _lbLeftTitle.text = @"请选择";
    _lbLeftTitle.font = FONT_SIZE(13);
    _lbLeftTitle.textColor = kLabelText_Commen_Color_6;
    [_lbLeftTitle sizeToFit];
    _lbLeftTitle.frame = CGRectMake(15, _line1.bottom + (49-_lbLeftTitle.frame.size.height)/2.0, _lbLeftTitle.frame.size.width, _lbLeftTitle.frame.size.height);
    [self addSubview:_lbLeftTitle];
    
    _btnReSet = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15-50-15-50,_line1.bottom,50, 49)];
    [_btnReSet setTitle:@"取消" forState:UIControlStateNormal];
    [_btnReSet setTitle:@"取消" forState:UIControlStateSelected];
    [_btnReSet setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    [_btnReSet addTarget:self action:@selector(CancleEvent) forControlEvents:UIControlEventTouchUpInside];
    _btnReSet.titleLabel.font = FONT_SIZE(13);
    [self addSubview:_btnReSet];
    
    _btnSure = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15-50,_line1.bottom,50, 49)];
    [_btnSure setTitle:@"确定" forState:UIControlStateNormal];
    [_btnSure setTitle:@"确定" forState:UIControlStateSelected];
    [_btnSure setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
    _btnSure.titleLabel.font = FONT_SIZE(13);
    [_btnSure addTarget:self action:@selector(btnRightEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btnSure];
    
    _line2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
    _line2.backgroundColor= kBackgroundColor;
    [self addSubview:_line2];
    
    /*定义职位标题*/
    NSInteger i = 0;

    _positionArray = [[NSMutableArray alloc]init];
    CGFloat  totoWidth = 0;
    _positionScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _line2.bottom, SCREEN_WIDTH, 50)];
    [self addSubview:_positionScroll];
    _positionScroll.showsHorizontalScrollIndicator = NO;
    _line3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
    _line3.backgroundColor= kBackgroundColor;
    [_positionScroll addSubview:_line3];
    
    for (Fram_List *info in _positionArrayTitle) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((50)*i,0,0, 49)];
        btn.tag = 1000+i;
        [btn setTitle:info.name forState:UIControlStateNormal];
        [btn setTitle:info.name forState:UIControlStateSelected];
        [btn setTitleColor:kLabelText_Commen_Color_6 forState:UIControlStateNormal];
        [btn setTitleColor:[ColorTools colorWithHexString:@"#f10180"] forState:UIControlStateSelected];
        btn.titleLabel.font = FONT_SIZE(13);
        CGSize titleSize = [info.name sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
        titleSize.height = 49;
        float btnwidth = titleSize.width + 20;
        btn.frame = CGRectMake(totoWidth ,0, btnwidth, 49);
        [_positionScroll addSubview:btn];
        totoWidth = totoWidth+btnwidth;
        _positionScroll.contentSize = CGSizeMake(totoWidth, 50);
        
        if (i == 0) {
            btn.selected = YES;
            _lineRed = [[UIImageView alloc]initWithFrame:CGRectMake(0, 49, btnwidth, 1)];
            _lineRed.backgroundColor= [ColorTools colorWithHexString:@"#f10180"];
            [_positionScroll addSubview:_lineRed];
            _lineRed.center = CGPointMake(btn.center.x, _lineRed.center.y);
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(btnpositionEvent:) forControlEvents:UIControlEventTouchUpInside];
        i++;
        [_positionArray addObject:btn];
    }
    _tbChoice = [[UITableView alloc]initWithFrame:CGRectMake(0, _positionScroll.bottom, SCREEN_WIDTH, self.height - 101) style:UITableViewStylePlain];
    _tbChoice.dataSource = self;
    _tbChoice.delegate = self;
    _tbChoice.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tbChoice];
}
- (void)btnpositionEvent:(UIButton *)sender{
    [ShareWorkInstance shareInstance].positionBtnTag = sender.tag;
    for (UIButton *btnTemp in _positionArray) {
        btnTemp.selected = NO;
    }
    sender.selected = YES;
    _lineRed.frame = CGRectMake(0, 49, sender.width, 1);
    _lineRed.center = CGPointMake(sender.center.x, _lineRed.center.y);
    if (_positionBlock) {
        _positionBlock(sender.titleLabel.text);
    }
    NSInteger j = sender.tag - 1000;
    _NowInteger = j;
    if (j == 0) {
        List *infoOne = [[List alloc]init];
        infoOne.name = _join_Code.fram_id_name;
        infoOne.fram_id = _join_Code.fram_id;
        
        _fram_id = _join_Code.fram_id;
        if (_sourceArr.count) {
            [_sourceArr removeAllObjects];
        }
        [_sourceArr addObject:infoOne];
        [_tbChoice reloadData];
        
    } else {
        
        info = _positionArrayTitle[j];
        _title2Header = info.name;
        _title2 = info.name;

        NSInteger frame_idTemp = 0;
        NSString *ID;
        if (info.level > 0) {
            ID = [NSString stringWithFormat:@"%@",@(_join_Code.fram_id)];
        }else if (info.level == 0){
            ID = _join_Code.code;
        }else if (info.level < 0){
            ID = _LolUserInfoModelmodel.data.account;
        }
        for (NSInteger i = _selectArr.count-1;i>=0; i--) {
            if (i>j) {
                WorkChoiceModel *modelone = _selectArr[i];
                modelone.fram_name_id = 0;
                modelone.fram_id = 0;
                modelone.select = NO;
                if (_isOnLine &&(info.level == -103)) {
                    ID = modelone.ID;
                }
            }else if (i == j){
                WorkChoiceModel *modelone = _selectArr[i];
                modelone.fram_name_id = info.fram_name_id;
                modelone.fram_id = 0;
                modelone.select = NO;
                if (_isOnLine &&(info.level == -103)) {
                    ID = modelone.ID;
                }
            }else if (i < j){
                WorkChoiceModel *modelone = _selectArr[i];
                if (modelone.select) {
                    if (modelone.fram_id != -200) {
                        frame_idTemp = modelone.fram_id;
                        if (_isOnLine &&(info.level == -103)) {
                            ID = modelone.ID;
                        }
                        break;
                    }
                }
                
            }
        }
        
            if (_isOnLine ) { //如果是商品没有选择下面列表 ID传默认值all
                if (!ID) {
                    ID = @"all";
                }
            }
            [[[UserInfoRequest alloc]init] requestZhuzhi:info.fram_name_id Fram_id:frame_idTemp ID:ID resultBlock:^(ZhuzhiModel *zhuzhiModel, BOOL isSuccess, NSDictionary *errorDic) {
                if (isSuccess) {
                    if (_sourceArr.count >0) {
                        [_sourceArr removeAllObjects];
                    }
                    List *info = [[List alloc]init];
                    info.name = @"全部";
                    [_sourceArr addObject:info];
                    [_sourceArr addObjectsFromArray:zhuzhiModel.data.list];
                    [_tbChoice reloadData];
                }
            }];
        }
}
- (void)btnRightEvent{
    if (_WorkChoiceViewBlock) {
//        if (_NowInteger) {
            Fram_List *info = _positionArrayTitle[_NowInteger];
            level = info.level;
            ctwoListId = [NSString stringWithFormat:@"%@",@(info.fram_name_id)];
            cinId = @"";
//            main_role = info.main_role;
            BOOL fristFind = NO;
            BOOL secondFind = NO;
            if (info.level == 0){
                cinId = _join_Code.code;
            }else if (info.level < 0){
                cinId = _LolUserInfoModelmodel.data.account;
            }
            for (NSInteger i= _NowInteger; i >= 0; i--) {
                WorkChoiceModel *modelone = _selectArr[i];
                if (modelone.select) {
                    if (!fristFind) {
                        if (modelone.fram_id == -200) {
                            ctwoClick = @"all";
                        }else{
                            ctwoClick = [NSString stringWithFormat:@"%@",@(modelone.fram_id)];
                            cinId = modelone.ID;
                        }
                        if (info.level == -2) {
                            cinId = modelone.ID;
                        }
                        fristFind = YES;
                        continue;
                    }
                    if (!secondFind) {
                        if (modelone.fram_id != -200) {
                            coneClick = [NSString stringWithFormat:@"%@",@(modelone.fram_id)];
                        }
                        secondFind =  YES;
                        break;
                    }
                }
            }
        
//        }
        
        //全局保存
        [ShareWorkInstance shareInstance].coneClick = coneClick;
        [ShareWorkInstance shareInstance].ctwoClick = ctwoClick;
        [ShareWorkInstance shareInstance].ctwoListId = ctwoListId;
        [ShareWorkInstance shareInstance].cinId = cinId;
        [ShareWorkInstance shareInstance].level = level;
        [ShareWorkInstance shareInstance].main_role = main_role;
        _WorkChoiceViewBlock(_join_Code.code,coneClick,ctwoClick,ctwoListId,cinId,level,main_role,_title1,_title2,_Listinfo);
        
        if (_isOnLine) {
            COrganizeModel * model = [COrganizeModel createModelWithOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId thirdClick:ctwoClick forthClick:ctwoListId joinCode:_join_Code.code level:level mainrole:main_role];
            if (_WorkChoiceBlock) {
                _WorkChoiceBlock(model);
            }
        }
    }
    self.hidden = YES;
}
- (void)CancleEvent{
    self.hidden = YES;
    if (_WorkChoiceViewCancleBlock) {
        _WorkChoiceViewCancleBlock();
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *WorkChoiceCellindentifier = @"WorkChoiceCellindentifier";
    WorkChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:WorkChoiceCellindentifier];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WorkChoiceCell" owner:nil options:nil] lastObject];
    }
    if (indexPath.row <_sourceArr.count) {
        List *info = _sourceArr[indexPath.row];
        [cell refreshWorkChoiceCell:info.name];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _sourceArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_lastindexPath) {
        WorkChoiceCell *cell = [tableView cellForRowAtIndexPath:_lastindexPath];
        cell.lb1.textColor = kLabelText_Commen_Color_3;
    }
    WorkChoiceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.lb1.textColor = kBtn_Commen_Color;
    _lastindexPath = indexPath;
    
    if (indexPath.row <_sourceArr.count) {
        List *info = (List *)_sourceArr[indexPath.row];
        _Listinfo = info;
        _fram_id = info.fram_id;
        if ([info.name isEqualToString:@"全部"]) {
            _fram_id = -200;
            _title2 = info.name;
//            _title2 =[NSString stringWithFormat:@"全部%@",_title2Header];
        }else{
             _title2 = cell.lb1.text;
        }
        main_role = info.main_role;
        Fram_List *ainfo = _positionArrayTitle[_NowInteger];
        WorkChoiceModel *modelone = _selectArr[_NowInteger];
        modelone.fram_name_id = ainfo.fram_name_id;
        modelone.fram_id = _fram_id;
        modelone.ID = info.ID;
        modelone.select = YES;
    }
}
@end
