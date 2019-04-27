//
//  SF_ImageLoadManager.m
//  SF换肤
//  简单封装SDWebImage加载图片
//  Created by fly on 2019/4/26.
//  Copyright © 2019年 石峰. All rights reserved.
//

#import "SF_ImageLoadManager.h"
#import <SDWebImage.h>

SF_ImageLoadManager *imageLoadManager = nil;
@implementation SF_ImageLoadManager

+ (instancetype) shareImageLoad {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        imageLoadManager = [SF_ImageLoadManager new];
    });
    
    return imageLoadManager;
}

/// 加载图片
- (void) loadImgWithUrlStr:(NSString *)urlStr imageBlock:(void(^)(UIImage *img))imageBlock{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager] ;
    [manager loadImageWithURL:[NSURL URLWithString:urlStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        imageBlock(image);
    }];
}



@end
