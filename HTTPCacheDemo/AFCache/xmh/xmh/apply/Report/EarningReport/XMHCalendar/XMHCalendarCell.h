//
//  XMHCalendarCell.h
//  xmh
//
//  Created by shendengmeiye on 2019/7/2.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "FSCalendarCell.h"


typedef NS_ENUM(NSUInteger, SelectionType) {
    SelectionTypeNone = 0,
    SelectionTypeSingle = 1,
    SelectionTypeLeftBorder = 2,
    SelectionTypeMiddle = 3,
    SelectionTypeRightBorder = 4,
    SelectionTypeToday = 5
};
NS_ASSUME_NONNULL_BEGIN

@interface XMHCalendarCell : FSCalendarCell
/** 选中背景阴影 */
@property (strong, nonatomic) CAShapeLayer *selectionLayer;
/**  */
@property (assign, nonatomic) SelectionType selectionType;
@end

NS_ASSUME_NONNULL_END
