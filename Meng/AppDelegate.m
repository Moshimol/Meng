//
//  AppDelegate.m
//  Meng
//
//  Created by lushitong on 16/8/8.
//  Copyright © 2016年 mac04. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "GuideViewController.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
@class GuideViewController;
#define kFirstStartFLag @"kFirstStartFLag"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //创建标签控制器
    MainTabBarController *tab = [[MainTabBarController alloc] init];
    
    
    //设置根视图控制器
    
    BOOL firstFlag = [[NSUserDefaults standardUserDefaults] boolForKey:kFirstStartFLag];
    if (firstFlag) {
        self.window.rootViewController = tab;
    }else{
        GuideViewController *root = [[GuideViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFirstStartFLag];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.window.rootViewController = root;
    }
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"57d545b6e0f55a336b004786"];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:@"wx9815bf958dd7918b" appSecret:@"467be12ba8568b6420eb7d0369526cfa" url:@"http://www.baidu.com"];
    
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"4118550795"
                                              secret:@"793707b02bedac8b6fae16359f4da969"
                                         RedirectURL:@"http://www.baidu.com"];

    
    
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
