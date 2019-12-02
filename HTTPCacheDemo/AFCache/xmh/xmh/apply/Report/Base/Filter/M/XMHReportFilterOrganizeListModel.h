//
//  XMHReportFilterOrganizeListModel.h
//  xmh
//
//  Created by ald_ios on 2019/7/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XMHReportFilterOrganizeModel;
NS_ASSUME_NONNULL_BEGIN

@interface XMHReportFilterOrganizeListModel : NSObject
@property(nonatomic, strong)NSMutableArray<XMHReportFilterOrganizeModel *> *list;
@end
@interface XMHReportFilterOrganizeModel : NSObject
/** 岗位id */
@property (nonatomic, assign)NSInteger fram_id;
/** 商家编码 */
@property (nonatomic, copy)NSString * join_code;
/** 岗位名称 */
@property (nonatomic, copy)NSString * name;
/** 父级id */
@property (nonatomic, assign)NSInteger pid;
/** 门店名称 */
@property (nonatomic, copy)NSString * store_code;
/** 层级id（关联按键联动） */
@property (nonatomic, assign)NSInteger fram_name_id;
/** 当前岗位所在人账号名称 */
@property (nonatomic, copy)NSString * account_name;
/** 当前岗位所在人的账号 */
@property (nonatomic, copy)NSString * account;
/** 门店名称 */
@property (nonatomic, copy)NSString * store_name;
/** 是否选中 */
@property (nonatomic, assign)BOOL selected;
@end
NS_ASSUME_NONNULL_END
