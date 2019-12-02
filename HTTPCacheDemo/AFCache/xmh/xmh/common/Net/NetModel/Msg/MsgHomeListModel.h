//
//  MsgHomeListModel.h
//  xmh
//
//  Created by ald_ios on 2018/12/21.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MsgHomeModel;
@interface MsgHomeListModel : NSObject
@property (nonatomic, strong)NSArray <MsgHomeModel *>*list;
@end
@interface MsgHomeModel : NSObject
@property (nonatomic, copy)NSString *state;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *depict;
@property (nonatomic, copy)NSString *img;
@property (nonatomic, copy)NSString *num;
@end
