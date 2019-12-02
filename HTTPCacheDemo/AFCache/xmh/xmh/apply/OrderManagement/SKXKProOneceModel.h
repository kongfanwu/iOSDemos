//
//  SKXKProOneceModel.h
//  xmh
//
//  Created by 享美会-技术研发中心-ios dev on 2018/5/18.
//  Copyright © 2018年 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShengKaXuKaKeShengHuiYuanKa.h"

@interface SKXKProOneceModel : NSObject

@property (nonatomic,copy)NSString *award_del;
@property (nonatomic,copy)NSString *save_old;
@property (nonatomic,copy)NSString *to_type;
@property (nonatomic,copy)NSString *up_type;
@property (nonatomic,copy)NSString *inputPrice;
@property (nonatomic,strong)NSMutableArray *ShengKaXuKaProList;
@property (nonatomic,strong)ShengKaXuKaKeShengHuiYuanKaList *ShengKaXuKaShengKaMuBiaoListModel;

@end
