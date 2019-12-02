//
//  XMHFormSectionModel.h
//  xmh
//
//  Created by KFW on 2019/5/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormSectionModel : NSObject
/** title */
@property (nonatomic, copy) NSString *title;

- (XMHFormSectionModel *)createTitle:(NSString *)title;

/** <##> */
@property (nonatomic, strong) NSMutableArray *sectionArray;
@end

NS_ASSUME_NONNULL_END
