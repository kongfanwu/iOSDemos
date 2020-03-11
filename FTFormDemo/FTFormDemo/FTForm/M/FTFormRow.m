//
//  FTFormRow.m
//  FTFormDemo
//
//  Created by KFW on 2019/9/9.
//  Copyright © 2019 KFW. All rights reserved.
//

#import "FTFormRow.h"
#import "FTFormHeader.h"

NSString * const KVOKeyPath_Value = @"value";

@interface FTFormRow()
/** 获取是否可编辑状态 */
@property (nonatomic) BOOL isEnable;
/** 获取是否隐藏状态 */
@property (nonatomic) BOOL isHiden;
/** <##> */
@property (nonatomic, weak) FTFormRow *hiddenRow, *enableRow;
/** <##> */
@property (nonatomic, strong) NSPredicate *hiddenPredicate;
@property (nonatomic, strong) NSPredicate *enablePredicate;
@end

@implementation FTFormRow

#pragma mark - 重写

- (void)dealloc
{
    [self removeObserver:self forKeyPath:KVOKeyPath_Value];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isEnable = YES;
//        _cellStyle = UITableViewCellStyleDefault;
        [self addObserver:self forKeyPath:KVOKeyPath_Value options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//        [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (FTFormAction *)action {
    if (_action) return _action;
    _action = FTFormAction.new;
    return _action;
}

- (FTFormUniversalConversion *)universalConversion {
    if (_universalConversion) return _universalConversion;
    _universalConversion = FTFormUniversalConversion.new;
    _universalConversion.row = self;
    return _universalConversion;
}

- (FTFormParamVerify *)paramVerify {
    if (_paramVerify) return _paramVerify;
    _paramVerify = FTFormParamVerify.new;
    _paramVerify.row = self;
    return _paramVerify;
}

- (void)setHidden:(id)hidden {
    _hidden = hidden;
    
    if ([hidden isKindOfClass:[NSString class]]) {
        
        //        @"gukeguanli.value=1"
        NSString *hiddenStr = (NSString *)_hidden;
        NSArray *dianArray = [hiddenStr componentsSeparatedByString:@"."];
        NSString *tag = dianArray.firstObject;
        NSString *predicateFormat = dianArray.lastObject;
        
        for (FTFormRow *row in self.formSection.formRows) {
            if ([row.tag isEqualToString:tag]) {
                self.hiddenRow = row;
                break;
            }
        }
        
        self.hiddenPredicate = [NSPredicate predicateWithFormat:predicateFormat];
        
        // add KVO
        [_hiddenRow addObserver:self forKeyPath:KVOKeyPath_Value options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        [self checkHidden];
    }
}

/**
 校验hidden
 */
- (void)checkHidden {
    self.isHiden = [_hiddenPredicate evaluateWithObject:_hiddenRow];
    NSLog(@"self.isHiden = %d", self.isHiden);
    [self raloadTableView];
}

- (void)setEnable:(id)enable {
    _enable = enable;
    if ([enable isKindOfClass:[NSString class]]) {
//        @"name.value == NULL";
        NSString *hiddenStr = (NSString *)_enable;
        NSArray *dianArray = [hiddenStr componentsSeparatedByString:@"."];
        NSString *tag = dianArray.firstObject;
        NSString *predicateFormat = dianArray.lastObject;
        
        for (FTFormRow *row in self.formSection.formRows) {
            if ([row.tag isEqualToString:tag]) {
                self.enableRow = row;
                break;
            }
        }
        
        self.enablePredicate = [NSPredicate predicateWithFormat:predicateFormat];
        
        // add KVO
        [_enableRow addObserver:self forKeyPath:KVOKeyPath_Value options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        [self checkEnable];
    }
}

/**
 校验hidden
 */
- (void)checkEnable {
    self.isEnable = ![_enablePredicate evaluateWithObject:_enableRow];
    NSLog(@"self.isEnable = %d", self.isEnable);
    [self raloadTableView];
}

/**
 刷新table
 */
- (void)raloadTableView {
    UITableViewController *tableVC = (UITableViewController *)self.cell.viewController;
    [tableVC.tableView reloadData];
}

#pragma mark - KVO
//当key路径对应的属性值发生改变时，监听器就会回调自身的监听方法，如下
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)contex {
    // 监听自己的value,刷新
    if ([keyPath isEqualToString:KVOKeyPath_Value] && object == self) {
        [self raloadTableView];
        
        UITableViewController <FTFormVCProtocol> *tableVC = (UITableViewController <FTFormVCProtocol> *)self.cell.viewController;
        if ([tableVC respondsToSelector:@selector(rowValueDidChangeRow:newValue:oldValue:)]) {
            [tableVC rowValueDidChangeRow:self newValue:change[NSKeyValueChangeNewKey] oldValue:self.value];
        }
    }
    // 监听value，处理 hidden
    else if ([keyPath isEqualToString:KVOKeyPath_Value] && object == _hiddenRow) {
        [self checkHidden];
    }
    // 监听value, 处理 enable
    else if ([keyPath isEqualToString:KVOKeyPath_Value] && object == _enableRow) {
        [self checkEnable];
    }
}


@end
