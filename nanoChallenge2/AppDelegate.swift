//
//  AppDelegate.swift
//  nanoChallenge2
//
//  Created by Golden Kevin on 17/09/19.
//  Copyright © 2019 Golden Kevin. All rights reserved.
//
    import UIKit
    import CoreLocation
    import UserNotifications
    
    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow?
        var locationManager: CLLocationManager!
        var notificationCenter: UNUserNotificationCenter!
        
            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
                self.locationManager = CLLocationManager()
                self.locationManager!.delegate = self
            
                // get the singleton object
                self.notificationCenter = UNUserNotificationCenter.current()
            
                // register as it's delegate
                notificationCenter.delegate = self
            
                // define what do you need permission to use
                let options: UNAuthorizationOptions = [.alert, .sound]
                
                // request permission
                notificationCenter.requestAuthorization(options: options) { (granted, error) in
                if !granted {
                    print("Permission not granted")
                }
            }
            
                if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil {
                print("I woke up thanks to geofencing")
            }
            
            buatOnboarding()
                
            return true
        }
        
        func buatOnboarding(){
            if UserDefaults.standard.value(forKey: "lanjutkan") != nil{
                let startVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "vcKedua")
                let share = UIApplication.shared.delegate as? AppDelegate
                share?.window?.rootViewController = startVC
                share?.window?.makeKeyAndVisible()
            }
        }
        func handleEvent(forRegion region: CLRegion!) {
            
            // customize your notification content
            let content = UNMutableNotificationContent()
            content.title = "Hati-hati di jalan"
            content.body = "Yuk, cek kembali barang bawaan anda agar tidak tertinggal!"
            content.sound = UNNotificationSound.default
            
            // when the notification will be triggered
            let timeInSeconds: TimeInterval = 3
            // the actual trigger object
            let trigger = UNTimeIntervalNotificationTrigger(
                timeInterval: timeInSeconds,
                repeats: false
            )
            
            // notification unique identifier, for this example, same as the region to avoid duplicate notifications
            let identifier = region.identifier
            
            // the notification request object
            let request = UNNotificationRequest(
                identifier: identifier,
                content: content,
                trigger: trigger
            )
//            // MARK: - Core Data stack
//
//            lazy var persistentContainer: NSPersistentContainer = {
//                /*
//                 The persistent container for the application. This implementation
//                 creates and returns a container, having loaded the store for the
//                 application to it. This property is optional since there are legitimate
//                 error conditions that could cause the creation of the store to fail.
//                 */
//                let container = NSPersistentContainer(name: "nanoChallenge2")
//                container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//                  if let error = error as NSError? {
//                        // Replace this implementation with code to handle the error appropriately.
//                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                        /*
//                         Typical reasons for an error here include:
//                         * The parent directory does not exist, cannot be created, or disallows writing.
//                         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                         * The device is out of space.
//                         * The store could not be migrated to the current model version.
//                         Check the error message to determine what the actual problem was.
//                         */
//                       fatalError("Unresolved error \(error), \(error.userInfo)")
//                    }
//                })
//                return container
//            }()
//
//            // MARK: - Core Data Saving support
//
//            func saveContext () {
//                let context = persistentContainer.viewContext
//                if context.hasChanges {
//                    do {
//                        try context.save()
//                    } catch {
//                        // Replace this implementation with code to handle the error appropriately.
//                        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                     //   let nserror = error as NSError
//                       // fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//                    }
//                }
//            }
            
            // trying to add the notification request to notification center
            notificationCenter.add(request, withCompletionHandler: { (error) in
                if error != nil {
                    print("Error adding notification with identifier: \(identifier)")
                }
            })
        }
    }
    
    
    extension AppDelegate: CLLocationManagerDelegate {
        // called when user Exits a monitored region
        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            if region is CLCircularRegion {
                // Do what you want if this information
                self.handleEvent(forRegion: region)
            }
        }
        
        // called when user Enters a monitored region
        func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
            if region is CLCircularRegion {
                // Do what you want if this information
//                self.handleEvent(forRegion: region)
                print("enter region")
            }
        }
    }
    
    
    extension AppDelegate: UNUserNotificationCenterDelegate {
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            // when app is onpen and in foregroud
            completionHandler(.alert)
        }
        
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            
            // get the notification identifier to respond accordingly
            let identifier = response.notification.request.identifier
            
            // do what you need to do
            print(identifier)
            // ...
        }
}
