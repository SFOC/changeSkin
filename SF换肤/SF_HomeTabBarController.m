//
//  SF_HomeTabBarController.m
//  SF换肤
//
//  Created by fly on 2019/4/25.
//  Copyright © 2019年 石峰. All rights reserved.
//

#import "SF_HomeTabBarController.h"
#import "ViewController0.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import <SDWebImage.h>
#import "SF_ImageLoadManager.h"
#import <AFNetworking.h>

@interface SF_HomeTabBarController ()

///
@property (nonatomic, strong) NSMutableDictionary *allDataDic;

@end

@implementation SF_HomeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewController0 *vc0 = [ViewController0 new];
   
    
    ViewController1 *vc1 = [ViewController1 new];

    
    ViewController2 *vc2 = [ViewController2 new];

    
    ViewController3 *vc3 = [ViewController3 new];

    
    
    [self addChildViewController:vc0];
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    

    NSDictionary *lastSkinDataDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"sf_lastSkinData"];
    if (lastSkinDataDic) { // 如果有上一次的皮肤缓存，则先加载上一次的皮肤缓存
        
        [self changeTabBarItem:lastSkinDataDic isUseCache:YES];
    }else { // 没有缓存则直接加载默认皮肤
        
        [self restoreTabBarItem:nil];
    }
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabBarItem:) name:@"SF_ChangeTabBarItem" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restoreTabBarItem:) name:@"SF_RestoreTabBarItem" object:nil];
    
}

/// 设置tabbar标题颜色
- (void) setTabBarTitleWithControllerIndex:(int)controllerIndex  normalColor:(UIColor *)normalColor titleSelectColor:(UIColor *)selectColor {
    
    UIViewController *vc = (UIViewController *)self.viewControllers[controllerIndex];
    UITabBarItem *tabBarItem = vc.tabBarItem;
    
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor,NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
}

/// 设置tabbar标题
- (void) setTabBarTitleWithControllerIndex:(int)controllerIndex  title:(NSString *)title {
    
    UIViewController *vc = (UIViewController *)self.viewControllers[controllerIndex];
    UITabBarItem *tabBarItem = vc.tabBarItem;
    
    [tabBarItem setTitle:title];
}

