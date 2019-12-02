//
//  XMHTicketVC.h
//  xmh
//
//  Created by KFW on 2019/3/19.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
// 优惠券

#import <UIKit/UIKit.h>
@class XMHTicketModel;

NS_ASSUME_NONNULL_BEGIN

@interface XMHTicketVC : UIViewController
/** 礼品卷集合 */
@property (nonatomic, strong) NSArray <XMHTicketModel*> *ticketModelArray;
/** s */
@property (nonatomic, copy) void (^didSelectBlock)(XMHTicketVC *vc, XMHTicketModel *selectModel);
@end

NS_ASSUME_NONNULL_END
