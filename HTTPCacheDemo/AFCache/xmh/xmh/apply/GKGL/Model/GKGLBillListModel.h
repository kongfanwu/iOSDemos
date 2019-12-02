//
//  GKGLBillListModel.h
//  xmh
//
//  Created by ald_ios on 2019/1/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GKGLBillModel;
NS_ASSUME_NONNULL_BEGIN

@interface GKGLBillListModel : NSObject
@property (nonatomic, strong)NSArray <GKGLBillModel *>*list;
@end
@interface GKGLBillModel : NSObject
@property (nonatomic, strong)NSArray <NSDictionary *>*list;
@property (nonatomic, copy)NSString *num;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *type;
@end

NS_ASSUME_NONNULL_END
