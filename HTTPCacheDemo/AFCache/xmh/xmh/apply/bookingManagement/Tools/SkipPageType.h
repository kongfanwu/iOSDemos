//
//  SkipPageType.h
//  xmh
//
//  Created by 李晓明 on 2017/12/7.
//  Copyright © 2017年 神灯智能-技术研发中心-ios dev. All rights reserved.
//  通过类型判断是哪个界面到达的详情页

#ifndef SkipPageType_h
#define SkipPageType_h

typedef NS_ENUM(NSUInteger, SkipPageType){
    SkipPageTypeGhydd,          //规划要到店
    SkipPageTypeYyy,            //已预约
    SkipPageTypeXgyy,           //修改预约
    SkipPageTypeAhdd,           //按时到店
    SkipPageTypeWahdd,          //未按时到店
    SkipPageTypeGhwdd,          //规划外到店
    SkipPageTypeDyy             //待预约
};
#endif /* SkipPageType_h */
