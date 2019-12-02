//
//  XMHBillRecDetailVC.h
//  xmh
//
//  Created by shendengmeiye on 2019/4/23.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHBillRecDetailVC : UIViewController

/**
 可能的类型:XMHBillReProModel、XMHBillReGoodsModel、XMHBillReCardModel、XMHBillReTimeModel XMHBillReNumCardModel XMHBillReTicketModel
 */
@property (nonatomic, strong)id billRecModel;

@property (nonatomic,copy)void(^selectBlock)(id model);
@end

NS_ASSUME_NONNULL_END
