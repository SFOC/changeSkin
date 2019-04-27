//
//  SF_ImageLoadManager.h
//  SF换肤
//
//  Created by fly on 2019/4/26.
//  Copyright © 2019年 石峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SF_ImageLoadManager : NSObject

+ (instancetype) shareImageLoad;


/// 加载图片
- (void) loadImgWithUrlStr:(NSString *)urlStr imageBlock:(void(^)(UIImage *img))imageBlock;
@end

NS_ASSUME_NONNULL_END
