//
//  WorkTbHeader.m
//  xmh
//
//  Created by ald_ios on 2018/9/11.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "WorkTbHeader.h"
#import "WorkModel.h"
#import "WorkTopView.h"
#import "WorkTbHeardManager.h"
#import "WorkTbHeardManagerJs.h"
#import "WorkTbHeardManagerXs.h"
#import "WorkTbHeardMagnagerSh.h"
#import "WorkTbHeardMagnagerSq.h"
#import "WorkTbHeardMagnagerQt.h"


@interface WorkTbHeader ()
@property(nonatomic,strong)WorkTopView *topView;
@property(nonatomic,strong)UIButton *moreButton;
@property(nonatomic,strong)WorkTbHeardManager *manageView;//管理层
@property(nonatomic,strong)WorkTbHeardManagerJs *manageJsView;//技术店长/售前店长/售中美容师
@property(nonatomic,strong)WorkTbHeardManagerXs *manageXsView;//销售店长
@property(nonatomic,strong)WorkTbHeardMagnagerSh *managerShView;//售后美容师
@property(nonatomic,strong)WorkTbHeardMagnagerSq *managerSqView;//售前美容师
@property(nonatomic,strong)UIImageView *imageVeiw;
@property(nonatomic,strong)WorkTbHeardMagnagerQt *lineView;//前台横线
@end
@implementation WorkTbHeader

