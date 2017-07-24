//
//  ZLVerifyCodeButton.h
//  ZLResetPswViewController
//
//  Created by ZL on 2017/7/24.
//  Copyright © 2017年 ZL. All rights reserved.
//  自定义 点击获取验证码的倒计时按钮

#import <UIKit/UIKit.h>

@interface ZLVerifyCodeButton : UIButton

- (void)timeFailBeginFrom:(NSInteger)timeCount;

@end
