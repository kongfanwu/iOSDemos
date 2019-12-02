//
//  BeeTagView.m
//  xmh
//
//  Created by Ss H on 2018/11/17.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "BeeTagView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "MzzAddButtonCollectionViewCell.h"
#import "MzzAddPortraitsectionHeardView.h"
#import "MzzTags.h"
#import "BeautyChoiceJishi.h"

@interface BeeTagView () <UICollectionViewDataSource,UICollectionViewDelegate>
{
    float _collectionViewHeight; // 高度
    UIColor *_textColor; // 文字颜色
    UIColor *_cellColor; // cell背景颜色
    UIColor *_cellBorderColor; // cell边框颜色
    MzzTag *tagModel;
    BeautyChoiceJishi    *_beautyChoiceJishi;
    NSMutableArray *titleArray;
    customNav *nav;
}

@property (nonatomic,strong)UICollectionViewLeftAlignedLayout *layout;
@property (nonatomic,strong)NSMutableArray *selectArray;//保存点击的标签数组
@property (nonatomic,strong)NSMutableArray *screenArray;//筛选出的数组
@property (nonatomic,strong)NSString *screenTitle;//选中的类别标题
@property (nonatomic,strong)UIButton *sureButton;
@end

@implementation BeeTagView
-(NSMutableArray *)selectArray
{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
-(NSMutableArray *)screenArray
{
    if (!_screenArray) {
        _screenArray = [NSMutableArray array];
    }
    return _screenArray;
}
-(UIButton *)sureButton
{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] initWithFrame:CGRectMake(15, self.myCollectionView.bottom+10, SCREEN_WIDTH-30, 44)];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureButton.backgroundColor =kBtn_Commen_Color;
        [_sureButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}
- (UICollectionView *)myCollectionView
{
    if (!_myCollectionView) {
        _layout = [[UICollectionViewLeftAlignedLayout alloc]init];
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, Heigh_Nav+54, SCREEN_WIDTH, SCREEN_HEIGHT-Heigh_Nav-90-54) collectionViewLayout:_layout];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        // 1.设置列间距
        _layout.minimumInteritemSpacing = self.minitemSpace;
        // 2.设置行间距
        _layout.minimumLineSpacing = self.minlineSpace;
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        [_myCollectionView registerClass:[MzzAddButtonCollectionViewCell class] forCellWithReuseIdentifier:@"MzzAddButtonCollectionViewCell"];
        [_myCollectionView registerNib:[UINib nibWithNibName:@"MzzAddPortraitsectionHeardView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        
    }
    return _myCollectionView;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        MzzAddPortraitsectionHeardView *headerView = (MzzAddPortraitsectionHeardView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        MzzSectionTags *sectionTags = self.tagArr[indexPath.section];
        if ([self.screenTitle isEqualToString:@"全部分类"]||self.screenTitle.length == 0){
            headerView.titleLabel.text =sectionTags.name;
        }else{
            MzzSectionTags *screenTags = self.screenArray[0];
            headerView.titleLabel.text =screenTags.name;
        }
        reusableView = headerView;
    }
    return reusableView;
    
}
- (void)creatNav{
    if (!nav) {
        nav = [[customNav alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, Heigh_Nav) withTitleStr:@"顾客标签" withleftImageStr:@"stgkgl_fanhui" withRightStr:nil];
        nav.lineImageView.hidden = YES;
        nav.backgroundColor = kBtn_Commen_Color;
        nav.lbTitle.textColor = [UIColor whiteColor];
        [nav.btnLet addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nav];
    }
}
-(void)pop{
    [self removeFromSuperview];
    if (_popToRoot) {
        _popToRoot();
    }
}

// 设置区头尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(collectionView.frame.size.width, 50);
    return size;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([self.screenTitle isEqualToString:@"全部分类"]||self.screenTitle.length == 0){
        return self.tagArr.count;
    }else{
        return self.screenArray.count;
    }
}

- (id)initWithTextArr:(NSMutableArray *)textArr TextColor:(UIColor *)textColor CellBackColor:(UIColor *)cellBackColor CellBorderColor:(UIColor *)borderColor
{
    self = [super init];
    self = [[[NSBundle mainBundle] loadNibNamed:@"BeeTagView" owner:self options:nil] lastObject];
    if (self) {

        [self.classificationButton setImage:[UIImage imageNamed:@"paiming_xiala"] forState:UIControlStateNormal];
        [self.classificationButton setTitle:@"全部分类" forState:UIControlStateNormal];
        [self.classificationButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - self.classificationButton.imageView.image.size.width-5, 0, self.classificationButton.imageView.image.size.width)];
        [self.classificationButton setImageEdgeInsets:UIEdgeInsetsMake(0, self.classificationButton.titleLabel.bounds.size.width+5, 0, -self.classificationButton.titleLabel.bounds.size.width)];
        
        _collectionViewHeight = 0;
        self.collectionViewMaxHeight = MAXFLOAT;
        self.topViewConstraint.constant = Heigh_Nav;
        _textColor = textColor;
        _cellColor = cellBackColor;
        _cellBorderColor = borderColor;
        if (borderColor) {
            self.cellBorderWidth = 1;
        }else{
            self.cellBorderWidth = 0;
        }
        
        self.tagArr = textArr;
        self.edgeInset = UIEdgeInsetsMake(5, 15, 15, 15);
        self.minitemSpace = 10;
        self.minlineSpace = 10;
        self.textInterval = 15;
        self.cellHeight = 35;
        self.textFont = 15;
        tagModel = [[MzzTag alloc] init];

        [self addSubview:self.myCollectionView];
        [self addSubview:self.sureButton];
        titleArray = [NSMutableArray array];
        [titleArray addObject:@"全部分类"];
        
        [self creatNav];
    }
    
    return self;
}

