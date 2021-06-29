# WHGradientHelper设置渐变色

## UIImageView使用
```
//矩形
//1.非动态
UIImageView *image000 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 40, 200, 44)];
image000.layer.masksToBounds = YES;
image000.layer.cornerRadius = 22;
image000.image = [WHGradientHelper getLinearGradientImage:[UIColor redColor] and:[UIColor greenColor] directionType:WHLinearGradientDirectionLevel];
[self.view addSubview:image000];

//动态
UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(30, 200, 200, 44)];
[self.view addSubview:imageView2];
[WHGradientHelper addGradientChromatoAnimation:imageView2];


//圆
UIImageView *imgViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(60, 440, 80, 80)];
imgViewLeft.image = [WHGradientHelper getRadialGradientImage:[UIColor redColor] and:[UIColor greenColor]];
[self.view addSubview:imgViewLeft];
```

## UILabel
```
//非动态
UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 375, 50)];
lable1.textAlignment = NSTextAlignmentCenter;
lable1.text = @"交流故事，沟通想法";
lable1.font = [UIFont systemFontOfSize:28];
[WHGradientHelper addLinearGradientForLableText:self.view lable:lable1 start:[UIColor blueColor] and:[UIColor greenColor]];

//动态
UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 440, 375, 50)];
lable2.textAlignment = NSTextAlignmentCenter;
lable2.text = @"交流故事，沟通想法";
lable2.font = [UIFont systemFontOfSize:28];
[WHGradientHelper addGradientChromatoAnimationForLableText:self.view lable:lable2];
```

## UIButton使用
```
UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(300, 320, 64, 64)];
[moreBtn setTitle:@"More" forState:UIControlStateNormal];
[moreBtn setBackgroundImage:[WHGradientHelper getRadialGradientImage:[UIColor redColor] and:[UIColor greenColor]] forState:UIControlStateNormal];
[self.view addSubview:moreBtn];
```