//
//  XMHBillRecDetailView.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/18.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SureBtnBlock)(id model);
typedef void(^CloseBlock)();
@interface XMHBillRecDetailView : UIView

@property (nonatomic,strong)id billRecModel;

@property (nonatomic,copy)SureBtnBlock sureBlock;
@property (nonatomic,copy)CloseBlock closeBlock;

@end

NS_ASSUME_NONNULL_END
