//
//  AppDelegate.swift
//  MazinShooting
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    //application:didFinishLaunchingWithOptionsメソッドはアプリ起動準備がほぼ完了した際に呼ばれます。つまりここからアプリの起動が始まります。
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Create the SwiftUI view that provides the window contents.
        let arTitleView = ARTitleView()

        let gameInfo = GameInfo()

        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: arTitleView.environmentObject(gameInfo))
        self.window = window
        window.makeKeyAndVisible()
        return true
    }

    //アプリが非アクティブ状態時に呼ばれます。非アクティブ状態は一時的な中断(電話の着信やSMSメッセージなど)の他にホームボタンを押下してアプリがバックグラウンド状態に移行する際にも呼ばれます。
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    //バックグラウンド状態に移行すると呼ばれます。ホームボタンを押下してアプリが非表示になるとバックグラウンド状態になります。
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    //フォアグラウンド状態に移行すると呼ばれます。バックグラウンドもしくはサスペンド状態のアプリアイコンを押下して再度表示した場合、フォアグラウンド状態になります。
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    //フォアグラウンド状態に移行すると呼ばれます。バックグラウンドもしくはサスペンド状態のアプリアイコンを押下して再度表示した場合、フォアグラウンド状態になります。
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