/// 设置tabbar标题图片
- (void) setTabBarTitleWithControllerIndex:(int)controllerIndex  normalImg:(UIImage *)normalImg selectImg:(UIImage *)selectImg {
    
    UIViewController *vc = (UIViewController *)self.viewControllers[controllerIndex];
    UITabBarItem *tabBarItem = vc.tabBarItem;
    
    [tabBarItem setImage:[normalImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem setSelectedImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

}

/// 设置tabbar标题图片
- (void) setTabBarTitleWithControllerIndex:(int)controllerIndex  selectImg:(UIImage *)selectImg {
    
    UIViewController *vc = (UIViewController *)self.viewControllers[controllerIndex];
    UITabBarItem *tabBarItem = vc.tabBarItem;
    
    [tabBarItem setSelectedImage:[selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

/// 设置tabbar标题图片
- (void) setTabBarTitleWithControllerIndex:(int)controllerIndex  normalImg:(UIImage *)normalImg {
    
    UIViewController *vc = (UIViewController *)self.viewControllers[controllerIndex];
    UITabBarItem *tabBarItem = vc.tabBarItem;
    
    [tabBarItem setImage:[normalImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

#pragma mark ---通知回调---
/// 改变item
- (void)changeTabBarItem:(NSNotification *)sender {
    
    self.allDataDic = [sender.userInfo mutableCopy];
    [self changeTabBarItem:self.allDataDic isUseCache:NO];
}

/// 恢复item
- (void)restoreTabBarItem:(NSNotification *)sender {
    
    [self setTabBarTitleWithControllerIndex:0 normalColor:[UIColor grayColor] titleSelectColor:[UIColor redColor]];
    [self setTabBarTitleWithControllerIndex:1 normalColor:[UIColor grayColor] titleSelectColor:[UIColor redColor]];
    [self setTabBarTitleWithControllerIndex:2 normalColor:[UIColor grayColor] titleSelectColor:[UIColor redColor]];
    [self setTabBarTitleWithControllerIndex:3 normalColor:[UIColor grayColor] titleSelectColor:[UIColor redColor]];
    
    
    [self setTabBarTitleWithControllerIndex:0 title:@"首页"];
    [self setTabBarTitleWithControllerIndex:1 title:@"产品"];
    [self setTabBarTitleWithControllerIndex:2 title:@"订单"];
    [self setTabBarTitleWithControllerIndex:3 title:@"我的"];
    
    
    [self setTabBarTitleWithControllerIndex:0 normalImg:[UIImage imageNamed:@"firstNormal"] selectImg:[UIImage imageNamed:@"firstSelected"]];
    [self setTabBarTitleWithControllerIndex:1 normalImg:[UIImage imageNamed:@"secondNormal"] selectImg:[UIImage imageNamed:@"secondSelected"]];
    [self setTabBarTitleWithControllerIndex:2 normalImg:[UIImage imageNamed:@"thirdNormal"] selectImg:[UIImage imageNamed:@"thirdSelected"]];
    [self setTabBarTitleWithControllerIndex:3 normalImg:[UIImage imageNamed:@"fourNormal"] selectImg:[UIImage imageNamed:@"fourSelected"]];
}

#pragma mark ---16进制颜色字符串转颜色---
- (UIColor *)getColor:(NSString *)hexColor {
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

#pragma mark ---私有方法---
/// 改变item，是否使用缓存
- (void) changeTabBarItem:(NSDictionary *)cacheDic isUseCache:(BOOL)isUseCache{
    
    self.allDataDic = cacheDic.mutableCopy;
    
    if (!self.allDataDic) {
        
        // 没有参数
        return;
    }
    if (![self.allDataDic[@"success"] boolValue]) {
        
        // 请求失败
        return;
    }
    
    // 1.判断是否有新的皮肤
    if (![self.allDataDic[@"data"][@"isHaveSkin"] boolValue]) {
        
        // 没有新皮肤
        [self restoreTabBarItem:nil]; // 没有新皮肤就使用默认皮肤
        return;
    }
    
    // 2.判断皮肤的版本是否和本地存在的皮肤版本相同
    NSDictionary *lastSkinDataDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"sf_lastSkinData"];
    NSString *localSkinVersion = lastSkinDataDic[@"data"][@"skinVersion"];
    
    if (!isUseCache) { // 不使用缓存的就是在辨认此次请求的数据，使用缓存的是使用上次缓存的数据(使用上次数据，不需要判断版本)
        
        if ([localSkinVersion isEqualToString:self.allDataDic[@"data"][@"skinVersion"]]) {
            
            // 如果本地的皮肤版本和请求得到的皮肤版本相同，则返回
            return;
        }
    }
    
    
    // 3.下面是真正的换肤操作了
    
    NSDictionary *colorDic = self.allDataDic[@"data"][@"tabBarTitleColor"];
    NSDictionary *titleDic = self.allDataDic[@"data"][@"tabBarTitle"];
    NSDictionary *imgDic = self.allDataDic[@"data"][@"tabBarImg"];
    
    [self setTabBarTitleWithControllerIndex:0 normalColor:[self getColor:colorDic[@"firstColorNormal"]] titleSelectColor:[self getColor:colorDic[@"firstColorSelected"]]];
    [self setTabBarTitleWithControllerIndex:1 normalColor:[self getColor:colorDic[@"secondColorNormal"]] titleSelectColor:[self getColor:colorDic[@"secondColorSelected"]]];
    [self setTabBarTitleWithControllerIndex:2 normalColor:[self getColor:colorDic[@"thirdColorNormal"]] titleSelectColor:[self getColor:colorDic[@"thirdColorSelected"]]];
    [self setTabBarTitleWithControllerIndex:3 normalColor:[self getColor:colorDic[@"fourColorNormal"]] titleSelectColor:[self getColor:colorDic[@"fourColorSelected"]]];
    
    [self setTabBarTitleWithControllerIndex:0 title:titleDic[@"firstTitle"]];
    [self setTabBarTitleWithControllerIndex:1 title:titleDic[@"secondTitle"]];
    [self setTabBarTitleWithControllerIndex:2 title:titleDic[@"thirdTitle"]];
    [self setTabBarTitleWithControllerIndex:3 title:titleDic[@"fourTitle"]];
    
    
    __weak typeof(self) weakSelf = self;
    [[SF_ImageLoadManager shareImageLoad] loadImgWithUrlStr:imgDic[@"firstImgNormal"] imageBlock:^(UIImage * _Nonnull img) {
        
        [weakSelf setTabBarTitleWithControllerIndex:0 normalImg:img];
    }];
    
    [[SF_ImageLoadManager shareImageLoad] loadImgWithUrlStr:imgDic[@"firstImgSelected"] imageBlock:^(UIImage * _Nonnull img) {
        
        [weakSelf setTabBarTitleWithControllerIndex:0 selectImg:img];
    }];
    
    [[SF_ImageLoadManager shareImageLoad] loadImgWithUrlStr:imgDic[@"secondImgNormal"] imageBlock:^(UIImage * _Nonnull img) {
        
        [weakSelf setTabBarTitleWithControllerIndex:1 normalImg:img];
    }];
    
    [[SF_ImageLoadManager shareImageLoad] loadImgWithUrlStr:imgDic[@"secondImgSelected"] imageBlock:^(UIImage * _Nonnull img) {
        
        [weakSelf setTabBarTitleWithControllerIndex:1 selectImg:img];
    }];
    
    [[SF_ImageLoadManager shareImageLoad] loadImgWithUrlStr:imgDic[@"thirdImgNormal"] imageBlock:^(UIImage * _Nonnull img) {
        
        [weakSelf setTabBarTitleWithControllerIndex:2 normalImg:img];
    }];
    
    [[SF_ImageLoadManager shareImageLoad] loadImgWithUrlStr:imgDic[@"thirdImgSelected"] imageBlock:^(UIImage * _Nonnull img) {
        
        [weakSelf setTabBarTitleWithControllerIndex:2 selectImg:img];
    }];
    
    [[SF_ImageLoadManager shareImageLoad] loadImgWithUrlStr:imgDic[@"fourImgNormal"] imageBlock:^(UIImage * _Nonnull img) {
        
        [weakSelf setTabBarTitleWithControllerIndex:3 normalImg:img];
    }];
    
    [[SF_ImageLoadManager shareImageLoad] loadImgWithUrlStr:imgDic[@"fourImgSelected"] imageBlock:^(UIImage * _Nonnull img) {
        
        [weakSelf setTabBarTitleWithControllerIndex:3 selectImg:img];
    }];
    
    // 4.保存此次的换肤数据，用于下次打开app，直接使用此数据
    [[NSUserDefaults standardUserDefaults] setValue:self.allDataDic forKey:@"sf_lastSkinData"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark ---懒加载---

@end
