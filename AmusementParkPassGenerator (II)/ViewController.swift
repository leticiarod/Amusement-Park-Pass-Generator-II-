//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Leticia Rodriguez on 5/21/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
var guest = Guest()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // UNCOMMENT the following block to test feature to prevent a guest from swiping into the same ride twice in row within 5 seconds
        
        /*
        do{
            // Create an instance of Guest to test method initialSwipe()
            guest = try Guest(firstName: "Guest1", lastName: "GuestLastName", streetAddress: "test", city: "test", state: "test", zipCode: "11800", socialSecurityNumber: "12334", dateOfBirth: Date(), type: .classic) // Be aware that dateOfBirth is the current date so is guest's birthday
            // Generate Privileges as established in Business Rules Matrix
            guest.generateAccessByEntrantType()
            // Initiate Swipe with timer of 5 seconds, to check if has access to the setted privileges
            guest.initialSwipe()
            // 3 seconds after a guest try to swipe again..
            secondSwipeWithDelay(seconds: 3)
        } catch {
            
            fatalError()
        }
        
        
 
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func secondSwipeWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            
            // Do a second swipe
            
            self.guest.initialSwipe()
            
            let permission = self.guest.permission
            switch permission {
            case .granted(let description, let message):
                                                        if let message = message {
                                                            print(" Permission for first swipe: \(description) \(message)")}
            case .denied(let description, let message):
                                                        if let message = message {
                                                            print("Permission for first swipe: \(description) \(message)")}
            }
        }
    }

}

