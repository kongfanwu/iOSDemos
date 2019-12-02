//
//  GKGLCardDetailTopView.h
//  xmh
//
//  Created by ald_ios on 2019/1/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GKGLCardDetailTopView : UIView
@property (nonatomic, copy)void (^GKGLCardDetailTopViewCancelTicketBlock)();
@property (nonatomic, copy)void (^GKGLCardDetailTopViewEndServiceBlock)();
- (void)updateGKGLCardDetailTopViewParam:(NSDictionary *)param cardType:(NSString *)cardType;
@end

NS_ASSUME_NONNULL_END
