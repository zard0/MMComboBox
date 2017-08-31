//
//  YTImageUtils.h
//
//  Copyright (c) 2015年 深圳市易图资讯股份有限公司. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface YTImageUtils : NSObject

#pragma makr - Color
/**
 *  Color 创建图片
 *
 *  @param color <#color description#>
 *  @param size  <#size description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


#pragma mark - 方法
/**
 *  拉伸图片
 *
 *  @param image 图片
 *
 *  @return <#return value description#>
 */
+ (UIImage *)resizableImage:(UIImage *)image;

/**
 *  获取指定图径的图片
 *
 *  @param name 路径与图片名称
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithNameByPath:(NSString *)name;

/**
 *  获取指定图径的图片
 *
 *  @param name 路径与图片名称
 *  @param resizable 是否拉伸
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithNameByPath:(NSString *)name resizable:(BOOL)resizable;


/**
 *  根据图片名获取图片
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithImageName:(NSString *)name;

/**
 *  根据图片名获取图片
 *
 *  @param name      图片名
 *  @param resizable <#resizable description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithImageName:(NSString *)name resizable:(BOOL)resizable;


/**
 *  获取指定图径的图片
 *
 *  @param name   路径与图片名称
 *  @param insets UIEdgeInsets
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithNameByPath:(NSString *)name insets:(UIEdgeInsets)insets;

@end
