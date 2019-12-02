//
//  CjView.m
//  xmh
//
//  Created by ald_ios on 2018/9/26.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "CjView.h"
#import "ShareWorkInstance.h"
#import "RolesTools.h"
#define kLeftMargin 15
#define kRightMargin 15
#define kMiddleMargin 10
@implementation CjView
{
    UIButton * _selectBtn;
    NSInteger  _tmpTag;
    NSString * _twoClick;
    NSString * _twoListId;
    NSString * _oneClick;
    NSMutableDictionary * _cjDict;  //保存选中的层级数据
    NSMutableDictionary * _startDict; //保存最开始层级数据
    BOOL _isFirst;
    BOOL _isOnline;
    BOOL _isOrder;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tmpTag = 10;
        self.backgroundColor = [UIColor whiteColor];
        _isFirst = YES;
        [self createCengJiView:[RolesTools getCengJiQuanXian]];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame isOrder:(BOOL)isOrder
{
    self = [super initWithFrame:frame];
    if (self) {
        _tmpTag = 10;
        self.backgroundColor = [UIColor whiteColor];
        _isFirst = YES;
        _isOrder = isOrder;
        [self createCengJiView:[RolesTools getCengJiQuanXian]];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame isOnline:(BOOL)isOnline
{
    self = [super initWithFrame:frame];
    if (self) {
        _tmpTag = 10;
        self.backgroundColor = [UIColor whiteColor];
        _isFirst = YES;
        _isOnline = isOnline;
        [self createCengJiView:[RolesTools getCengJiQuanXian]];
    }
    return self;
}
- (void)createCengJiView:(NSInteger)tag;
{

    NSArray * arr = nil;
    if (tag == 0) {
        if (_isOnline) {
           arr = @[@"层级",@"门店",@"商品"];
        }else{
           arr = @[@"层级",@"门店",@"员工"];
        }
        if (_tmpTag != tag) {
            [self createSegementView:arr];
            return;
        }
        _tmpTag = tag;
        
    }else if (tag ==1){
        if (_isOnline) {
             arr = @[@"门店",@"商品"];
        }else{
             arr = @[@"门店",@"员工",@"顾客"];
        }
        if (_tmpTag != tag) {
            [self createSegementView:arr];
            return;
        }
        _tmpTag = tag;
    }else if(tag ==2){
        arr = @[@"员工",@"顾客"];
        if (_tmpTag != tag) {
            [self createSegementView:arr];
            return;
        }
        _tmpTag = tag;
    }else{}
}
- (void)createSegementView:(NSArray *)arr
{
    CGFloat btnW = (SCREEN_WIDTH - kLeftMargin * 2 - (arr.count -1)* kMiddleMargin)/arr.count;
    CGFloat btnH = 25;
    for (int i = 0 ; i < arr.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(15 + (kMiddleMargin + btnW)* i, (55 - btnH)/2, btnW, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = kBtn_Commen_Color.CGColor;
        [btn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
        if ((arr.count ==2)&& [arr containsObject:@"顾客"]&& _isOrder) {
            if (i == 1) {
                [self btnClick:btn];
            }
        }else{
            if (i ==0) {
                [self btnClick:btn];
            }
        }
        
        [self addSubview:btn];
    }
}
- (void)btnClick:(UIButton *)btn
{
    _selectBtn.selected = NO;
    _selectBtn.backgroundColor = [UIColor whiteColor];
    _selectBtn.layer.borderWidth = 1;
    _selectBtn.layer.borderColor = kBtn_Commen_Color.CGColor;
    [_selectBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateNormal];
    btn.selected = YES;
    btn.backgroundColor = kBtn_Commen_Color;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _selectBtn = btn;

    NSArray * framList = [ShareWorkInstance shareInstance].share_join_code.fram_list;
    if ([btn.currentTitle isEqualToString:@"门店"]) {
        for (Fram_List * listSub in framList) {
            if (listSub.level == 0) {
                NSString * twoListID = [NSString stringWithFormat:@"%ld",listSub.fram_name_id];
                [_cjDict setValue:twoListID forKey:@"TwoListID"];
                [_cjDict setValue:@"all" forKey:@"TwoClick"];
                if (_CJViewBlock) {
                    _CJViewBlock(_cjDict);
                }
                return;
            }
        }
    }else if([btn.currentTitle isEqualToString:@"层级"]){
        if (_CJViewBlock) {
            _CJViewBlock(_startDict);
        }
    }else if ([btn.currentTitle isEqualToString:@"员工"]){
        NSString * loginFramNameID = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
        if ([_startDict[@"OneClick"]isEqualToString:loginFramNameID]) {//判断是否选择了组织架构的内容
            for (Fram_List * listSub in framList) {
                if (listSub.level == -2) {
                    NSString * twoListID = [NSString stringWithFormat:@"%ld",listSub.fram_name_id];
                    [_cjDict setValue:twoListID forKey:@"TwoListID"];
                    [_cjDict setValue:@"all" forKey:@"TwoClick"];
                    if (_CJViewBlock) {
                        _CJViewBlock(_cjDict);
                    }
                    return;
                }
            }
        }else{
            if (_CJViewBlock) {
                _CJViewBlock(_cjDict);
            }
        }
    }else if([btn.currentTitle isEqualToString:@"商品"]){
        NSString * loginFramNameID = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
        [_cjDict setValue:@"all" forKey:@"ThreeClick"];
        [_cjDict setValue:@"-1" forKey:@"FourClick"];
        if ([_startDict[@"OneClick"]isEqualToString:loginFramNameID]) {//判断是否选择了组织架构的内容
            if (_CJViewBlock) {
                _CJViewBlock(_startDict);
            }
        }else{
            if (_CJViewBlock) {
                _CJViewBlock(_cjDict);
            }
        }
       
    }else if([btn.currentTitle isEqualToString:@"顾客"]){
        NSString * loginFramNameID = [NSString stringWithFormat:@"%ld",[ShareWorkInstance shareInstance].share_join_code.fram_id];
        if ([_startDict[@"OneClick"]isEqualToString:loginFramNameID]) {//判断是否选择了组织架构的内容
            for (Fram_List * listSub in framList) {
                if (listSub.level == -100) {
                    NSString * twoListID = [NSString stringWithFormat:@"%ld",listSub.fram_name_id];
                    [_cjDict setValue:twoListID forKey:@"TwoListID"];
                    [_cjDict setValue:@"all" forKey:@"TwoClick"];
                    if (_CJViewBlock) {
                        _CJViewBlock(_cjDict);
                    }
                    return;
                }
            }
        }else{
            if (_CJViewBlock) {
                _CJViewBlock(_cjDict);
            }
        }
    }else{}
}
- (void)setCJParam:(NSMutableDictionary *)cjDict
{
    _cjDict  = cjDict;
    if (_isFirst) {
        _startDict = [[NSMutableDictionary alloc] initWithDictionary:cjDict];
        _isFirst = NO;
    }
    
}
@end
