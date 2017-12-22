# ZLResetPswViewController
iOS点击获取短信验证码按钮(附送正则表达式及修改密码逻辑)

在APP开发中，点击获取验证码的倒计时按钮 是在注册、修改密码、绑定手机号等场景中使用！在项目中，多次使用这个按钮，现自定义一个简单的获取短信验证码倒计时功能。

![获取短信验证码.png](https://github.com/ZLFighting/ZLResetPswViewController/blob/master/ZLResetPswViewController/截图.png)

如果需要，可以直接拿走这个自定义的按钮ZLVerifyCodeButton，只需要调用方法即可，也可以在自定义里按照自己需求去更改按钮的UI。

>主要思路:
1、自定义验证码按钮:ZLVerifyCodeButton
2、自定义文本输入框:ZLTextField
3、正则表达式:手机号及密码校验方法
4、修改密码界面里调用这个短信验证码, 调取后台接口，获取短信验证码处理相关其他逻辑.


由于有些时间需求不同，特意露出方法，倒计时时间次数:
```
- (void)timeFailBeginFrom:(NSInteger)timeCount;

```
自定义获取验证码按钮：
```
- (void)setup {

[self setTitle:@" 获取验证码 " forState:UIControlStateNormal];
self.titleLabel.font = [UIFont systemFontOfSize:10];
self.backgroundColor = [UIColor clearColor];
self.layer.cornerRadius = 3.0;
self.clipsToBounds = YES;
[self setTitleColor:ZLColor(128, 177, 34) forState:UIControlStateNormal];
self.layer.borderColor = ZLColor(128, 177, 34).CGColor;
self.layer.borderWidth = 1.0;
}
```
倒计时方法:
```
- (void)timeFailBeginFrom:(NSInteger)timeCount {

self.count = timeCount;
self.enabled = NO;
// 加1个计时器
self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}
```
计时器方法:
```
- (void)timerFired {
if (self.count != 1) {
self.count -= 1;
self.enabled = NO;
[self setTitle:[NSString stringWithFormat:@"剩余%ld秒", self.count] forState:UIControlStateNormal];
//      [self setTitle:[NSString stringWithFormat:@"剩余%ld秒", self.count] forState:UIControlStateDisabled];
} else {

self.enabled = YES;
[self setTitle:@"获取验证码" forState:UIControlStateNormal];
//        self.count = 60;
[self.timer invalidate];
}
}
```

在你所需要的控制器里调用这个短信验证码按钮即可：
1）初始化创建设置相关按钮属性
```
// 获取验证码按钮
@property (nonatomic, weak) ZLVerifyCodeButton *codeBtn;

// 获取验证码按钮
ZLVerifyCodeButton *codeBtn = [ZLVerifyCodeButton buttonWithType:UIButtonTypeCustom];
// 设置frame 这里我是按照自己需求来
codeBtn.frame = CGRectMake(codeField.width - codeBtnW - marginX, 10, codeBtnW, 30);
[codeBtn addTarget:self action:@selector(codeBtnVerification) forControlEvents:UIControlEventTouchUpInside];
[self.codeField addSubview:codeBtn];
self.codeBtn = codeBtn;
```
2）调取后台接口，获取短信验证码处理相关其他逻辑
```
// 获取验证码点击事件
- (void)codeBtnVerification {

// 调用短信验证码接口
// 用户输入的验证码数字传给server，判断请求结果作不同的逻辑处理，根据自己家的产品大大需求来即可....
// if （请求成功且匹配成功验证码数字）{
[self.codeBtn timeFailBeginFrom:60];  // 倒计时60s
} else {
[self.codeBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能
}
}
```
这样就OK了，可以测试看下呦~

![效果图](https://github.com/ZLFighting/ZLResetPswViewController/blob/master/ZLResetPswViewController/运行效果.gif)

由于 Demo整体测试运行效果 , 整个修改密码界面都已展现, 并附送正则表达式及修改密码逻辑!

您的支持是作为程序媛的我最大的动力, 如果觉得对你有帮助请送个Star吧,谢谢啦
