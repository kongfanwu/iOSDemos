//
//  XMHAwardStatisticCell.h
//  xmh
//
//  Created by 杜彩艳 on 2019/3/31.
//  Copyright © 2019年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaleModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHAwardStatisticCell : UITableViewCell
- (void)refresCellModelArr:(NSMutableArray *)modelArr;
@property (nonatomic, copy)void(^addAward)();
@property (nonatomic, copy)void(^delectAward)(NSMutableArray *awardArr);
@end

NS_ASSUME_NONNULL_END
