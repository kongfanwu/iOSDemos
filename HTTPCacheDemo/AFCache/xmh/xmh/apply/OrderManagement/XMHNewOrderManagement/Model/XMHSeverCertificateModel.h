//
//  XMHSeverCertificateModel.h
//  xmh
//
//  Created by shendengmeiye on 2019/3/11.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
// 服务凭证
NS_ASSUME_NONNULL_BEGIN

@interface XMHSeverCertificateModel : NSObject

@property (nonatomic ,copy)NSString * peihe;//配合耗卡
@property (nonatomic ,copy)NSString * fuwuyeji;// 服务业绩
@property (nonatomic ,copy)NSString * fuwudanshu;//服务单数
@property (nonatomic ,copy)NSString * fuwuxiangmushu;//服务项目数
@property (nonatomic ,copy)NSString * fuwuxiangmucishu;//服务项目次数
@property (nonatomic ,copy)NSString * fuwurenshu;//服务人数
@property (nonatomic ,copy)NSString * xiaoshoudanshu;//销售服务单数
@property (nonatomic ,copy)NSString * xiaoshoujine;//销售服务金额

@end

NS_ASSUME_NONNULL_END
