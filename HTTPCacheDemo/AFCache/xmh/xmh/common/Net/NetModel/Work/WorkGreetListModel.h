//
//  WorkGreetListModel.h
//  xmh
//
//  Created by ald_ios on 2018/10/25.
//  Copyright © 2018 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WorkGreetModel;
@interface WorkGreetListModel : NSObject
@property (nonatomic, strong)NSArray <WorkGreetModel *>* list;
@end

@interface WorkGreetModel : NSObject
@property (nonatomic, copy)NSString * pic;
@property (nonatomic, copy)NSString * url;
@end
