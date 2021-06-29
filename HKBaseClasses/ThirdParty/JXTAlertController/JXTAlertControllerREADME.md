# JXTAlertController.h使用

##他和系统UIAlertController用法差不多，相对ViewController使用

### alert类型

```
[self jxt_showAlertWithTitle:@"温馨提示" message:@"请输入你的东西" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
    alertMaker.addActionCancelTitle(@"取消");
    alertMaker.addActionDefaultTitle(@"确定");
    [alertMaker addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
    }];
} actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
    if (buttonIndex != 0) {//点击非取消
		
    }
}];

```

### sheet类型

```
[self jxt_showActionSheetWithTitle:nil message:nil appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
    alertMaker.addActionCancelTitle(@"取消");
    alertMaker.addActionDefaultTitle(@"其他登录");
} actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
    if (buttonIndex != 0) {点击非取消
            
    }
}];
```