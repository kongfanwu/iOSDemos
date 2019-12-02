//
//  XMHFormTaskInputCell.h
//  xmh
//
//  Created by kfw on 2019/6/10.
//  Copyright © 2019 享美会-技术研发中心-ios dev. All rights reserved.
//

#import "XMHFormTaskBaseCell.h"


NS_ASSUME_NONNULL_BEGIN



@interface XMHFormTaskInputCell : XMHFormTaskBaseCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end

NS_ASSUME_NONNULL_END
