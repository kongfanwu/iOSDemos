//
//  XHMCouponMultipleAlertVC.m
//  xmh
//
//  Created by KFW on 2019/5/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XHMCouponMultipleAlertVC.h"
#import "XHMCouponMultipleAlertCell.h"

@interface XHMCouponMultipleAlertVC () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIView *contentView;
/** <##> */
@property (nonatomic, strong) UILabel *titleLabel;
/** <##> */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation XHMCouponMultipleAlertVC

- (UIModalPresentationStyle)modalPresentationStyle {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
        return UIModalPresentationOverCurrentContext;
    }
    return UIModalPresentationCurrentContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBColor(146, 146, 146);
    
    UIControl *bgViwe = [UIControl new];
    bgViwe.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:bgViwe];
    [bgViwe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    __weak typeof(self) _self = self;
    [bgViwe bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.contentView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = FONT_SIZE(17);
    [_contentView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(_contentView);
        make.left.mas_equalTo(5);
    }];
    [cancelBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    sureBtn.titleLabel.font = FONT_SIZE(17);
    [_contentView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(_contentView);
        make.right.mas_equalTo(-5);
    }];
    [sureBtn bk_addEventHandler:^(id sender) {
        __strong typeof(_self) self = _self;
        
        NSMutableArray *selectList = NSMutableArray.new;
        for (XMHItemModel *itemModel in self.dataArray) {
            if ([itemModel.idStr isEqualToString:@"all"]) {
                continue;
            }
            if (itemModel.isSelect) {
                [selectList addObject:itemModel];
            }
        }
        XMHItemModel *allItemModel = self.dataArray.firstObject;
        
        if (self.selectBlock) self.selectBlock(selectList, allItemModel.isSelect);
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kSeparatorColor;
    [_contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(cancelBtn.mas_bottom);
    }];
    
//    self.titleLabel = [UILabel new];
//    _titleLabel.text = _titleStr;
//    _titleLabel.textColor = kColor3;
//    _titleLabel.font = FONT_SIZE(17);
//    [_contentView addSubview:_titleLabel];
//    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lineView.mas_bottom).offset(20);
//        make.left.mas_equalTo(15);
//    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.width, 44);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = UIColor.whiteColor;
    [_contentView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).offset(20);
        make.bottom.mas_equalTo(-kSafeAreaBottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    [_collectionView registerClass:[XHMCouponMultipleAlertCell class] forCellWithReuseIdentifier:@"cell"];
    
    // 设置默认选中项
    if (_dataArrayAll) {
        for (XMHItemModel *itemModel in self.dataArray) {
            itemModel.isSelect = YES;
        }
    } else {
        NSMutableArray *newSelectArray = NSMutableArray.new;
        for (XMHItemModel *selectItemModel in _selectArray) {
            for (XMHItemModel *itemModel in self.dataArray) {
                if ([selectItemModel.idStr isEqualToString:itemModel.idStr]) {
                    itemModel.isSelect = YES;
                    [newSelectArray addObject:itemModel];
                }
            }
        }
        if (!_edit) {
            self.dataArray = newSelectArray;            
        }
    }
    [self changeSelectAllButtonState];
    
    [_collectionView reloadData];
    
    if (!_edit) {
        sureBtn.hidden = YES;
        _titleLabel.hidden = YES;
        
        [cancelBtn setTitleColor:kColor6 forState:UIControlStateNormal];
        [cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(44, 44));
            make.top.equalTo(_contentView);
            make.right.mas_equalTo(-5);
        }];
        
        [_collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(20);
            make.bottom.mas_equalTo(-kSafeAreaBottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
        
        // 非编辑，移除全选按钮
        XMHItemModel *allItemModel = self.dataArray.firstObject;
        if ([allItemModel.idStr isEqualToString:@"all"] || [allItemModel.title isEqualToString:@"全选"]) {
            NSMutableArray *newDataArray = [self.dataArray mutableCopy];
            [newDataArray removeObject:allItemModel];
            self.dataArray = newDataArray;
            [_collectionView reloadData];
        }
    }
}

/**
 处理按钮全选/非全选情况。 设置全选按钮状态
 */
- (void)changeSelectAllButtonState {
    BOOL isSelectAll = YES;
    for (XMHItemModel *itemModel in _dataArray) {
        if ([itemModel.idStr isEqualToString:@"all"]) {
            continue;
        }
        if (!itemModel.isSelect ) {
            isSelectAll = NO;
            break;
        }
    }
    
    XMHItemModel *allItemModel = _dataArray.firstObject;
    allItemModel.isSelect = isSelectAll;
}

#pragma mark - Lazy

- (UIView *)contentView {
    if (_contentView) return _contentView;
    
    CGFloat contentViewHeight = self.view.height * 0.5;
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - contentViewHeight, self.view.width, contentViewHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    // 左上和右上为圆角
    UIBezierPath *cornerRadiusPath = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    
    CAShapeLayer *cornerRadiusLayer = [[CAShapeLayer alloc ] init];
    cornerRadiusLayer.frame = _contentView.bounds;
    cornerRadiusLayer.path = cornerRadiusPath.CGPath;
    _contentView.layer.mask = cornerRadiusLayer;
    return _contentView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XHMCouponMultipleAlertCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.edit = _edit;
    [cell configureWithModel:_dataArray[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!_edit) return;
    
    XMHItemModel *itemModel = _dataArray[indexPath.item];
    // 全选
    if ([itemModel.idStr isEqualToString:@"all"]) {
        itemModel.isSelect = !itemModel.isSelect;
        
        for (XMHItemModel *aitemModel in _dataArray) {
            aitemModel.isSelect = itemModel.isSelect;
        }
    } else {
        itemModel.isSelect = !itemModel.isSelect;
        [self changeSelectAllButtonState];
    }
    
    
    [collectionView reloadData];
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
