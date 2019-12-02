//
//  XMHReportFilterFastLIstModel.h
//  xmh
//
//  Created by ald_ios on 2019/7/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHReportFilterFastModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHReportFilterFastListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHReportFilterFastModel *> *list;
@end
@interface XMHReportFilterFastModel : NSObject
/** 层级id （和下面的层级列表有联动） */
@property (nonatomic, assign)NSInteger fram_name_id;
/** 层级名称 */
@property (nonatomic, copy)NSString * name;
@end
NS_ASSUME_NONNULL_END
