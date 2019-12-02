//
//  NetworkUrl.h
//  xmh
//
//  Created by ald_ios on 2019/1/15.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#ifndef NetworkUrl_h
#define NetworkUrl_h
#pragma mark ------新顾客管理地址------
/** 卡项详情 */
static NSString * const kGKGL_CARD_DETAIL_URL = @"v5.user_sales/bill_info";
/** 优惠券列表 */
static NSString * const kGKGL_DISCOUNTCOUPON_URL = @"v5.user_new/ticket_coupon_info";
/** 权益包 */
static NSString * const kGKGL_EBENEFITS_URL = @"v5.user_new/equity_info";
/** 卡项普及 */
static NSString * const kGKGL_CARDPOPULAR_URL = @"v5.user_sales/card_item";
/** 健康问诊 */
static NSString * const kGKGL_HEADLTHINQUIRY_ITEM_URL = @"v5.user_new/allQuestionList";
/** 问诊详情 */
static NSString * const kGKGL_HEADLTHQUESTIONDETAIL_ITEM_URL = @"v5.user_new/questionInfo";
/** 顾客标签 */
static NSString * const kGKGL_HEADLTHINQUIRY_MARK_URL = @"v5.user_new/getUserLabel";
/** 参加问诊 */
static NSString * const kGKGL_HEADLTHINQUIRY_QUESTIONCOMMIT_URL = @"v5.user_new/joinQuestion";
/** 搜索顾客 */
static NSString * const kGKGL_HEADLTHINQUIRY_SEARCHCUSTOMER_URL = @"v5.user_new/joinQuestion";
/** 顾客添加 选择门店 */
static NSString * const kGKGL_ADDCUSTOMER_STORELIST_URL = @"v5.user/stores_list";
/** 顾客添加 选择门店 */
static NSString * const kGKGL_ADDCUSTOMER_JISLIST_URL = @"v5.user/choose";
/** 顾客基本信息 */
static NSString * const kGKGL_CUSTOMERINFO_URL = @"v5.user/user_info";
/** 顾客等级 */
static NSString * const kGKGL_CUSTOMERCLASS_URL = @"v5.user/grade";
/** 顾客信息编辑 */
static NSString * const kGKGL_CUSTOMERINFOEDIT_URL = @"v5.user_new/user_edit";
/** 消票 */
static NSString * const kGKGL_CUSTOMERBILLDETAI_CANCELTICKET_URL = @"v5.user_bill/stop_ticket";
/** 终止服务 */
static NSString * const kGKGL_CUSTOMERBILLLDETAIL_ENDSERVICE_URL = @"v5.user_bill/stop_goods";
/** 获取审批人 */
static NSString * const kGKGL_CUSTOMERBILLL_APPROVAL_URL = @"v5.Approval/changeInfo";

/** 顾客管理 数据统计 */
static NSString * const kGKGL_DATASTATISTICS_URL = @"gk/chart_dzhu.html";
#pragma mark ------统计地址------


/** 统计---产值结构报表 */
static NSString * const kTJ_CZJG_LIST_URL = @"Output/getAll";
/** 统计---项目报表 八筒数据 */
static NSString * const kTJ_PRO_TOP_URL = @"Pro_Count/getTop";
/** 统计---项目报表 列表数据 */
static NSString * const kTJ_PRO_LIST_URL = @"Pro_Count/getList";


#pragma mark ------智能检索------
/** 获取检索历史 */
static NSString * const kLANTERN_MANAGE_HISTORY_URL = @"Search_result/lists.html";
/** 删除某条历史数据 */
static NSString * const kLANTERN_MANAGE_DEL_HISTORY_URL = @"Search_result/edit.html";
/** 检索条件 */
static NSString * const kLANTERN_MANAGE_SEARCHRESULT_URL = @"Search_result/info.html";
/** 检索项目 */
static NSString * const kLANTERN_MANAGE_SEARCHPRO_URL = @"Pro_search/search.html";

/** 检索顾客 */
static NSString * const kLANTERN_MANAGE_SEARCHCUSTOMER_URL = @"user_search/userSearch.html";

/** 顾客等级 和 顾客标签 */
static NSString * const kLANTERN_MANAGE_CUSTOMERGRADE_URL = @"user_search/getGradeAndContent.html";
/** 顾客检索 技师 */
static NSString * const kLANTERN_MANAGE_CUSTOMERJIS_URL = @"user_search/getJis.html";

/** 顾客检索 获取项目 */
static NSString * const kLANTERN_MANAGE_CUSTOMERJPRO_URL = @"user_search/getPros.html";

/** 检索员工 */
static NSString * const kLANTERN_MANAGE_SEARCHSTAFF_URL = @"account_search/search.html";
/** 保存检索记录 */
static NSString * const kLANTERN_MANAGE_SAVESEARCH_URL = @"Search_result/add.html";
/** 处方详情 */
static NSString * const kBREAUTY_CHUFANG_DETAIL_URL = @"v5.Meilidingzhi/pres_new";
///** 获取门店数据 */
//static NSString * const kLANTERN_MANAGE_SAVESEARCH_URL = @"v5.user/stores_list";

