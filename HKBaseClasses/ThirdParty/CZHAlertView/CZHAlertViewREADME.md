# CZHAlertView使用

## Alert
```
CZHAlertView *alertView = [CZHAlertView czh_alertViewWithTitle:@"这是一个标题标题" message:@"这是message这是message这是message" preferredStyle:CZHAlertViewStyleAlert];
            
CZHAlertItem *item = [CZHAlertItem czh_itemWithTitle:@"哈哈" style:CZHAlertItemStyleDefault handler:^(CZHAlertItem *item) {
                NSLog(@"---点击了");
}];
            
[alertView czh_addAlertItem:item];
            
[alertView czh_showView];
```

## Sheet

```
CZHAlertView *alertView = [CZHAlertView czh_alertViewWithTitle:@"哈哈哈哈哈哈哈哈" message:nil preferredStyle:CZHAlertViewStyleActionSheet animationStyle:CZHAlertViewAnimationStyleSlideFromBottom];
alertView.titleColor = [UIColor blackColor];
CZHAlertItem *item = [CZHAlertItem czh_itemWithTitle:@"取消" style:CZHAlertItemStyleCancel handler:^(CZHAlertItem *item) {
        NSLog(@"---点击了");
    }];
item.titleColor = [UIColor grayColor];
    
CZHAlertItem *item2 = [CZHAlertItem czh_itemWithTitle:@"啦啦啦啊" style:CZHAlertItemStyleDefault handler:^(CZHAlertItem *item) {
        NSLog(@"---点击了");
}];
    
[alertView czh_addAlertItem:item];
[alertView czh_addAlertItem:item2];
    
[alertView czh_showView];
```