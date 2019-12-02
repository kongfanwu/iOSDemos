//
//Created by ESJsonFormatForMac on 17/12/27.
//
/*
 id    int    用户id
 manage_type    int    管理级别：1-自己、2-部分、3-所有
 manage_val    array    管理的账号
 account    string    账号
 name    string    用户名
 phone    string    手机号
 headimgurl    string    头像
 skill_level    int    等级 1-初级，2-中级，3-高级
 password    string    密码（md5）
 join_code    array    商家code编码
 token    string    令牌
 
 join_code返回参数说明
 
 参数名    类型    说明
 code    string    商家编码
 name    string    商家名称
 is_active_role    int  是否有活动中心的权限（1是，0否）
 fram_id    int    岗位id
 function_id    int    职位id
 fram_name_id    int    层级id
 join_state    int    商家状态（0正常 1服务未开始 2 冻结 3服务到期 ）---------------------2018.10.30新添------------------------------------
 fram_list    array    层级
 fram_id_name    string    岗位名称
 fram_id_level    int    岗位级别
 fram_id_subset    int    岗位下是否有子级
 fram_id_is_observer    int    1是观察者，0不是
 purview    array    平台角色权限（string）
 framework_function_name    string    职位名称
 framework_function_main_role    int    主角色-------------------- 1管理层，2财务人员，3店经理，4技术店长，5销售店长，6售前店长，7前台，8售后美容师，9售前美容师，10售中美容师，11导购
 framework_function_role    array    平台角色id（string）
 */
#import <Foundation/Foundation.h>
#import "YYModel.h"

@class Data,Join_Code,Fram_List;
@interface LolUserInfoModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, strong) Data *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface Data : NSObject<NSCoding>

@property (nonatomic, copy) NSString *account;

@property (nonatomic, strong) NSArray<NSString *> *manage_val;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSArray<Join_Code *> *join_code;

@property (nonatomic, assign) NSInteger skill_level;

@property (nonatomic, assign) NSInteger manage_type;

@property (nonatomic, copy) NSString *head_img;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy)NSString * password;

@property (nonatomic, assign) NSInteger bfb;
@property (nonatomic, copy) NSString *store_code;

@property (nonatomic, copy) NSString *store_name;
@end

@interface Join_Code : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger fram_name_id;
/** 主角色-------------------- 1管理层，2财务人员，3店经理，4技术店长，5销售店长，6售前店长，7前台，8售后美容师，9售前美容师，10售中美容师，11导购 */
@property (nonatomic, assign) NSInteger framework_function_main_role;

@property (nonatomic, strong) NSArray<NSString *> *framework_function_role;
/** 商家编码 */
@property (nonatomic, copy) NSString *code;

@property (nonatomic, strong) NSArray<NSString *> *purview;

@property (nonatomic, copy) NSString *framework_function_name;

@property (nonatomic, copy) NSString *fram_id_name;

@property (nonatomic, assign) NSInteger fram_id;
@property (nonatomic, assign) NSInteger is_active_role;

@property (nonatomic, strong) NSArray<Fram_List *> *fram_list;

@property (nonatomic, assign) NSInteger function_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *fram_id_level;

@property (nonatomic, copy) NSString *fram_id_subset;

@property (nonatomic, assign) NSInteger fram_id_is_observer;
/** 门店code */
@property (nonatomic, copy) NSString *store_code;
/** 商户logo */
@property (nonatomic, copy) NSString *join_logo;
@end

@interface Fram_List : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger fram_name_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger main_role;
@end