#pragma mark ------新预约管理地址------
/** 预约订单 */
static NSString * const kBOOK_BOOKBILL_URL = @"v5.Yuyueguanli/orderAppo";
/** 预约分析八筒数据 */
static NSString * const kBOOK_ANALYZE_TOP_URL = @"v5.Yuyueguanli/getEightTube";
/** 预约分析日历数据 */
static NSString * const kBOOK_ANALYZE_CALENDER_URL = @"v5.Yuyueguanli/getStandard";
/** 预约分析列表数据 */
static NSString * const kBOOK_ANALYZE_HOMELIST_URL = @"v5.Yuyueguanli/getList";
/** 预约分析全部顾客列表数据 */
static NSString * const kBOOK_ANALYZE_HOMEALLCUSTOMER_URL = @"v5.Yuyueguanli/getUserList";
/** 预约表门店数据 */
static NSString * const kBOOK_CHART_STORES_URL = @"v5.Yuyueguanli/getAllStore";
#pragma mark ------新美丽定制地址------
/** 处方详情地址 */
static NSString * const kBEAUTY_CFDETAIL_URL = @"beauty/particulars.html";
/** 顾客总处方地址 */
static NSString * const kBEAUTY_ALLCF_URL = @"v5.Mldz_new/presList";
/** 处方报告地址 */
static NSString * const kBEAUTY_CFREPORT_URL = @"beauty/report.html";
/** 处方执行效果产看 */
static NSString * const kBEAUTY_CFREPORTERESULT_URL = @"beauty/result.html";
/** 顾客账单明细 */
static NSString * const kBEAUTY_BILLDETAIL_URL = @"v5.Meilidingzhi/user_info";
/** 处方表头部数据 */
static NSString * const kBEAUTY_CFBIAOTOP_URL = @"v5.Mldz_new/storeInfo";
/** 处方表列表技师数据 */
static NSString * const kBEAUTY_CFBIAOJISLIST_URL = @"v5.Mldz_new/jisList";
/** 处方表门店数据*/
static NSString * const kBEAUTY_CFBIAOSTORET_URL = @"v5.Mldz_new/storeList";
/** 处方表 技师详情顾客列表*/
static NSString * const kBEAUTY_CFBIAOCustomer_URL = @"v5.Mldz_new/jisInfo";
/** 处方表 技师详情顾客列表*/
static NSString * const kBEAUTY_HOMEWEB_URL = @"beauty/newChart.html";
/** 美丽定制首页 列表数据*/
static NSString * const kBEAUTY_HOMELIST_URL = @"v5.Mldz_new/getList";
/** 美丽定制首页 规划执行*/
static NSString * const kBEAUTY_HOMEPLAN_URL = @"v5.Mldz_new/planning";
/** 美丽定制首页 实际执行*/
static NSString * const kBEAUTY_HOMEEXECUTE_URL = @"v5.Mldz_new/execute";

