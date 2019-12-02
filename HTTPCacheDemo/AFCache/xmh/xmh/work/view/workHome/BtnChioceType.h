//
//  BtnChioceType.h
//  xmh
//
//  Created by 神灯智能-技术研发中心-ios dev on 2017/11/13.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//

#ifndef BtnChioceType_h
#define BtnChioceType_h

typedef NS_ENUM(NSUInteger, workBtnChoiceType){
//    ChoiseTypeAll,          //选择全部
    ChoiseTypeDaiYuYue,     // 待预约
    ChoiseTypeDaiShenPi,    //待审批
    ChoiseTypeDaiFuWu,      //待服务
    ChoiseTypeDaiGenJin,    //待跟进
};

typedef NS_ENUM(NSUInteger, secondChoiceType){
    secondChoiceTypeFuWuNeiRong,    //待服务——服务内容
    secondChoiceTypeXiaoShouNeiRong,//待服务--销售内容
};
typedef NS_ENUM(NSUInteger, ThirdChoiceType){
    thirdChoiceTypeShouQianGenJin,//待跟进--售前跟进
    thirdChoiceTypeKaiFaGuanKong,  //待跟进——开发管控
    thirdChoiceTypeKeQingWeiHu,    //待跟进--客情维护
};

#endif /* BtnChioceType_h */
