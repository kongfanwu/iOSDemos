//
//  XMHCredentiaItemView.m
//  xmh
//
//  Created by KFW on 2019/4/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHCredentiaItemView.h"
#import "XMHCredentialtenCell.h"
#import "UIView+FTCornerdious.h"

CGFloat const XMHCredentiaItemView_MaxHeight = 20 + 220 + 40 + 20;//273;
CGFloat const XMHCredentiaItemView_MinHeight = 20 + 110 + 40 + 20;

@interface XMHCredentiaItemView() <UICollectionViewDelegate, UICollectionViewDataSource>
/** 展开收状态 */
@property (nonatomic) BOOL isZhanKai;

/** <##> */
@property (nonatomic, strong) UIView *contentView, *topView;
/** <##> */
@property (nonatomic, strong) UIView *topLineView;
/** <##> */
@property (nonatomic, strong) UIButton *leftBtn, *rightBtn;
/** <##> */
@property (nonatomic, strong) UICollectionView *collectionView;
/** <##> */
@property (nonatomic, strong) UIButton *arrowBtn;
@end

@implementation XMHCredentiaItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.isZhanKai = YES;
        _type = XMHCredentiaItemViewTypeVendition;
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.width - 20, self.height - 20)];
        [self addSubview:_contentView];
        _contentView.backgroundColor = UIColor.whiteColor;
        [UIView addShadowToView:self.contentView withOpacity:0.3 shadowRadius:5 andCornerRadius:5];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-10);
        }];
        
        [self createTopView];
        
        UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.arrowBtn = arrowBtn;
        // stgkgl_zhankai 下 stgkgl_shouqi 上
        [arrowBtn setImage:UIImageName(@"stgkgl_shouqi") forState:UIControlStateNormal];
        [arrowBtn setImage:UIImageName(@"stgkgl_zhankai") forState:UIControlStateSelected];
        [_contentView addSubview:arrowBtn];
        [arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(34, 20));
            make.centerX.equalTo(_contentView);
            make.bottom.equalTo(_contentView);
        }];
        __weak typeof(self) _self = self;
        [arrowBtn bk_addEventHandler:^(UIButton * sender) {
            __strong typeof(_self) self = _self;
            self.isZhanKai = !self.isZhanKai;
            
            sender.selected = !self.isZhanKai;
            
            if (self.isZhanKai) {
                self.height = XMHCredentiaItemView_MaxHeight;
            } else {
                self.height = XMHCredentiaItemView_MinHeight;
            }
            if (self.didChangeHeightBlock) self.didChangeHeightBlock();
            
            self.contentView.frame = CGRectMake(10, 10, self.width - 20, self.height - 20);
            [UIView addShadowToView:self.contentView withOpacity:0.3 shadowRadius:5 andCornerRadius:5];
        } forControlEvents:UIControlEventTouchUpInside];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.1;
        layout.minimumInteritemSpacing = 0.1;
        layout.itemSize = CGSizeMake(self.width / 2.f, 35 + 20);
        layout.sectionInset = UIEdgeInsetsZero;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.footerReferenceSize = CGSizeZero;
        layout.headerReferenceSize = CGSizeZero;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, XMHCredentiaItemView_MaxHeight - 40 - 20 - 20) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColor.clearColor;
        [_contentView addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_contentView);
            make.top.equalTo(_topView.mas_bottom);
            make.bottom.equalTo(arrowBtn.mas_top);
        }];
        
        [_collectionView registerClass:[XMHCredentialtenCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

- (void)createTopView {
    self.topView = UIView.new;
    [_contentView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_contentView);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kColorE5E5E5;
    [_topView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kSeparatorHeight);
        make.left.right.bottom.equalTo(_topView);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn = leftBtn;
    [leftBtn setTitle:@"销售凭证" forState:UIControlStateNormal];
    [leftBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [leftBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    leftBtn.titleLabel.font = FONT_SIZE(14);
    [_topView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(39);
        make.right.equalTo(_topView.mas_centerX).offset(-17);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = rightBtn;
    [rightBtn setTitle:@"服务凭证" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kColor6 forState:UIControlStateNormal];
    [rightBtn setTitleColor:kBtn_Commen_Color forState:UIControlStateSelected];
    rightBtn.titleLabel.font = FONT_SIZE(14);
    [_topView addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(39);
        make.left.equalTo(_topView.mas_centerX).offset(17);
    }];
    
    self.topLineView = UIView.new;
    _topLineView.backgroundColor = kBtn_Commen_Color;
    _topLineView.layer.cornerRadius = 1.5;
    _topLineView.layer.masksToBounds = YES;
    [_topView addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(3);
        make.bottom.equalTo(_topView).offset(-1);
        make.width.left.equalTo(leftBtn);
    }];
    
    [self selectClick:leftBtn];
}

- (void)selectClick:(UIButton *)sender {
    if (sender == _leftBtn) {
        _leftBtn.selected = YES;
        _rightBtn.selected = NO;
        _type = XMHCredentiaItemViewTypeVendition;
    } else {
        _leftBtn.selected = NO;
        _rightBtn.selected = YES;
        _type = XMHCredentiaItemViewTypeService;
    }
    
    [_topLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(3);
        make.bottom.equalTo(_topView).offset(-1);
        make.width.left.equalTo(sender);
    }];
    
    [_collectionView reloadData];
    
    if (self.didChangeCredentiaTypeBlock) self.didChangeCredentiaTypeBlock(self);
}

- (void)setVenditionDataArray:(NSArray *)venditionDataArray {
    _venditionDataArray = venditionDataArray;
    [_collectionView reloadData];
}

- (void)setServiceDataArray:(NSArray *)serviceDataArray {
    _serviceDataArray = serviceDataArray;
    [_collectionView reloadData];
}

- (void)setType:(XMHCredentiaItemViewType)type {
    _type = type;
    if (_type == XMHCredentiaItemViewTypeVendition) {
        [self selectClick:_leftBtn];
    } else {
        [self selectClick:_rightBtn];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_type == XMHCredentiaItemViewTypeVendition) {
        return _venditionDataArray.count;
    } else if (_type == XMHCredentiaItemViewTypeService) {
        return _serviceDataArray.count;
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMHCredentialtenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (_type == XMHCredentiaItemViewTypeVendition) {
        [cell configModel:_venditionDataArray[indexPath.item]];
    } else if (_type == XMHCredentiaItemViewTypeService) {
        [cell configModel:_serviceDataArray[indexPath.item]];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(floor(collectionView.width / 2.f), 35 + 20);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMHCredentiaItemModel *model;
    if (_type == XMHCredentiaItemViewTypeVendition) {
        model = _venditionDataArray[indexPath.item];
    } else if (_type == XMHCredentiaItemViewTypeService) {
        model = _serviceDataArray[indexPath.item];
    }
    if (self.didSelectItemAtIndexPathBlock) self.didSelectItemAtIndexPathBlock(self, indexPath, model);
}

@end
