//
//  UIView+ZLExtension.h
//  QuTaoWan
//
//  Created by ZL on 16/3/1.
//  Copyright © 2016年 zhangli. All rights reserved.
//  封装frame：关于尺寸frame的分类

#import <UIKit/UIKit.h>

@interface UIView (ZLExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@end
