//
//  YTImageUtils.m
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

#import "YTImageUtils.h"

@interface YTImageUtils ()

@property (strong, nonatomic) NSMutableArray *cacheKeyArray;
@property (strong, nonatomic) NSMutableDictionary *cacheDict;

@end

@implementation YTImageUtils


/**
 *  共享 Client
 *
 *  @return <#return value description#>
 */
+ (instancetype)sharedInstance {
    static YTImageUtils *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

/**
 *  初始化 cacheKeyDict
 */
- (void)vInitcacheKeyArray {
    if (![[YTImageUtils sharedInstance] cacheKeyArray]) {
        [YTImageUtils sharedInstance].cacheKeyArray = [NSMutableArray array];
    }
}

/**
 *  设置缓存图片
 *
 *  @param key   <#key description#>
 *  @param image <#image description#>
 */
- (void)setCacheImageWithKey:(NSString *)key image:(UIImage *)image {
    key = [key stringByReplacingOccurrencesOfString:@"@2x.png" withString:@""];
    
    [[YTImageUtils sharedInstance] vInitcacheKeyArray];
    
    BOOL setupCache = NO;
    for (NSString *obj in [YTImageUtils sharedInstance].cacheKeyArray) {
        if ([key hasSuffix:obj]) {
            setupCache = YES;
            break;
        }
    }
    
    if (!setupCache) {
        return;
    }
    
    if (![[YTImageUtils sharedInstance] cacheDict]) {
        [YTImageUtils sharedInstance].cacheDict = [NSMutableDictionary dictionary];
    }
    
    [[YTImageUtils sharedInstance].cacheDict setObject:image forKey:key];
}

/**
 *  获取缓存图片
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)getCacheImageWithKey:(NSString *)key {
    key = [key stringByReplacingOccurrencesOfString:@"@2x.png" withString:@""];
    
    if (![[YTImageUtils sharedInstance] cacheDict]) {
        [YTImageUtils sharedInstance].cacheDict = [NSMutableDictionary dictionary];
    }
    
    return [[YTImageUtils sharedInstance].cacheDict objectForKey:key];
}


#pragma makr - Color
/**
 *  Color 创建图片
 *
 *  @param color <#color description#>
 *  @param size  <#size description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
}


#pragma mark - 方法
/**
 *  拉伸图片
 *
 *  @param image 图片
 *
 *  @return <#return value description#>
 */
+ (UIImage *)resizableImage:(UIImage *)image {
    return image = [image stretchableImageWithLeftCapWidth:image.size.width / 2.0 topCapHeight:image.size.height / 2.0];
}

/**
 *  获取指定图径的图片
 *
 *  @param name 路径与图片名称
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithNameByPath:(NSString *)name {
    return [self getImageWithNameByPath:name resizable:NO];
}

/**
 *  获取指定图径的图片
 *
 *  @param name 路径与图片名称
 *  @param resizable 是否拉伸
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithNameByPath:(NSString *)name resizable:(BOOL)resizable {
    if (name.length == 0) {
        return nil;
    }
    
    NSString *resourcePath = [NSString stringWithFormat:@"%@/", [[NSBundle mainBundle] resourcePath]];
    NSString *imagePath;
    if ([name rangeOfString:resourcePath].location != NSNotFound) {
        imagePath = name;
    } else {
        imagePath = [resourcePath stringByAppendingPathComponent:name];
    }
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] < 8.000000) {
        imagePath = [NSString stringWithFormat:@"%@@2x.png", imagePath];
    }
    
    UIImage *image = [[YTImageUtils sharedInstance] getCacheImageWithKey:imagePath];
    if (image) {
        return image;
    }
    
    image = [UIImage imageWithContentsOfFile:imagePath];
    if (resizable) {
        image = [self resizableImage:image];
        [[YTImageUtils sharedInstance] setCacheImageWithKey:imagePath image:image];
    }
    
    return image;
}

/**
 *  根据图片名获取图片
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithImageName:(NSString *)name{
    return [self getImageWithImageName:name resizable:NO];
}

/**
 *  根据图片名获取图片
 *
 *  @param name      图片名
 *  @param resizable <#resizable description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithImageName:(NSString *)name resizable:(BOOL)resizable{
    if (name.length == 0) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:name];
    if (resizable) {
        image = [self resizableImage:image];
    }
    return image;
}

/**
 *  获取指定图径的图片
 *
 *  @param name   路径与图片名称
 *  @param insets <#insets description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)getImageWithNameByPath:(NSString *)name insets:(UIEdgeInsets)insets {
    if (name.length == 0) {
        return nil;
    }
    
    UIImage *image = [self getImageWithNameByPath:name resizable:NO];
    image = [image resizableImageWithCapInsets:insets];
    
    return image;
}

@end
