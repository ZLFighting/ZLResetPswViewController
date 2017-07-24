//
//  ZLTextField.m
//  ZLResetPswViewController
//
//  Created by ZL on 2017/7/24.
//  Copyright © 2017年 ZL. All rights reserved.
//

#import "ZLTextField.h"
#import "UIView+ZLExtension.h"

// 设置尺寸
#define UI_View_Width   ([UIScreen mainScreen].bounds.size.width) // 屏幕宽度
// RGB颜色
#define ZLColor(r, g, b)   [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation ZLTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI {
    
    // 输入框
    self.borderStyle = UITextBorderStyleNone;
    [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    self.backgroundColor = [UIColor whiteColor]; // ZLColor(0, 0, 0);
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.returnKeyType = UIReturnKeyNext;
    self.font = [UIFont systemFontOfSize:15];
    self.textColor = ZLColor(113, 111, 118);
    // 设置光标颜色
    self.tintColor =  ZLColor(113, 111, 118);
    // 设置UITextField的占位文字颜色
    self.placeholder = @"设置了占位文字内容以后, 才能设置占位文字的颜色";
    [self setValue: ZLColor(113, 111, 118) forKeyPath:@"_placeholderLabel.textColor"];
    // 添加背景图片
//    self.background = [UIImage imageNamed:@"u58"];
    // 左间隔
    self.leftView = [[UIView alloc] init];
    self.leftView.width = 15;
    self.leftViewMode = UITextFieldViewModeAlways;
    // clearButton
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    CGFloat marginX = 15;
    // 间隔线
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(marginX, self.height - 0.7, UI_View_Width - marginX * 2, 1);
    line.backgroundColor = ZLColor(249, 249, 249);
    [self addSubview:line];
    
}

@end
