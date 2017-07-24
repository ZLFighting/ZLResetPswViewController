//
//  NSString+Extension.h
//  ZLResetPswViewController
//
//  Created by ZL on 2017/7/24.
//  Copyright © 2017年 ZL. All rights reserved.
//  正则表达式

#import <Foundation/Foundation.h>

@interface NSString (Extension)

// 手机号码校验
- (BOOL)isPhoneNumber;

// 密码校验
- (BOOL)isPSW;

@end
