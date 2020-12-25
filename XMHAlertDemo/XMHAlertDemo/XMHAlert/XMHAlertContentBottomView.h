//
//  XMHAlertContentBottomView.h
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/25.
//

#import <UIKit/UIKit.h>
@class XMHAlertAction;

NS_ASSUME_NONNULL_BEGIN

@interface XMHAlertContentBottomView : UIView
@property (nonatomic, strong) NSMutableArray <XMHAlertAction *> *actions;
@end

NS_ASSUME_NONNULL_END