#pragma mark ------优惠券地址------
/** 美丽定制首页 实际执行*/
static NSString * const kCOUPON_SEND_HOME_URL = @"v5.Ticket_coupon/lower_hair_list";
/** 发送优惠券已使用列表*/
static NSString * const kCOUPON_SEND_USELIST_URL = @"v5.Ticket_coupon/get_use_list";
/** 发送使用优惠券数据统计*/
static NSString * const kCOUPON_SEND_USECOUNT_URL = @"v5.Ticket_coupon/get_use_count";
/** 添加优惠券 列表*/
static NSString * const kCOUPON_SEND_ADDCOUPONLIST_URL = @"v5.Ticket_coupon/search_ticket";
/** 添加顾客 搜索*/
static NSString * const kCOUPON_SEND_SEARCHCUSTOMER_URL = @"v5.Ticket_coupon/search_user";
/** 发送优惠券*/
static NSString * const kCOUPON_SEND_COUPON_URL = @"v5.Ticket_coupon/lower_hair_ticket";
/** 活动中心权限*/
static NSString * const kCOUPON_LIMIT_URL = @"v5.Ticket_coupon/checkActive";
/** 活动中心 失败顾客*/
static NSString * const kCOUPON_ERRORCUSTOMER_URL = @"v5.Ticket_coupon/get_mess_info";
#pragma mark ------智能助手------
/** 日常任务管理列表*/
static NSString * const kSMARTHELPER_TASHKMANAGER_URL = @"v5.cute_hand/lists.html";
/** 标准服务流程提醒*/
static NSString * const kSMARTHELPER_STANDARD_REMIND_URL = @"v5.cute_hand_data/standard_remind";
/** 工作任务提醒，实时的实际执行的统计数据*/
static NSString * const kSMARTHELPER_STANDARD_ACTUAL_URL = @"v5.cute_hand_data/actual_remind";
/** 任务执行短信提醒 跳转的详情页*/
static NSString * const kSMARTHELPER_SMS_REMINDSMS_REMINM_URL = @"v5.cute_hand_data/sms_remind";
/** 智能助手任务执行优惠券提醒 跳转的详情页*/
static NSString * const kSMARTHELPER_TICKE_REMINM_URL = @"v5.cute_hand_data/ticket_remind";
/** 智能助手任务执行预约提醒 跳转的详情页*/
static NSString * const kSMARTHELPER_APPO_REMINM_URL = @"v5.cute_hand_data/appo_remind";
/** 关闭任务*/
static NSString * const kSMARTHELPER_CLOSETASK_URL = @"v5.cute_hand/changeStatus.html";
/** 智能管家设置列表*/
static NSString * const kSMARTHELPER_GUANJIASETLIST_URL = @"v5.cute_hand_data/Butler";
/** 智能管家设置 详情修改*/
static NSString * const kSMARTHELPER_GUANJIASETMODIFY_URL = @"v5.cute_hand_data/butlerSave";
/** 日常任务添加 */
static NSString * const kSMARTHELPER_CREATE_TASK_URL = @"v5.cute_hand/add.html";
/** 智能助手数据报告列表 */
static NSString * const kSMARTHELPER_REMIND_REPORT_LIST_URL = @"v5.cute_hand_data/remind_report_list";
/** 日常任务详情 */
static NSString * const kSMARTHELPER_CUTE_HAND_INFO_URL = @"v5.cute_hand/info.html";
/** 智能助手数据报告列表跳转的详情页 */
static NSString * const kSMARTHELPER_REMIND_REPORT_INFO_URL = @"v5.cute_hand_data/remind_report_info";
/** 提交前校验商家短信及优惠券数量是否充足 */
static NSString * const kSMARTHELPER_VERITY_MESS_AND_TICKET_URL = @"v5.cute_hand/verityMessAndTicket.html";
/** 任务角标 未读数量 */
static NSString * const kSMARTHELPER_READNUM_URL = @"v5.cute_hand/readNum.html";
/** 更改任务的已读状态 */
static NSString * const kSMARTHELPER_TASKREAD_URL = @"v5.cute_hand/taskRead.html";
/** 更改数据报告的已读状态 */
static NSString * const kSMARTHELPER_RESULTREAD_URL = @"v5.cute_hand/resultRead.html";


#pragma mark ------报表------
/** 筛选数据 快捷按钮 */
static NSString * const kREPORT_FILTER_FASTBUTTON_URL = @"consumption_report/get_button";
/** 筛选数据 组织架构 */
static NSString * const kREPORT_FILTER_ORGANIZE_URL = @"consumption_report/get_fram";
/** 获取挂零门店列表 */
static NSString * const kREPORT_ZERO_STORETOR_URL = @"performance/getZeroStoreList.html";
/** 获取挂零技师列表 */
static NSString * const kREPORT_ZERO_ACCPUNTLIST_URL = @"performance/getZeroAccountList.html";
/** 获取某个员工的销售业绩来源 */
static NSString * const kREPORT_GETSALESPROLIST_URL = @"performance/getSalesProList.html";
/** 点击列表获取业绩来源 */
static NSString * const kREPORT_CONSUMPTION_REPORT_SERV_PRO_URL = @"consumption_report/serv_pro_info";
/** 员工报表 */
static NSString * const kREPORT_STAFF_H5 = @"tables/tablesyuangong.html";
/** 业绩报表 */
static NSString * const kREPORT_YEJI_H5 = @"tables/tablesyeji.html";
/** 消耗报表 */
static NSString * const kREPORT_CONSUME_H5 = @"tables/tables.html";
/** 顾客保有报表 */
static NSString * const kREPORT_SUSTOMERRETAIN_H5 = @"tables/tablesyeji.html";
/** 员工统计-员工详情 */
static NSString * const kREPORT_EMPLOYEES_JIS_INFO = @"employees/jis_info";
/** 员工统计-排名详情 */
static NSString * const kREPORT_EMPLOYEES_RANKING = @"employees/ranking";
/** 员工统计-销售项目排名 */
static NSString * const kREPORT_EMPLOYEES_SALES_LIST = @"employees/sales_list";
/** 员工统计-消耗项目排名 */
static NSString * const kREPORT_EMPLOYEES_SERV_LIST = @"employees/serv_list";
/** 筛选界面  业绩 列表层级数据 */
static NSString * const kREPORT_YEJI_ORGANIZE_URL = @"consumption_report/get_fram";
/** 筛选界面  消耗 列表层级数据 */
static NSString * const kREPORT_XIAOHAO_ORGANIZE_URL = @"consumption_report/get_fram";
/** 筛选界面  员工 列表层级数据 */
static NSString * const kREPORT_YUANGONG_ORGANIZE_URL = @"employees/get_fram";
#endif /* NetworkUrl_h */
