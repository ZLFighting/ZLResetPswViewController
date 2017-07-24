//
//  ViewController.m
//  ZLResetPswViewController
//
//  Created by ZL on 2017/7/24.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ViewController.h"
#import "ZLTextField.h"
#import "ZLVerifyCodeButton.h"
#import "NSString+Extension.h"
#import "UIView+ZLExtension.h"

// 设置尺寸
#define UI_View_Width   ([UIScreen mainScreen].bounds.size.width) // 屏幕宽度
#define UI_View_Height  ([UIScreen mainScreen].bounds.size.height) // 屏幕高度
#define UI_navBar_Height  64.0 // 导航条高度

// RGB颜色
#define ZLColor(r, g, b)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface ViewController () <UITextFieldDelegate>

// 手机号输入框
@property (nonatomic, weak) ZLTextField *mobileField;

// 手机验证码输入框
@property (nonatomic, weak) ZLTextField *codeField;

// 新密码输入框
@property (nonatomic, weak) ZLTextField *newpswField;

// 确认密码输入框
@property (nonatomic, weak) ZLTextField *surepswField;

// 获取验证码按钮
@property (nonatomic, weak) ZLVerifyCodeButton *codeBtn;

// 验证码
@property (nonatomic, copy) NSString *codeStr;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ZLColor(243, 243, 243);
    
    [self setupUI];
}

- (void)setupUI {
    
    CGFloat top = UI_navBar_Height + 10;
    CGFloat marginX = 15;
    CGFloat marginH = 40;
    CGFloat textFieldH = 50.0;
    CGFloat codeBtnW = 60;
    
    // 手机号输入框
    ZLTextField *mobileField = [[ZLTextField alloc]initWithFrame:CGRectMake(0, top, UI_View_Width, textFieldH)];
    mobileField.placeholder = @"手机号";
    mobileField.delegate = self;
    mobileField.keyboardType = UIKeyboardTypePhonePad; // 电话号码键盘
    [self.view addSubview:mobileField];
    self.mobileField = mobileField;
    // 间隔线
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(marginX, CGRectGetMaxY(mobileField.frame), UI_View_Width - marginX * 2, 1);
    line.backgroundColor = ZLColor(204, 204, 204);
    [self.view addSubview:line];
    
    // 手机验证码输入框
    ZLTextField *codeField = [[ZLTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(mobileField.frame), mobileField.width, textFieldH)];
    codeField.placeholder = @"手机验证码";
    codeField.clearButtonMode = UITextFieldViewModeNever; // 不显示右边清除叉号
    codeField.keyboardType = UIKeyboardTypeNumberPad; // 数字键盘
    codeField.delegate = self;
    [self.view addSubview:codeField];
    self.codeField = codeField;
    
    // 获取验证码按钮
    ZLVerifyCodeButton *codeBtn = [ZLVerifyCodeButton buttonWithType:UIButtonTypeCustom];
    codeBtn.frame = CGRectMake(codeField.width - codeBtnW - marginX, 10, codeBtnW, 30);
    [codeBtn addTarget:self action:@selector(codeBtnVerification) forControlEvents:UIControlEventTouchUpInside];
    [self.codeField addSubview:codeBtn];
    self.codeBtn = codeBtn;
    
    // 新密码输入框
    ZLTextField *newpswField = [[ZLTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(codeField.frame), mobileField.width, textFieldH)];
    newpswField.placeholder = @"设置新密码";
    newpswField.secureTextEntry = YES;
    newpswField.delegate = self;
    [self.view addSubview:newpswField];
    self.newpswField = newpswField;
    
    // 重复新密码输入框
    ZLTextField *surepswField = [[ZLTextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(newpswField.frame), mobileField.width, textFieldH)];
    surepswField.returnKeyType = UIReturnKeyDone;
    surepswField.secureTextEntry = YES;
    surepswField.delegate = self;
    surepswField.placeholder = @"确认新密码";
    [self.view addSubview:surepswField];
    self.surepswField = surepswField;
    
    // 确认按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.frame = CGRectMake(marginX, CGRectGetMaxY(surepswField.frame) + marginH, UI_View_Width - marginX * 2, 40);
    sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(sureBtnPress) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.backgroundColor = ZLColor(251, 0, 7);
    sureBtn.layer.cornerRadius = 3.0;
    sureBtn.clipsToBounds = YES;
    [self.view addSubview:sureBtn];
    
}

// 调用修改密码接口
- (void)sureBtnPress {
    
    if (![self.mobileField.text isPhoneNumber]) {
        
        [self setupAlertMessage:@"新手机号码输入不正确"];
    } else if (![self.codeField.text isEqualToString:self.codeStr]) {

        [self setupAlertMessage:@"验证码输入不正确"];
    } else if(![self.newpswField.text isPSW]) {

        [self setupAlertMessage:@"新密码不符合要求"];
    } else if ([self.mobileField.text isPhoneNumber] && [self.codeField.text isEqualToString:self.codeStr] && [self.newpswField.text isPSW]) {
        
        // 调用修改密码接口
        [self changePswForServer];
    }
    
}

// 弹框提示错误信息
- (void)setupAlertMessage:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}



// 调用修改密码接口
- (void)changePswForServer {

    NSLog(@"phone: %@", self.mobileField.text);
    NSLog(@"phoneCode: %@", self.codeField.text);
    NSLog(@"newPassword: %@", self.newpswField.text);
}

// 获取验证码点击事件
- (void)codeBtnVerification {

    NSLog(@"验证码:%@", self.mobileField.text);
    
    [self.codeBtn timeFailBeginFrom:60]; // 倒计时60s
    
    // 调用短信验证码接口
    // 用户输入的验证码数字传给server，判断请求结果作不同的逻辑处理，根据自己家的产品大大需求来即可....
//    if （请求成功且匹配成功验证码数字）{
//        [self.codeBtn timeFailBeginFrom:60];  // 倒计时60s
//    } else {
//        [self.codeBtn timeFailBeginFrom:1]; // 处理请求成功但是匹配不成功的情况，并不需要执行倒计时功能
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITextFieldDelegate

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.mobileField resignFirstResponder];
    [self.codeField resignFirstResponder];
    [self.newpswField resignFirstResponder];
    [self.surepswField resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.mobileField) {
        [self.mobileField resignFirstResponder];
        [self.codeField becomeFirstResponder];
    } else if (textField == self.codeField) {
        [self.codeField resignFirstResponder];
        [self.newpswField becomeFirstResponder];
    } else if (textField == self.newpswField) {
        [self.newpswField resignFirstResponder];
        [self.surepswField becomeFirstResponder];
        
        [self sureBtnPress];
    }
    
    return YES;
}



@end
