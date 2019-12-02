//
//  MzzCustomerDetailsHeaderView.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MzzUserInfoModel.h"
@class MzzCustomerDetailsHeaderView;
@protocol MzzCustomerDetailsHeaderViewDelegate<NSObject>

- (void)customerdetailsHeaderView:(MzzCustomerDetailsHeaderView *)headView atCollectionView:(NSInteger)index onlickAtIndexPath:(NSIndexPath *)indexpath ;
- (void)customerdetailsHeaderView:(MzzCustomerDetailsHeaderView *)headView andIndex1:(NSInteger)index1 andIndex2:(NSInteger)index2 ;
@end

@interface MzzCustomerDetailsHeaderView : UIView
@property (nonatomic ,strong)NSArray *dataList;
@property (nonatomic ,weak) id <MzzCustomerDetailsHeaderViewDelegate> delegate;
@property (nonatomic ,assign)BOOL OneCollection;
@property (nonatomic ,strong)UICollectionView *scrollview;
@property (nonatomic ,strong)UICollectionView *scroll2view;
@property (nonatomic ,strong)MzzUserInfoModel *userInfoModel;
- (void)setindex1:(NSInteger)index1 andIndex2:(NSInteger)index2;
@end
