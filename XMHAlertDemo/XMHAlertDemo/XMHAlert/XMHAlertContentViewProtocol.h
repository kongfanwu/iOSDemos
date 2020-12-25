//
//  XMHAlertContentViewProtocol.h
//  XMHAlertDemo
//
//  Created by kfw on 2020/12/23.
//

#import <Foundation/Foundation.h>
@class XMHAlertAction;

NS_ASSUME_NONNULL_BEGIN

@protocol XMHAlertContentViewProtocol <NSObject>
@optional
/// 标题
@property (nonatomic, copy) NSString *titleText;
/// 消息内容
@property (nonatomic, copy) NSString *messageText;
/// 按钮集合，如果不需要添加按钮可不实现。
@property (nonatomic, strong) NSMutableArray <XMHAlertAction *> *actions;
@end

NS_ASSUME_NONNULL_END
