//
//  SceneDelegate.m
//  MRTodo-OC
//
//  Created by 南墙先生 on 2024/7/25.
//

#import "SceneDelegate.h"
#import "AppDelegate.h"
#import "View/CalendarView/MRCalendarViewController.h"
#import "View/TodoView/MRTodoViewController.h"
#import "View/StatisticView/MRStatisticViewController.h"
#import "View/TomatoClockView/MRTomatoClockViewController.h"
#import "View/StartView/MRStartViewController.h"
#import "CoreDataManager.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    
    // SceneDelegate 有一个 window 属性，我们需要给这个 window 属性赋值一个 UIWindow 对象，这个对象的 frame 设定为屏幕的大小；
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.windowScene = (UIWindowScene*)scene;
    
    // NSUserDefaults 是单例模式，此处创建一个对象方便使用
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    // 首次启动则打开启动页，当 isNotFirstLaunch 值为 NO 时是首次启动
    if (![userDefaults boolForKey:@"isNotFirstLaunch"]) {
        // 配置 window 根视图为启动页视图
        self.window.rootViewController = [self startViewConfigure];
    } else {
        // 配置 window 根视图为 Tabbar 视图
        self.window.rootViewController = [self tabBarConfigure];
    }
    
    // 设置为关键窗口
    [self.window makeKeyAndVisible];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.

    // Save changes in the application's managed object context when the application transitions to the background.
    
    /* 原先 Xcode 默认把 CoreData 相关代码写在 AppDelegate 内，现已经把 CoreData 独立出来，所以弃用
     [(AppDelegate *)UIApplication.sharedApplication.delegate saveContext];
     */
    
    [[CoreDataManager sharedManager] saveContext]; // App 切换到后台时保存 CoreData 数据
}


// MARK: - StartViewConfigure

/// 配置启动页视图
- (MRStartViewController *)startViewConfigure {
    MRStartViewController *startViewController = [MRStartViewController new];
    return startViewController;
}


// MARK: - TabBarConfigure

/// 配置 TabBar 标签栏视图
- (UITabBarController *)tabBarConfigure {
    UITabBarController *rootTabBarController = [UITabBarController new];

    // 日历视图
    MRCalendarViewController *calendarViewController = [MRCalendarViewController new];
    calendarViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"日历" image:[UIImage systemImageNamed:@"calendar"] tag:1];
    
    // 待办视图
    MRTodoViewController *todoViewController = [MRTodoViewController new];
    UINavigationController *todoNavigationController = [[UINavigationController alloc] initWithRootViewController:todoViewController];
    todoViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"待办" image:[UIImage systemImageNamed:@"text.badge.checkmark"] tag:2];
    
    // 统计视图
    MRStatisticViewController *statisticViewController = [MRStatisticViewController new];
    statisticViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"统计" image:[UIImage systemImageNamed:@"chart.xyaxis.line"] tag:3];
    
    // 番茄种视图
    MRTomatoClockViewController *tomatoClockViewController = [MRTomatoClockViewController new];
    tomatoClockViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"番茄钟" image:[UIImage systemImageNamed:@"timer"] tag:4];
    
    // 添加到 TabBar
    rootTabBarController.viewControllers = @[calendarViewController, todoNavigationController, statisticViewController, tomatoClockViewController];
    
    return rootTabBarController;
}


@end
