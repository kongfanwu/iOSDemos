//
//  XMHSmartGuanJiaListModel.h
//  xmh
//
//  Created by ald_ios on 2019/6/14.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHSmartGuanJiaModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHSmartGuanJiaListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHSmartGuanJiaModel *> *list;
@end
@interface XMHSmartGuanJiaModel : NSObject
@property (nonatomic, copy)NSString * setID;
@property (nonatomic, assign)NSInteger  type;
@property (nonatomic, copy)NSString * name;
@property (nonatomic, copy)NSString * team;
@property (nonatomic, copy)NSString * content;
@end
NS_ASSUME_NONNULL_END
