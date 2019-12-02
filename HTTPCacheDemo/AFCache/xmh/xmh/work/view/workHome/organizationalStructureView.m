//
//  organizationalStructureView.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/4.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "organizationalStructureView.h"
#import "WorkChoiceView.h"
#import "COrganizeModel.h"
@implementation organizationalStructureView{
    UIImage *imJiantou;
    UIImage *imGengduo;
    
    UIView *_bgScreenView;
    UIView *_blackView;
    WorkChoiceView *_workChoiceview;
    
    
    //--
    NSString *cjoin_code;
    NSString *coneClick;
    NSString *ctwoClick;
    NSString *ctwoListId;
    NSString *cinId;
    NSString *xxxxxxx;
    NSInteger clevel;
    NSInteger cmain_role;
    
    NSString *_title1;
    List *_listInfo;
    
    UILabel * _lbName;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    imJiantou = [UIImage imageNamed:@"cengjijiantou"];
    imGengduo = [UIImage imageNamed:@"gengduo"];
    _im1 = [[UIImageView alloc]init];
    [self addSubview:_im1];
    _im1.image =imJiantou;
    _im2.image = imGengduo;
    _im2.hidden = YES;
    _im1.hidden = YES;
    _lb1 = [[UILabel alloc]init];
    [self addSubview:_lb1];
    _lb1.textColor = kLabelText_Commen_Color_3;
    _lb1.font = FONT_SIZE(14);
    _lb2 = [[UILabel alloc]init];
    [self addSubview:_lb2];
    _lb2.textColor = kLabelText_Commen_Color_9;
    _lb2.font = FONT_SIZE(14);
    
//    _line = [[UIImageView alloc]init];
//    [self addSubview:_line];
//    _line.backgroundColor = kBackgroundColor;
//    _line.frame = CGRectMake(0, 39, SCREEN_WIDTH, 1);
        
        
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gegnduoEvent)];
    [self addGestureRecognizer:tap1];
    _lbName = [[UILabel alloc] init];
    _lbName.font = FONT_SIZE(14);
    _lbName.textColor = kLabelText_Commen_Color_6;
    [self addSubview:_lbName];
        
    _im2 = [[UIImageView alloc]init];
    _im2.image = imGengduo;
    [self addSubview:_im2];
    _im2.frame = CGRectMake(self.width - 10 - 6, (self.height - 11)/2.0, 6, 11);
        
    _btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn1.backgroundColor = [UIColor clearColor];
    [self addSubview:_btn1];
    _btn1.frame = CGRectMake(0, 0, 60, 40);
    [_btn1 addTarget:self action:@selector(gegnduoEvent) forControlEvents:UIControlEventTouchUpInside];
    _btn1.center = _im2.center;
        
    _bgScreenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:_bgScreenView];
    _bgScreenView.backgroundColor = [UIColor clearColor];
    _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    _blackView.backgroundColor = [UIColor blackColor];
    _blackView.alpha = 0.5;
    [_bgScreenView addSubview:_blackView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [_blackView addGestureRecognizer:tap];
    
    _workChoiceview = [[WorkChoiceView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-200)];
    [_bgScreenView addSubview:_workChoiceview];
    WeakSelf;
    _workChoiceview.WorkChoiceViewBlock = ^(NSString *join_code,NSString *oneClick,NSString *twoClick,NSString * twoListId,NSString *inId,NSInteger level,NSInteger main_role,NSString *title1,NSString *title2,List *listInfo) {
        [weakSelf refreshOrganizationalStructureView:title1 withTitle2:title2];
        cjoin_code = join_code;
        coneClick = oneClick;
        ctwoClick = twoClick;
        ctwoListId = twoListId;
        cinId = inId;
        clevel = level;
        _listInfo = listInfo;
        cmain_role = main_role;
        [weakSelf passValueMethod];
    };
    _bgScreenView.hidden = YES;
    }
    return self;
}
- (void)setIsOnLine:(BOOL)isOnLine
{
    _workChoiceview.isOnLine = isOnLine;
}
- (void)passValueMethod{
    if (_organizationalStructureViewBlock) {
        _organizationalStructureViewBlock(cjoin_code,coneClick,ctwoClick,ctwoListId,cinId,clevel,cmain_role,_listInfo);
    }
    
    if (_organizeStructureBlock) {
        COrganizeModel * model = [COrganizeModel createModelWithOneClick:coneClick twoClick:ctwoClick twoListId:ctwoListId inId:cinId thirdClick:ctwoClick forthClick:ctwoListId joinCode:cjoin_code level:clevel mainrole:0];
        if (_organizeStructureBlock) {
            _organizeStructureBlock(model);
        }
    }
}
- (void)gegnduoEvent{
    if (!_bgScreenView) {
        _bgScreenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [[UIApplication sharedApplication].keyWindow addSubview:_bgScreenView];
        _bgScreenView.backgroundColor = [UIColor clearColor];
    }else{
        _bgScreenView.hidden = NO;
    }
    if (!_blackView) {
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.5;
        [_bgScreenView addSubview:_blackView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_blackView addGestureRecognizer:tap];
    }else{
        _blackView.hidden = NO;
    }
    if (!_workChoiceview) {
        _workChoiceview = [[WorkChoiceView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-200)];
        [_bgScreenView addSubview:_workChoiceview];
    }else{
        _workChoiceview.hidden = NO;
    }
    WeakSelf;
    _workChoiceview.WorkChoiceViewBlock = ^(NSString *join_code,NSString *oneClick,NSString *twoClick,NSString * twoListId,NSString *inId,NSInteger level,NSInteger main_role,NSString *title1,NSString *title2,List *listInfo) {
        [weakSelf refreshOrganizationalStructureView:title1 withTitle2:title2];
        if (join_code) {
            cjoin_code = join_code;
        }
        if (oneClick) {
            coneClick = oneClick;
        }
        if (twoClick) {
            ctwoClick = twoClick;
        }
        if (twoListId) {
            ctwoListId = twoListId;
        }
        if (inId) {
            cinId = inId;
        }
        cmain_role = main_role;
        _listInfo = listInfo;
        [weakSelf tapAction:nil];
        [weakSelf passValueMethod];
    };
    _workChoiceview.WorkChoiceViewCancleBlock = ^{
        [weakSelf tapAction:nil];
    };
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    _bgScreenView.hidden = YES;
}
- (void)freshorganizationalView:(ZuZhiChoiceModel *)choiceModel{
    
        _lb2.text = choiceModel.name;
        xxxxxxx = choiceModel.name;
        if (choiceModel.name.length > 0) {
            [self setTitle2Str:xxxxxxx];
        }
        [_lb2 sizeToFit];
        _lb2.frame =CGRectMake(_im1.right+5, (49 - _lb2.height)/2.0, _lb2.width, _lb2.height);
    
    
    _lb2.hidden = YES;
    _lbName.text = [NSString stringWithFormat:@"%@ > %@",_lb1.text,_lb2.text];
    [_lbName sizeToFit];
    _lbName.frame = CGRectMake(10, (self.height - _lbName.height)/2, self.width - 20 - 6, _lbName.height);
}
- (void)refreshOrganizationalStructureView:(NSString *)title1 withTitle2:(NSString *)title2{
    _title1 = title1;
    _lb1.text = title1;
    [_lb1 sizeToFit];
    _lb1.frame =CGRectMake(15, (49 - _lb1.height)/2.0, _lb1.width, _lb1.height);
    if (title1) {
        _im1.hidden = NO;
    }
    _im1.frame = CGRectMake(_lb1.right+5, (49 - imJiantou.size.height)/2.0, imJiantou.size.width, imJiantou.size.height);
    
    if (![title1 isEqualToString:title2]) {
        _lb2.text = title2;
        xxxxxxx = title2;
        if (title2.length > 0) {
            [self setTitle2Str:xxxxxxx];
        }
        [_lb2 sizeToFit];
        _lb2.frame =CGRectMake(_im1.right+5, (49 - _lb2.height)/2.0, _lb2.width, _lb2.height);
    }else{
        _lb2.text = @"";
    }
    
    _lb2.hidden = YES;
    _lb1.hidden = YES;
    _im1.hidden = YES;
    _lbName.text = [NSString stringWithFormat:@"%@ > %@",_lb1.text,_lb2.text];
    [_lbName sizeToFit];
    _lbName.frame = CGRectMake(10, (self.height - _lbName.height)/2, self.width - 20 - 6, _lbName.height);
    
}

@end
