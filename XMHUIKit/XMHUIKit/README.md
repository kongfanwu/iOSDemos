## XMHConvenientUIKit
##### 介绍：XMHConvenientUIKit 是通过链式语法创建UIKit控件。写这个库就一个目的，开发中快速创建 UI 控件。依赖 Masonry。说下优缺点
优点：快速创建 UI, 可以一行形式写代码，也相比原有 API 简便

缺点：我认为链式语法在执行时相比原生执行要多调用很多方法，和创建多个 Block 对象。当然这是微乎其微的，如果在意这些请不要使用。


代码示例

```
    self.la = UILabel
    .xmhNewAndSuperView(self.view)
    .xmhTextAndTextColorAndFont(@"234567", UIColor.redColor, [UIFont systemFontOfSize:14])
    .xmhTextAlignment(NSTextAlignmentCenter)
    .xmhBackgroundColor(UIColor.blueColor)
    .xmhCornerRadius(10)
    .xmhBorderWidth(2)
    .xmhBorderColor(UIColor.cyanColor)
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.size.mas_equalTo(CGSizeMake(200, 44));
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(100);
    });

    self.button = UIButton
    .xmhNewAndSuperView(self.view)
    .xmhSetTitleAndColorAndFontAndState(@"title", UIColor.redColor, [UIFont systemFontOfSize:30], UIControlStateNormal)
    .xmhSetBackgroundImageAndState([UIImage imageNamed:@"1"], UIControlStateNormal)
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.size.mas_equalTo(CGSizeMake(200, 80));
        make.top.equalTo(self.la.mas_bottom);
        make.centerX.equalTo(self.view);
    })
    .xmhAddEvent(UIControlEventTouchUpInside, ^(UIButton *sender){
        NSLog(@"UIControlEventTouchUpInside");
    });

    self.imageView = UIImageView
    .xmhNewAndSuperView(self.view)
    .xmhImage([UIImage imageNamed:@"1"])
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.equalTo(self.button.mas_bottom);
        make.centerX.equalTo(self.view);
    });

    self.textField = UITextField
    .xmhNewAndSuperView(self.view)
    .xmhText(@"text")
    .xmhPlaceholder(@"place")
    .xmhDelegate(self)
    .xmhBackgroundColor(UIColor.orangeColor)
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.size.mas_equalTo(CGSizeMake(200, 50));
        make.top.equalTo(self.imageView.mas_bottom);
        make.centerX.equalTo(self.view);
    });
    
    self.tableView = UITableView
    .xmhNewAndSuperViewAndFrameAndStyleAndDelegate(self.view, CGRectMake(0, 0, 0, 0), UITableViewStylePlain, self)
    .xmhMakeConstraints(^(MASConstraintMaker * make){
        make.edges.equalTo(self.view);
    });
```

由于链式语法以Block形式调用、传参。开发中直接调用 Xcode 并不能直接显示方法全名，所以我写了一套代码片段。调用时请使用前缀 xmh... 形式。
[代码片段地址](https://github.com/kongfanwu/CodeSnippets)
