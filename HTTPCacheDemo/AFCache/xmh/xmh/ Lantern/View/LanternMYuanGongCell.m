//
//  LanternMYuanGongCell.m
//  xmh
//
//  Created by ald_ios on 2019/2/20.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "LanternMYuanGongCell.h"
#import "LanternMProCell.h"
#import "LanternMProHeaderView.h"
#define kCollectionViewSectionHeaderH 30
#define kCollectionViewCellH 30
#define kCollectionViewMargin 10

@interface LanternMYuanGongCell ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)NSInteger selectSection;
@property (nonatomic, assign)NSInteger selectIndex;
@property (nonatomic, assign)BOOL isFilter;
@property (nonatomic, strong)NSMutableDictionary * selectParam;
@property (nonatomic, assign)BOOL isShow;
@end
@implementation LanternMYuanGongCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.mainCollectionView];
    }
    return self;
}
- (UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 20 - 15 *5) / 4, kCollectionViewSectionHeaderH);
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
//        layout.minimumLineSpacing = 10;
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _mainCollectionView.width = SCREEN_WIDTH - [ShareWorkInstance shareInstance].showW ;
        _mainCollectionView.dataSource = self;
        _mainCollectionView.delegate = self;
        _mainCollectionView.scrollEnabled = YES;
        _mainCollectionView.bounces = NO;
        _mainCollectionView.scrollEnabled = NO;
        _mainCollectionView.showsVerticalScrollIndicator = NO;
        _mainCollectionView.backgroundColor = [UIColor whiteColor];
        [_mainCollectionView registerNib:[UINib nibWithNibName:@"LanternMProCell" bundle:nil] forCellWithReuseIdentifier:@"LanternMProCell"];
        [_mainCollectionView registerNib:[UINib nibWithNibName:@"LanternMProHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//        _mainCollectionView.backgroundColor = [UIColor redColor];
    }
    return _mainCollectionView;
}
#pragma mark ------UICollectionViewDelegate------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    WeakSelf
    if (kind == UICollectionElementKindSectionHeader) {
        LanternMProHeaderView *headerView = (LanternMProHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        headerView.bottomLine.hidden = !_isShow;
        headerView.topLine.hidden = !_isShow;
        headerView.LanternMProHeaderViewTapBlock = ^(NSInteger index) {
            if (indexPath.section ==0) {
                
            }else{
                [weakSelf.dataSource[weakSelf.selectSection] setValue:@(0) forKey:@"selected"];
                [weakSelf.dataSource[index] setValue:@(1) forKey:@"selected"];
                weakSelf.selectSection = index;
                [weakSelf.mainCollectionView reloadData];
            }

        };
        headerView.LanternMProHeaderViewMoreBlock = ^(NSMutableDictionary *param){
            if (weakSelf.LanternMYuanGongCellBlock) {
                weakSelf.LanternMYuanGongCellBlock(param);
            }
        };
        
        [headerView updateViewParam:_dataSource[indexPath.section] module:0];
//        [headerView updateViewParam:_dataSource[indexPath.section] section:indexPath.section module:0];
        reusableView = headerView;
    }
    return reusableView;
}
#pragma mark - UICollectionViewDelegateFlowLayout
// 设置区头尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(SCREEN_WIDTH - [ShareWorkInstance shareInstance].showW , kCollectionViewSectionHeaderH);
    return size;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LanternMProCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LanternMProCell" forIndexPath:indexPath];
    cell.LanternMProCellBlock = ^(NSMutableDictionary * _Nonnull param) {
        NSMutableArray * tempArr = _dataSource[indexPath.section][@"list"];
        for (int i = 0; i < tempArr.count; i++) {
            if (i != [tempArr indexOfObject:param]) {
                NSMutableDictionary * tempDic = tempArr[i];
                tempDic[@"select"] = @(NO);
            }
        }
        /** 替换自定义项 */
        if ([_dataSource[indexPath.section][@"list"] containsObject:param]) {
            [_dataSource[indexPath.section][@"list"] replaceObjectAtIndex:[_dataSource[indexPath.section][@"list"] indexOfObject:param] withObject:param];
        }
        [_mainCollectionView reloadData];
//        [_mainCollectionView performBatchUpdates:^{
//            [_mainCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
//        } completion:nil];
    };
    
    [cell updateCellParam:_dataSource[indexPath.section][@"list"][indexPath.row]];
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 0;
    return _dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * tempArr = _dataSource[section][@"list"];
    return tempArr.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{   NSMutableDictionary * dic = _dataSource[indexPath.section];
    /** 顾客标签可以多选 */
    if ([dic[@"name"]isEqualToString:@"顾客标签"]) {
        NSMutableDictionary * currentDic = _dataSource[indexPath.section][@"list"][indexPath.row];
        if ([currentDic[@"select"] boolValue]) {
            currentDic[@"select"] = @(NO);
        }else{
            currentDic[@"select"] = @(YES);
        }
    }else{
        for (int i = 0; i < [_dataSource[indexPath.section][@"list"] count]; i++) {
            NSMutableDictionary * currentDic = _dataSource[indexPath.section][@"list"][i];
            if ([currentDic[@"select"] boolValue]) {
                _selectParam = currentDic;
            }
        }
        NSMutableDictionary * currentDic = _dataSource[indexPath.section][@"list"][indexPath.row];
        if ([_selectParam isEqual: currentDic]) {
            if ([_selectParam[@"select"] boolValue]) {
                _selectParam[@"select"] = @(NO);
            }else{
                currentDic[@"select"] = @(YES);
            }
        }else{
            _selectParam[@"select"] = @(NO);
            currentDic[@"select"] = @(YES);
            //        _selectParam = currentDic;
        }
    }
    /** 自定义有文字时 选择非自定义的标签时 自定义文字清空 */
    NSMutableArray * customArr = _dataSource[indexPath.section][@"list"];
    for (int i = 0; i < customArr.count; i++) {
        NSMutableDictionary * customDic = customArr[i];
        if ([customDic.allKeys containsObject:@"custom"]) {
            [customDic setValue:@"" forKey:@"name"];
        }
    }
    
    
    [_mainCollectionView reloadData];
//    [_mainCollectionView performBatchUpdates:^{
//        [_mainCollectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
//    } completion:nil];
}
- (void)updateCellParam:(NSMutableArray *)param 
{
    
  
    NSInteger per = 0;
    if (_isFilter) {
        per = 3.0;
    }else{
        per = 4.0;
    }
    _dataSource = param;
    CGFloat cellHeight= 0.0;
    cellHeight = cellHeight + param.count * kCollectionViewSectionHeaderH;
    /** collectionView  cell高度 */
    NSInteger cellCount = 0;
    for (int i = 0; i < param.count; i++) {
        NSDictionary * tempDic = param[i];
//        CGFloat h = 0.0f;
        cellCount = [tempDic[@"list"] count];
        NSInteger line =  ceil(cellCount/per);
        cellHeight = cellHeight + (kCollectionViewCellH +kCollectionViewMargin)  * line ;
    }
//    cellHeight = cellHeight - kCollectionViewMargin;
    MzzLog(@"jisuan...........%f",cellHeight);
//    if (_isFilter) {
//        _mainCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH - [ShareWorkInstance shareInstance].showW   - 70, cellHeight);
//    }else{
//        _mainCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH - [ShareWorkInstance shareInstance].showW  , cellHeight);
//    }
//
//    MzzLog(@"...........%@",NSStringFromCGRect(_mainCollectionView.frame));
   cellHeight =  [self.class cellHeight:param count:per];
    [self updateCellHeight:cellHeight];
    /** 过滤数据 判断有没有自定义 */
    for (int i = 0; i < param.count; i++) {
        for (int j = 0; j< [param[i][@"list"] count]; j++) {
            NSMutableDictionary * tempDic = param[i][@"list"][j];
            if ([tempDic.allKeys containsObject:@"custom"]) {
                NSMutableDictionary * nextDic = param[i][@"list"][j +1];
                [nextDic setValue:@(0) forKey:@"unit"];
            }
        }
    }
    [_mainCollectionView reloadData];
}
- (void)updateCellHeight:(CGFloat)cellHeight
{
    if (_isFilter) {
        _mainCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH - [ShareWorkInstance shareInstance].showW   - 70, cellHeight);
    }else{
        _mainCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH - [ShareWorkInstance shareInstance].showW  , cellHeight);
    }
}
- (void)updateSearchType:(BOOL)isFilter
{
    _isFilter = isFilter;
}
- (void)updateCellModule:(NSString *)module
{
    if ([module isEqualToString:@"员工检索"]) {
        _isShow = NO;
    }
}
+ (CGFloat)cellHeight:(NSArray *)dataArr count:(CGFloat)count
{
    CGFloat cellHeight = 0.0;
    /** 几组数据 */
    cellHeight = cellHeight + dataArr.count * kCollectionViewSectionHeaderH;
    /** collectionView  cell高度 */
    NSInteger cellCount = 0;
    for (int i = 0; i < dataArr.count; i++) {
        NSDictionary * tempDic = dataArr[i];
        cellCount = [tempDic[@"list"] count];
        NSInteger line =  ceil(cellCount/count);
        cellHeight = cellHeight + (kCollectionViewCellH +kCollectionViewMargin)  * line ;
    }
    return cellHeight  ;
}
@end
