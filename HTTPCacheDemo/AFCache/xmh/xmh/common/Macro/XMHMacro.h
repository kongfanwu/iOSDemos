//
//  XMHMacro.h
//  xmh
//
//  Created by ald_ios on 2019/4/9.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#ifndef XMHMacro_h
#define XMHMacro_h

#import "AppDelegate.h"

/** --------------------颜色相关------------------------------------------------------------------*/
#define kColorF5F5F5                            [ColorTools colorWithHexString:@"#F5F5F5"]
#define kColorE5E5E5                            [ColorTools colorWithHexString:@"#E5E5E5"]
#define kColorTheme                             [ColorTools colorWithHexString:@"#f10180"]
#define kColor6                                 [ColorTools colorWithHexString:@"#666666"]
#define kColor3                                 [ColorTools colorWithHexString:@"#333333"]
#define kColor9                                 [ColorTools colorWithHexString:@"#999999"]
#define kColorE                                 [ColorTools colorWithHexString:@"#eeeeee"]
#define kColorC                                 [ColorTools colorWithHexString:@"#cccccc"]
#define kColorFF9072                            [ColorTools colorWithHexString:@"#FF9072"]
#define kColorFFF3F0                            [ColorTools colorWithHexString:@"#FFF3F0"]

#define kBackgroundColor kColorF5F5F5
/** --------------------字体相关----------------------------------------------------------------- */
#define FONT_SIZE(font_size)                    [UIFont systemFontOfSize:(font_size)]
#define FONT_NUM_SIZE(font_size)                [UIFont systemFontOfSize:(font_size)]
#define FONT_BOLD_SIZE(font_size)               [UIFont boldSystemFontOfSize:(font_size)]
#define FONT_MEDIUM_SIZE(font_size)               [UIFont systemFontOfSize:(font_size) weight:UIFontWeightMedium]
/** --------------------尺寸相关----------------------------------------------------------------- */
//#define IS_IPHONE_X \
//({BOOL isPhoneX = NO;\
//if (@available(iOS 11.0, *)) {\
//isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
//}\
//(isPhoneX);})

//分割线高度
#define kSeparatorHeight 0.6
//分割线色值
//#define kSeparatorColor kColorE5E5E5
//边缘宽
#define kBorderWidth 0.6

#define kApp ((AppDelegate *)[UIApplication sharedApplication].delegate)

//各个页面Nav的高度
//#define Heigh_Nav                               (IS_IPHONE_X ? 88 : 64)
//tabbar的高度
//#define Heigh_Tabbar                            (IS_IPHONE_X ? 83 : 49)

//获取屏幕 宽度、高度
#define SCREEN_WIDTH                            ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                           ([UIScreen mainScreen].bounds.size.height)

#define Heigh_View                              (SCREEN_HEIGHT - Heigh_Nav - Heigh_Tabbar)
#define Heigh_View_normal                       (SCREEN_HEIGHT - Heigh_Nav)

/** --------------------快速创建----------------------------------------------------------------- */
/** 加载nib */
#define loadNibName(className)                  [[[NSBundle mainBundle]loadNibNamed:className owner:nil options:nil]lastObject]
/** UIImage */
#define UIImageName(className)                  [UIImage imageNamed:className]
/** URL */
#define URLSTR(className)                       [NSURL URLWithString:className]

/** --------------------WeakSelf----------------------------------------------------------------- */
#define  WeakSelf  __weak typeof(self) weakSelf = self;


/** --------------------通知相关----------------------------------------------------------------- */
// 消息数量
static NSString * const Nav_MsgCount   =                        @"Nav_MsgCount";
// 切换root
static NSString * const AppDelegate_ChooseRoot   =              @"AppDelegate_ChooseRoot";
// 服务单第一个cell高度
static NSString * const Fwd_Cell0Height   =                     @"Fwd_Cell0Height";
// 线上交易webview 高度
static NSString * const DealOnline_WebViewHeight   =            @"DealOnline_WebViewHeight";
// 审批列表数据
static NSString * const Approve_refreshListData   =             @"Approve_refreshListData";
//
static NSString * const MzzInsertCustomerVC_BillInfoDic   =     @"MzzInsertCustomerVC_BillInfoDic";
//
static NSString * const MzzInsertCustomerVC_StoreCode   =       @"MzzInsertCustomerVC_StoreCode";
//
static NSString * const BookManager_DataChange   =              @"BookManager_DataChange";
// 会工作点击加号

static NSString * const Work_AddBtnClick   =                    @"Work_AddBtnClick";
// 登录成功
static NSString * const AppDelegate_LoginSuccess   =            @"AppDelegate_LoginSuccess";

static NSString *const KEY_FILE_UPLOADIMG =                     @"key_file_uploadImg";
// 通知刷新页面
static NSString *const XMHReloadDataNotification =               @"XMHReloadDataNotification";

/** --------------------吐司相关----------------------------------------------------------------- */
/**  */
/**
 命名:  kNOTICE_模块名称_动作_结果
 例：
 活动中心添加顾客成功
 kNOTICE_ACTIONCENTER_ADDCUSTOMER_SUCCESS_MSG
 
 */
/** 吐司 您没有权限使用此功能,如有疑问请联系管理员 */
static NSString *const kNOTICE_WORK_MODULELIMIT_MSG =                                   @"您没有权限，若有疑问可联系管理员！";
/** 活动中心添加顾客成功 */
static NSString *const kNOTICE_ACTIONCENTER_ADDCUSTOMER_SUCCESS_MSG =                   @"添加成功！";
/** 活动中心添加顾客已添加 */
static NSString *const kNOTICE_ACTIONCENTER_ADDCUSTOMER_ERROR_MSG =                     @"此顾客已添加！";
/** 活动中心发送优惠券成功 */
static NSString *const kNOTICE_ACTIONCENTER_SENDCOUPON_SUCCESS_MSG =                    @"发送中，完成将已站内信形式通知您";
/** 活动中心发送优惠券没有选择顾客 */
static NSString *const kNOTICE_ACTIONCENTER_SENDCOUPON_NOCUSTOMER_MSG =                 @"请选择顾客";
/** 活动中心发送优惠券没有选择优惠券 */
static NSString *const kNOTICE_ACTIONCENTER_SENDCOUPON_NOCOUPON_MSG =                   @"请选择优惠券";
/** 活动中心发送优惠券没有选择张数 */
static NSString *const kNOTICE_ACTIONCENTER_SENDCOUPON_NOCOUPONNUM_MSG =                @"请设定发券张数";
/** 友盟分享成功*/
static NSString *const kNOTICE_UM_SHARE_SUCCESS_MSG =                                   @"分享成功";



/** --------------------密钥----------------------------------------------------------------- */
/** 加密串 */
static NSString *const kAPP_PRIVATEKEY =            @"U7doak7fl4da45d";
/** deviceToken */
static NSString *const kAPP_DEVICETOKEN =            @"deviceToken";


#endif /* XMHMacro_h */