/**
 全部分类点击事件
 */
- (IBAction)classificationAction:(id)sender {
    [self.screenArray removeAllObjects];
    //获取类别中的标题
    for (MzzSectionTags *sectionTags in self.tagArr) {
        [titleArray addObject:sectionTags.name];
    }
    [self creatTopChooseView];
    [_beautyChoiceJishi refreshGuKeLeiBie:titleArray withTitle:@"请选择类别"];
    WeakSelf;
    _beautyChoiceJishi.GuKeBlock = ^(NSString *choose) {
        if (choose.length != 0) {
            [weakSelf.classificationButton setTitle:choose forState:UIControlStateNormal];
            weakSelf.screenTitle = choose;
            [weakSelf screeningModel:choose];
        }
    };
}

/**
 筛选符合条件的数据
 */
-(void)screeningModel:(NSString *)title{
    
    for (MzzSectionTags *sectionTags in self.tagArr) {
        if ([sectionTags.name isEqualToString:title]) {
            [self.screenArray addObject:sectionTags];
        }
    }
    [self.myCollectionView reloadData];
}

- (void)creatTopChooseView{
    if (!_beautyChoiceJishi) {
        _beautyChoiceJishi = [[[NSBundle mainBundle]loadNibNamed:@"BeautyChoiceJishi" owner:nil options:nil] firstObject];
        _beautyChoiceJishi.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:_beautyChoiceJishi];
        [self bringSubviewToFront:_beautyChoiceJishi];
    }else{
        _beautyChoiceJishi.hidden = !_beautyChoiceJishi.hidden;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    MzzSectionTags *sectionTags = self.tagArr[section];

    if ([self.screenTitle isEqualToString:@"全部分类"]||self.screenTitle.length == 0) {
        return sectionTags.content_list.count;
    }else{
        MzzSectionTags *screenTags = self.screenArray[0];
        return screenTags.content_list.count;

    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MzzAddButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MzzAddButtonCollectionViewCell" forIndexPath:indexPath];
    
    cell.backgroundColor = _cellColor;
    MzzSectionTags *sectionTags = self.tagArr[indexPath.section];
    
    if ([self.screenTitle isEqualToString:@"全部分类"]||self.screenTitle.length == 0){
        tagModel = sectionTags.content_list[indexPath.row];
    }else{
        MzzSectionTags *screenTags = self.screenArray[0];
        tagModel = screenTags.content_list[indexPath.row];
    }
    
    if (tagModel.is_select == 1) {
        [cell setTheLabeValueWithFont:_textFont textColor:kBackgroundColor_FF9072 borderWidth:self.cellBorderWidth borderColor:kBackgroundColor_FF9072 cornerRadius:self.cellCornerRadius andContent:tagModel.content withBackGroundColor:kBackgroundColor_FF3F0];
        if (![self.selectArray containsObject:@(tagModel.content_id)]) {
            [self.selectArray addObject:@(tagModel.content_id)];
        }
    }else{
        [cell setTheLabeValueWithFont:_textFont textColor:kIm_Background_Color_c borderWidth:self.cellBorderWidth borderColor:kLabelText_Commen_Color_F5 cornerRadius:self.cellCornerRadius andContent:tagModel.content withBackGroundColor:kLabelText_Commen_Color_F5];
        [self.selectArray removeObject:@(tagModel.content_id)];
    }
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    MzzSectionTags *sectionTags = self.tagArr[indexPath.section];
    if ([self.screenTitle isEqualToString:@"全部分类"]||self.screenTitle.length == 0){
        tagModel = sectionTags.content_list[indexPath.row];
    }else{
        MzzSectionTags *screenTags = self.screenArray[0];

        tagModel = screenTags.content_list[indexPath.row];
    }
    CGSize thesize = [tagModel.content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_textFont]}];
    return CGSizeMake(thesize.width + self.textInterval*2, self.cellHeight);
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.edgeInset;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MzzAddButtonCollectionViewCell *cell = (MzzAddButtonCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    MzzSectionTags *sectionTags = self.tagArr[indexPath.section];
    if ([self.screenTitle isEqualToString:@"全部分类"]||self.screenTitle.length == 0){
        tagModel = sectionTags.content_list[indexPath.row];
    }else{
        MzzSectionTags *screenTags = self.screenArray[0];

        tagModel = screenTags.content_list[indexPath.row];
    }
    if ([cell.content.textColor isEqual:kBackgroundColor_FF9072]) {

        tagModel.is_select = 0;
    }else{

        tagModel.is_select = 1;
    }
    [self.myCollectionView reloadData];
}

- (void)back{
    if (self.didselectBlock) {
        self.didselectBlock(self.selectArray);
    }
}


@end