-(WorkTopView *)topView
{
    if (!_topView) {
        _topView = [[WorkTopView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 145) withMessageArray:self.workModel andRole:self.role];
        _topView.backgroundColor = RGBColorWithAlpha(255, 255, 255, 0.96);
        _topView.layer.shadowColor= RGBColorWithAlpha(51, 51, 51, 0.14).CGColor;
        _topView.layer.shadowOpacity = 1;
        _topView.layer.shadowRadius = 30;
        _topView.layer.cornerRadius = 10;
    }
    return _topView;
}
-(UIImageView *)imageVeiw
{
    if (!_imageVeiw) {
        _imageVeiw = [[UIImageView alloc]initWithFrame:CGRectMake(_moreButton.frame.size.width/2-9, 3, 18, 7)];
        _imageVeiw.image = [UIImage imageNamed:@"xiala"];
    }
    return _imageVeiw;
}
-(UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _moreButton.frame = CGRectMake((SCREEN_WIDTH-20 - 60) * 0.5, _topView.frame.origin.y+_topView.frame.size.height-15, 60, 13);
        [_moreButton addTarget:self action:@selector(moreButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.backgroundColor = [UIColor clearColor];
        _moreButton.layer.shadowColor= RGBColorWithAlpha(51, 51, 51, 0.14).CGColor;
        _moreButton.layer.shadowOpacity = 1;
        _moreButton.layer.shadowRadius = 30;
        _moreButton.layer.cornerRadius = 10;
    }
    return _moreButton;
}
-(WorkTbHeardManager *)manageView
{
    if (!_manageView) {
        _manageView = [WorkTbHeardManager loadWorkTbHeaderManager];
        _manageView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 160);
    }
    return _manageView;
}
-(WorkTbHeardManagerJs *)manageJsView
{
    if (!_manageJsView) {
        _manageJsView = [WorkTbHeardManagerJs loadWorkTbHeaderManagerJs];
        _manageJsView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 100);
    }
    return _manageJsView;
}
-(WorkTbHeardManagerXs *)manageXsView
{
    if (!_manageXsView) {
        _manageXsView = [WorkTbHeardManagerXs loadWorkTbHeaderManagerXs];
        _manageXsView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 316);
    }
    return _manageXsView;
}
-(WorkTbHeardMagnagerSh *)managerShView
{
    if (!_managerShView) {
        _managerShView = [WorkTbHeardMagnagerSh loadWorkTbHeaderManagerSh];
        _managerShView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 200);
    }
    return _managerShView;
}
-(WorkTbHeardMagnagerSq *)managerSqView
{
    if (!_managerSqView) {
        _managerSqView = [WorkTbHeardMagnagerSq loadWorkTbHeaderManagerSq];
        _managerSqView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 150);
    }
    return _managerSqView;
}
-(WorkTbHeardMagnagerQt *)lineView
{
    if (!_lineView) {
        _lineView = [WorkTbHeardMagnagerQt loadWorkTbHeaderManagerQt];
        _lineView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 15);
    }
    return _lineView;
}
- (instancetype)initWithFrame:(CGRect)frame withType:(NSInteger)type andHeadArray:(WorkHeardManagerModel *)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.workModel = model;
        self.role = type;
        self.selectMore = NO;
        switch (type) {
            case 1:
            case 3:
                [self initManagerUI];
                break;
            case 4:
                [self initManagerJsUI];
                break;
            case 5:
                [self initManagerXsUI];
                break;
            case 6:
                [self initManagerSqUI];
                break;
            case 7:
                [self initDeskUI];
                break;
            case 8:
                [self initManagerShMUI];
                break;
            case 9:
                [self initManagerSqMUI];
                break;
            case 10:
                [self initManagerSzMUI];
                break;
            case 11:
                [self initShoppersUI];
                break;
                
            default:
                break;
        }
        
    }
    return self;
}
-(void)updateView:(NSInteger)type withModel:(WorkHeardManagerModel *)model withSelect:(BOOL)select
{
    self.workModel = model;
    self.role = type;
    _selectMore = select;
    NSInteger tap ;
    NSInteger height;
    if (select) {
        tap =4;
        height = 265;
    }else{
        tap = 2;
        height = 145;
    }
    switch (type) {
        case 1:
        case 3:
            [self.topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, height) withNum:tap withModel:self.workModel andRole:self.role];
            [self.manageView updateWorkTbHeaderModel:_workModel withRole:self.role];
            break;
        case 4:
            [self.topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, height) withNum:tap withModel:self.workModel andRole:self.role];
            [self.manageJsView updateWorkTbHeaderModel:_workModel withRole:self.role];
            break;
        case 5:
            [self.topView updateLoad:CGRectMake(15, 0, SCREEN_WIDTH-20, height) withNum:tap withModel:self.workModel andRole:self.role];
            [self.manageXsView updateWorkTbHeaderModel:_workModel withRole:self.role];
            
            break;
        case 6:
            [self.topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, height) withNum:tap withModel:self.workModel andRole:self.role];
            [self.manageJsView updateWorkTbHeaderModel:_workModel withRole:self.role];
            
            break;
        case 7:
            [self.topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, height) withNum:tap withModel:self.workModel andRole:self.role];
            break;
        case 8:
            [self.topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, height) withNum:tap withModel:self.workModel andRole:self.role];
            [self.managerShView updateWorkTbHeaderModel:_workModel withRole:self.role];
            
            break;
        case 9:
            [self.topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, height) withNum:tap withModel:self.workModel andRole:self.role];
            [self.managerSqView updateWorkTbHeaderModel:_workModel withRole:self.role];
            
            break;
        case 10:
            [self.topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, height) withNum:tap withModel:self.workModel andRole:self.role];
            [self.manageJsView updateWorkTbHeaderModel:_workModel withRole:self.role];
            
            break;
        case 11:
            [self.managerSqView updateWorkTbHeaderModel:_workModel withRole:self.role];
            break;
            
        default:
            break;
    }
}
//点击更多按钮
-(void)moreButtonAction
{
    if (_selectMore == YES) {
        _selectMore = NO;
    }else{
        _selectMore = YES;
    }
    if (_selectMore == YES) {
        _imageVeiw.image = [UIImage imageNamed:@"shousuo"];
        
        [_topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, 265) withNum:4 withModel:self.workModel andRole:self.role];
    }else{
        _imageVeiw.image = [UIImage imageNamed:@"xiala"];
        
        [_topView updateLoad:CGRectMake(10, 0, SCREEN_WIDTH-20, 145) withNum:2 withModel:self.workModel andRole:self.role];
    }
    _moreButton.frame = CGRectMake((SCREEN_WIDTH-20 - 60) * 0.5, _topView.frame.origin.y+_topView.frame.size.height-15, 60, 13);
    _lineView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 15);
    _imageVeiw.frame = CGRectMake(_moreButton.frame.size.width/2-9, 3, 18, 7);
    _manageView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 160);
    _manageJsView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 100);
    _manageXsView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 316);
    _managerShView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 200);
    _managerSqView.frame = CGRectMake(0, _topView.frame.origin.y+_topView.frame.size.height, SCREEN_WIDTH, 150);
    
    if (_btnMoreButton) {
        _btnMoreButton(_selectMore);
    }
}
//售前美容师
-(void)initManagerSqMUI
{
    [self addSubview:self.topView];
    [self addSubview:self.moreButton];
    [self.moreButton addSubview:self.imageVeiw];
    [self.managerSqView updateWorkTbHeaderModel:_workModel withRole:self.role];
    [self addSubview:self.managerSqView];
    
}
//售后美容师
-(void)initManagerShMUI
{
    [self addSubview:self.topView];
    [self addSubview:self.moreButton];
    [self.moreButton addSubview:self.imageVeiw];
    [self.managerShView updateWorkTbHeaderModel:_workModel withRole:self.role];
    [self addSubview:self.managerShView];
    
}
//售前店长
-(void)initManagerSqUI
{
    [self addSubview:self.topView];
    [self addSubview:self.moreButton];
    [self.moreButton addSubview:self.imageVeiw];
    [self.manageJsView updateWorkTbHeaderModel:_workModel withRole:self.role];
    [self addSubview:self.manageJsView];
}
//销售店长
-(void)initManagerXsUI
{
    [self addSubview:self.topView];
    [self addSubview:self.moreButton];
    [self.moreButton addSubview:self.imageVeiw];
    [self.manageXsView updateWorkTbHeaderModel:_workModel withRole:self.role];
    [self addSubview:self.manageXsView];
    
}
//技术店长
-(void)initManagerJsUI
{
    [self addSubview:self.topView];
    [self addSubview:self.moreButton];
    [self.moreButton addSubview:self.imageVeiw];
    [self.manageJsView updateWorkTbHeaderModel:_workModel withRole:self.role];
    [self addSubview:self.manageJsView];
}
//售中美容师
-(void)initManagerSzMUI
{
    [self addSubview:self.topView];
    [self addSubview:self.moreButton];
    [self.moreButton addSubview:self.imageVeiw];
    [self.manageJsView updateWorkTbHeaderModel:_workModel withRole:self.role];
    [self addSubview:self.manageJsView];
}
//管理层
-(void)initManagerUI
{
    [self addSubview:self.topView];
    [self addSubview:self.moreButton];
    [self.moreButton addSubview:self.imageVeiw];
    [self.manageView updateWorkTbHeaderModel:_workModel withRole:self.role];
    [self addSubview:self.manageView];
    
}
//前台
-(void)initDeskUI
{
    [self addSubview:self.topView];
    [self addSubview:self.moreButton];
    [self.moreButton addSubview:self.imageVeiw];
    [self addSubview:self.lineView];
}
//导购
-(void)initShoppersUI
{
    self.managerSqView.backgroundColor = [UIColor whiteColor];
    [self.managerSqView updateWorkTbHeaderModel:_workModel withRole:self.role];
    self.managerSqView.lineView.hidden = YES;
    self.managerSqView.toTopConstraint.constant = 20;
    [self addSubview:self.managerSqView];
    
}

@end
