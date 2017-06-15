//
//  PlugValues.swift
//  AmusementParkPassGenerator
//
//  Created by Leticia Rodriguez on 5/25/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

@testable import AmusementParkPassGenerator__II_
import Foundation
import UIKit

// Data Collections for Plug Values

struct EntrantTest {
    
var firstName: String
var lastName: String
var streetAddress: String
var city: String
var state: String
var zipCode: String
var socialSecurityNumber: String?
var dateOfBirth: Date?
var employeeType: EmployeeType?
var guestType: GuestType?
var areaAccess: [AreaAccess]? = Array()
var rideAccess: [RideAccess]? = Array()
var discountAccess: [DiscountAccess]? = Array()

}


struct PlugValues {
    
    static var entrantTest: EntrantTest {
        get {
            var et = EntrantTest(firstName: "Entrant1", lastName: "Smith", streetAddress: "Williman", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: "1234", dateOfBirth: Date(), employeeType: nil, guestType: nil, areaAccess: [], rideAccess: [], discountAccess: [])
    
            // Uncomment the following lines and set the value as you wish in order to modify some of the EntrantTest fields (optional)
            
               et.firstName = "leti"
            // et.lastName =
            // et.streetAddress =
            // et.city =
            // et.state =
            // et.zipCode =
            // et.dateOfBirth =
            
            // Uncomment ONE of the following lines to set the entrant type (this is required, otherwise GenerateAccessByEntrantType test won't work)
            
            // et.employeeType = EmployeeType.rideServices
            // et.employeeType = EmployeeType.foodServices
            // et.employeeType = EmployeeType.maintenance
            // et.employeeType = EmployeeType.manager
               et.guestType = GuestType.classic
            // et.guestType = GuestType.freeChild
            // et.guestType = GuestType.vip
            
            
            // Uncomment ONE of the following lines in order to set the privileges of each type of entrant to test SUCCEED swipe method
            
            // For Hourly Employee - Food Services
            /*
                et.areaAccess = [.amusementAreas,.kitchenAreas]
                et.rideAccess = [.allRides]
                et.discountAccess = [.onFood(percentage: 15), .onMarchandise(percentage: 25)]
            */
            
            /*
             // For Hourly Employee - Ride Control Areas
             
                et.areaAccess = [.amusementAreas,.rideControlAreas]
                et.rideAccess = [.allRides]
                et.discountAccess = [.onFood(percentage: 15), .onMarchandise(percentage: 25)]
             */
            
            /*
             // For Hourly Employee - Maintenance
                
                et.areaAccess = [.amusementAreas, .kitchenAreas, .rideControlAreas, .maintenanceAreas]
                et.rideAccess =  [.allRides]
                et.discountAccess = [.onFood(percentage: 15), .onMarchandise(percentage: 25)]
             */
            
            /*
             // For Hourly Employee - Manager
                
                et.areaAccess =  [.amusementAreas, .kitchenAreas, .rideControlAreas, .maintenanceAreas,.officeAreas]
                et.rideAccess = [.allRides]
                et.discountAccess = [.onFood(percentage: 25), .onMarchandise(percentage: 25)]
             */
            
            ///*
             // For Classic Guest
             
                et.areaAccess = [.amusementAreas]
                et.rideAccess =  [.allRides]
            // */
            
            /*
             // For VIP Guest
             
                et.areaAccess = [.amusementAreas]
                et.rideAccess = [.allRides,.skipAllRideLines]
                et.discountAccess = [.onFood(percentage: 10), .onMarchandise(percentage: 20)]
             */
            
            /*
             // For Free Child
                et.areaAccess = [.amusementAreas]
                et.rideAccess = [.allRides]
             */
            
            // Uncomment ONE of the following lines in order to set the privileges of each type of entrant to test FAILED swipe method

            // For Hourly Employee - Food Services
            /*
             et.areaAccess = [.amusementAreas,.kitchenAreas]
             et.rideAccess = [.allRides]
             et.discountAccess = [.onFood(percentage: 25), .onMarchandise(percentage: 40)]
             */
            
            /*
             // For Hourly Employee - Ride Control Areas
             
             et.areaAccess = [.amusementAreas,.rideControlAreas]
             et.rideAccess = [.allRides]
             et.discountAccess = [.onFood(percentage: 20)]
             */
            
            /*
             // For Hourly Employee - Maintenance
             
             et.areaAccess = [.amusementAreas, .kitchenAreas, .rideControlAreas, .maintenanceAreas]
             et.rideAccess =  [.allRides]
             et.discountAccess = [.onFood(percentage: 15), .onMarchandise(percentage: 25)]
             */
            
            /*
             // For Hourly Employee - Manager
             
             et.areaAccess =  [.amusementAreas, .kitchenAreas, .maintenanceAreas,.officeAreas]
             et.rideAccess = [.allRides]
             et.discountAccess = [.onFood(percentage: 25)]
             */
            
            /*
            // For Classic Guest
            
            et.areaAccess = [.kitchenAreas]
            et.rideAccess =  [.allRides]
             */
            
            /*
             // For VIP Guest
             
             et.areaAccess = [.amusementAreas]
             et.discountAccess = [.onFood(percentage: 10), .onMarchandise(percentage: 20)]
             */
            
            /*
             // For Free Child
             et.areaAccess = [.amusementAreas]
             et.rideAccess = [.skip]
             */
            
            return et
        }
        
    }
    
   

}
