//
//  XMHFormTaskInputRightPointCell.h
//  xmh
//
//  Created by kfw on 2019/6/12.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface XMHFormTaskInputRightPointCell : XMHFormTaskBaseCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *rightPointLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@end

NS_ASSUME_NONNULL_END
