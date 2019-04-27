//
//  AppDelegate.m
//  SF换肤
//
//  Created by fly on 2019/4/25.
//  Copyright © 2019年 石峰. All rights reserved.
//

#import "AppDelegate.h"
#import "SF_HomeTabBarController.h"
#import <AFNetworking.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

//- (NSMutableDictionary *)allDataDic {
//
//    if (!_allDataDic) {
//
//        _allDataDic = @{
//                        @"data":@{
//                                @"skinVersion":@"1.0.0", // 皮肤版本
//
//                                @"isHaveSkin":@(NO), // 是否有皮肤，如果没有则直接加载本地默认皮肤，如果有则对比本地皮肤版本和现在请求的皮肤版本是否一致
//
//                                @"endTime":@"",
//
//                                @"tabBarImg":@{
//                                        @"firstImgNormal":@"http://192.168.11.46:8080/o2oImgs/xiangce/image/upload/item/shop/69/firstNormal0.png",
//                                        @"firstImgSelected":@"http://192.168.11.46:8080/o2oImgs/xiangce/image/upload/item/shop/69/firstSelected0.png",
//
//                                        @"secondImgNormal":@"http://192.168.11.46:8080/o2oImgs/xiangce/image/upload/item/shop/69/secondNormal0.png",
//                                        @"secondImgSelected":@"http://192.168.11.46:8080/o2oImgs/xiangce/image/upload/item/shop/69/secondSelected0.png",
//
//                                        @"thirdImgNormal":@"http://192.168.11.46:8080/o2oImgs/xiangce/image/upload/item/shop/69/thirdNormal0.png",
//                                        @"thirdImgSelected":@"http://192.168.11.46:8080/o2oImgs/xiangce/image/upload/item/shop/69/thirdSelected0.png",
//
//                                        @"fourImgNormal":@"http://192.168.11.46:8080/o2oImgs/xiangce/image/upload/item/shop/69/fourNormal0.png",
//                                        @"fourImgSelected":@"http://192.168.11.46:8080/o2oImgs/xiangce/image/upload/item/shop/69/fourSelected0.png"
//
//                                        },
//
//                                @"tabBarTitle":@{
//
//                                        @"firstTitle":@"新",
//
//
//                                        @"secondTitle":@"年",
//
//
//                                        @"thirdTitle":@"快",
//
//
//                                        @"fourTitle":@"乐"
//
//                                        },
//                                @"tabBarTitleColor":@{
//
//                                        @"firstColorNormal":@"999999",
//                                        @"firstColorSelected":@"111111",
//
//                                        @"secondColorNormal":@"999999",
//                                        @"secondColorSelected":@"111111",
//
//                                        @"thirdColorNormal":@"999999",
//                                        @"thirdColorSelected":@"111111",
//
//                                        @"fourColorNormal":@"999999",
//                                        @"fourColorSelected":@"111111"
//
//                                        }
//
//                                },
//                        @"success":@(YES)
//                        }.mutableCopy;
//    }
//    return  _allDataDic;
//}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    SF_HomeTabBarController *myTabBarController = [SF_HomeTabBarController new];
    self.window.rootViewController = myTabBarController;
    myTabBarController.selectedIndex = 0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager  manager];
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [manager GET:@"https://1005213565.github.io/OC_changeSkin/tabBar.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSLog(@"====%@",responseObject);
            NSMutableDictionary *allData = [responseObject mutableCopy];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SF_ChangeTabBarItem" object:nil userInfo:allData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求皮肤失败");
        }];
    });
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
