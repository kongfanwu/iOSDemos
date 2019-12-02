//
//  XMHFormTableView.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMHItemModel.h"
#import "XMHFormModel.h"
@class XMHFormTableView;

NS_ASSUME_NONNULL_BEGIN
@protocol XMHFormTableViewDelegate <NSObject>

@optional

/**
 切换优惠券类型
 */
- (void)didChangeCouponType:(XMHItemModel *)itemModel indexPath:(NSIndexPath *)indexPath;

/**
 添加logo
 */
- (void)addPhotoClick:(XMHFormModel *)formModel;

- (void)tableView:(XMHFormTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface XMHFormTableView : UITableView
@property (nonatomic, strong) NSMutableArray *dataArray;
/** <##> */
@property (nonatomic, weak) id <XMHFormTableViewDelegate> aDelegate;
@end

NS_ASSUME_NONNULL_END
