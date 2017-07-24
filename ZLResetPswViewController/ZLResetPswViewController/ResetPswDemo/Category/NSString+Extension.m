//
//  NSString+Extension.m
//  ZLResetPswViewController
//
//  Created by ZL on 2017/7/24.
//  Copyright © 2017年 ZL. All rights reserved.
//  

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)match:(NSString *)pattern {
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isPhoneNumber {
    // 1.全部是数字
    // 2.11位
    // 3.以13\15\18\17开头
    return [self match:@"^1\\d{10}$"];
//    return [self match:@"^(13\\d|14[57]|15[^4,\\D]|17[678]|18\\d)\\d{8}$|^170[059]\\d{7}$"];
}

- (BOOL)isPSW {
    
    // 以字母开头，长度在6~18之间，只能包含字符、数字和下划线
//    return [self match:@"^[a-zA-Z]\\w{5,17}$"];
    // 长度在6~16之间，只能包含字符、数字和下划线
    return [self match:@"^[0-9a-zA-Z]\\w{5,15}$"];
}

@end
