//
//  FWDRecordCell.m
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2018/4/16.
//  Copyright © 2018年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import "FWDRecordCell.h"
#import "CollectionViewCell.h"
#import "LChoosePhotos.h"
#import "CollectionHeardView.h"

@interface FWDRecordCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) UICollectionView *collectionView;

@end
@implementation FWDRecordCell
{

    NSMutableArray * _imgsArr;
    NSMutableArray * _imgsArrT;

    LChoosePhotos * _choose;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _choose = [[LChoosePhotos alloc] init];
    [_ContainerView addSubview:self.collectionView];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
        flowLayOut.itemSize = CGSizeMake(_ContainerView.width/7+7, _ContainerView.height/5);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _ContainerView.frame.size.width, _ContainerView.frame.size.height) collectionViewLayout:flowLayOut];
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.scrollEnabled = YES;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
#pragma mark -- 注册头部视图
        [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionHeardView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    }
    return _collectionView;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeardView *headerView = (CollectionHeardView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (indexPath.section==1) {
            headerView.lbTitle.text = @"服务后";
            headerView.lbContent.text = @"可将顾客此次服务执行后的图进行上传，最多上传4张";
        }
        
        if (_isNewVersion) {
            if (indexPath.section==0) {
                headerView.lbTitle.text = @"服务前";
                headerView.lbContent.text = @"可将顾客此次服务执行后的效果图进行上传，最多上传4张";
            }
            else if (indexPath.section==1) {
                headerView.lbTitle.text = @"服务后";
                headerView.lbContent.text = @"可将顾客此次服务执行后的效果图进行上传，最多上传4张";
            }
        }
        
        reusableView = headerView;
    }
    return reusableView;

}
// 设置区头尺寸高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(collectionView.frame.size.width, 65);
    return size;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return _imgsArr.count+1;
    }else{
        return _imgsArrT.count+1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.deleteButton setBackgroundImage:[UIImage imageNamed:@"stgkgl_biaoqianshanchu"] forState:UIControlStateNormal];
    if (indexPath.section == 0) {
        if (indexPath.row == _imgsArr.count) {
            if (_imgsArr.count == 4) {
                if(_imgsArr.count > indexPath.row){
                    cell.imagev.image = _imgsArr[indexPath.row];
                }else{
                    cell.imagev.image = [UIImage imageNamed:@""];
                }
            }else{
                cell.imagev.image = [UIImage imageNamed:@"shangchuantupian"];
            }
            cell.deleteButton.hidden = YES;
        }else{
            cell.imagev.image = _imgsArr[indexPath.row];
            cell.deleteButton.hidden = NO;
        }
    }else{
        if (indexPath.row == _imgsArrT.count) {
            if (_imgsArrT.count == 4) {
                if(_imgsArrT.count > indexPath.row){
                    cell.imagev.image = _imgsArrT[indexPath.row];
                }
                else{
                    cell.imagev.image = [UIImage imageNamed:@""];
                }
            }else{
                cell.imagev.image = [UIImage imageNamed:@"shangchuantupian"];
            }
            cell.deleteButton.hidden = YES;
        }else{
            cell.imagev.image = _imgsArrT[indexPath.row];
            cell.deleteButton.hidden = NO;
        }
    }
    cell.deleteButton.tag = 100*(indexPath.section+1) + indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deletePhotos:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)deletePhotos:(UIButton *)sender{
    NSIndexPath *indexPath;
    if (sender.tag-200>=0) {
        [_imgsArrT removeObjectAtIndex:sender.tag - 200];
        _choose.delectAftereArray = _imgsArrT;
        indexPath = [NSIndexPath indexPathForItem:sender.tag-200 inSection:1];
    }else{
        [_imgsArr removeObjectAtIndex:sender.tag - 100];
        _choose.delectBeforeArray = _imgsArr;
        indexPath = [NSIndexPath indexPathForItem:sender.tag-100 inSection:0];
    }
    [_collectionView performBatchUpdates:^{
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
            if (sender.tag-200>=0) {
                if (_FWDRecordCellTBlock) {
                    _FWDRecordCellTBlock(_imgsArrT);
                }
            }else{
                if (_FWDRecordCellBlock) {
                _FWDRecordCellBlock(_imgsArr);
                }
            }
    }];
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionView * weakCV = _collectionView;
    WeakSelf
    if (indexPath.section == 0) {
        if (indexPath.row == _imgsArr.count) {
            if (_imgsArr.count == 4) {
                [MzzHud toastWithTitle:@"注意" message:@"最多选择4张图片"];
            }else{
                _choose.maxNum = 4;
                [_choose show];
                _choose.before = @"yes";
                _choose.beforeResultBlock = ^(NSArray *images, NSArray *assets) {
                    _imgsArr = [[NSMutableArray alloc] initWithArray:images];
                    [weakSelf postData];
                    [weakCV reloadData];
                };
            }
        }else{
            
        }
    }else{
        if (indexPath.row == _imgsArrT.count) {
            if (_imgsArrT.count == 4) {
                [MzzHud toastWithTitle:@"注意" message:@"最多选择4张图片"];
            }else{
                _choose.maxNum = 4;
                _choose.before = @"no";
                [_choose show];
                _choose.afterResultBlock = ^(NSArray *images, NSArray *assets) {
                    _imgsArrT = [[NSMutableArray alloc] initWithArray:images];
                    [weakSelf postDataT];
                    [weakCV reloadData];
                };
            }
        }else{
            
        }
    }
    
}
- (void)postData
{
    if (_FWDRecordCellBlock) {
        _FWDRecordCellBlock(_imgsArr);
    }
}
- (void)postDataT
{
    if (_FWDRecordCellTBlock) {
        _FWDRecordCellTBlock(_imgsArrT);
    }
}
@end
