//
//  AppDelegate.swift
//  Apper
//
//  Created by jian on 8/3/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authViewController: SignInViewController!
    var dashboardContainer: MFSideMenuContainerViewController!
    var currentApper: Apper!
    var DEBUG = true // This flag can help to debug shortcut for navigate directly to specfic scene, also can be used for other debugging purpose in development, It must be false at the time of release
    
    func getDelegate() -> AppDelegate
    {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            
            
            //Twitter.
            if (url.scheme == "apper")
            {
                let d = self.parametersDictionaryFromQueryString(url.query)
                let token = d.valueForKey("oauth_token") as! String
                let verifier = d.valueForKey("oauth_verifier") as! String
                
                if(authViewController != nil)
                {
                    authViewController.setOAuthToken(token, verifier: verifier)
                }
                return true;
            }
            
            //Google Plus.
            GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation)
            
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    func parametersDictionaryFromQueryString(queryString: String!) -> NSDictionary
    {
        let md = NSMutableDictionary()
        let queryComponents = queryString.componentsSeparatedByString("&")
        
        for s in queryComponents
        {
            var pair = s.componentsSeparatedByString("=")
            if(pair.count != 2) {
                continue
            }
            
            let key = pair[0]
            let value = pair[1]
            
            md.setObject(value, forKey: key)
        }
        return md
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

