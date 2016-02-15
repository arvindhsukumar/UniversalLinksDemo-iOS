//
//  AppDelegate.swift
//  UniversalLinksDemo
//
//  Created by Arvindh Sukumar on 13/02/16.
//  Copyright © 2016 Arvindh Sukumar. All rights reserved.
//

import UIKit

let kBaseURL = "https://universallinksdemo.herokuapp.com"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let router = SHNUrlRouter()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        bindRoutes()
        
        return true
    }
    
    func bindRoutes(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let root = self.window?.rootViewController as! UINavigationController
        
        router.register("/authors") { (params) -> Void in
            let list: AuthorsTableViewController = storyboard.instantiateViewControllerWithIdentifier("AuthorsTableViewController") as! AuthorsTableViewController
            
            root.pushViewController(list, animated: true)
        }
        
        router.register("/authors/{id}") { (params) -> Void in
            let profileVC: AuthorProfileViewController = storyboard.instantiateViewControllerWithIdentifier("AuthorProfileViewController") as! AuthorProfileViewController
            profileVC.authorID = Int(params["id"]!)
            root.pushViewController(profileVC, animated: true)
        }
        
        router.register("/authors/{id}/books") { (params) -> Void in
            let list: BooksTableViewController = storyboard.instantiateViewControllerWithIdentifier("BooksTableViewController") as! BooksTableViewController
            list.authorID = Int(params["id"]!)
            root.pushViewController(list, animated: true)
        }

    }
    
    func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
        
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            let url = userActivity.webpageURL!
            self.router.dispatch(url)
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

