//
//  PassGenerator.swift
//  AmusementParkPassGenerator
//
//  Created by Leticia Rodriguez on 5/23/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit

// Counter to set the timer
var seconds = 5 //This variable will hold a starting value of seconds. It could be any amount above 0.

var timer = Timer()
var isTimerRunning = false //This will be used to make sure only one timer is created at a time.

enum GuestType {
    case classic
    case vip
    case freeChild
}

enum EmployeeType {
    case foodServices
    case rideServices
    case maintenance
    case manager
    
}

// Area Access Types

enum AreaAccess {
    case amusementAreas
    case kitchenAreas
    case rideControlAreas
    case maintenanceAreas
    case officeAreas
}

// Ride Access Types

enum RideAccess {
    case allRides
    case skipAllRideLines
    
}

// Discount Access

enum DiscountAccess {
    case onFood(percentage: Double)
    case onMarchandise(percentage: Double)
    
    
    static func == (left: DiscountAccess, right: DiscountAccess) -> Bool {
        
        switch (left, right) {
        case (let .onFood(percentage1), let .onFood(percentage2)):
            return percentage1 == percentage2
            
        case (let .onMarchandise(percentage1), let .onMarchandise(percentage2)):
            return percentage1 == percentage2

            default: return false // Cover all cases
            }
        }
    }

// Errors

enum EntrantDataError: Error {
    case missingBirthday(description: String)
    case missingName(description: String)
    case missingLastName(description: String)
    case missingStreetAddress(description: String)
    case missingCity(description: String)
    case missingState(description: String)
    case missingZipCode(description: String)
    case overFiveYearsOldError(description: String)
    
}


enum Permission {
    case granted(description: String, message: String?)
    case denied(description: String, message: String?)
}

struct Access {
    var areaAccess: [AreaAccess]? = Array()
    var rideAccess: [RideAccess]? = Array()
    var discountAccess: [DiscountAccess]? = Array()
    
    init(){
    }
    
    init(areaAccess: [AreaAccess]?,rideAccess: [RideAccess]?,discountAccess: [DiscountAccess]? ) {
        self.areaAccess = areaAccess
        self.rideAccess = rideAccess
        self.discountAccess = discountAccess
        
    }

}

class Employee {
    let firstName: String
    let lastName: String
    let streetAddress: String
    let city: String
    let state: String
    let zipCode: String
    let socialSecurityNumber: String?
    let dateOfBirth: Date?
    let type: EmployeeType
    
    
    
    init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String?, dateOfBirth: Date?, type: EmployeeType) throws {
        
        if firstName == "" {
            throw EntrantDataError.missingName(description: "Employee name is required")
            
        }
        
        if lastName == ""  {
            throw EntrantDataError.missingLastName(description: "Employee lastname is required")
            
        }

        if streetAddress == ""  {
            throw EntrantDataError.missingStreetAddress(description: "Employee Street Address is required")
            
        }
        if city == ""  {
            throw EntrantDataError.missingCity(description: "Employee city is required")
            
        }
        if state == ""  {
            throw EntrantDataError.missingState(description: "Employee state is required")
            
        }
        if zipCode == ""  {
            throw EntrantDataError.missingZipCode(description: "Employee zipcode is required")
            
        }

        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.socialSecurityNumber = socialSecurityNumber
        self.dateOfBirth = dateOfBirth
        self.type = type
        
    }
    
    
}

class HourlyEmployee: Employee, Accessable, Swipeable {
    var access: Access
    var permission: Permission
    
    override init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String?, dateOfBirth: Date?, type: EmployeeType) throws {
        access = Access(areaAccess: [],rideAccess: [],discountAccess: [])
        permission = .denied(description: "Access Denied", message: nil)
        try super.init(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber, dateOfBirth: dateOfBirth, type: type)
        
        }
 
    func generateAccessByEntrantType() -> Access {
        var areaAccessArray: [AreaAccess] = Array()
        var rideAccessArray: [RideAccess] = Array()
        var discountAccessArray: [DiscountAccess] = Array()
        switch self.type {
        case .foodServices:
            
            areaAccessArray.append(contentsOf: [.amusementAreas,.kitchenAreas])
                            rideAccessArray.append(contentsOf: [.allRides])
            discountAccessArray.append(contentsOf: [.onFood(percentage: 15), .onMarchandise(percentage: 25)])
        case .rideServices: areaAccessArray.append(contentsOf: [.amusementAreas,.rideControlAreas])
        rideAccessArray.append(contentsOf: [.allRides])
        discountAccessArray.append(contentsOf: [.onFood(percentage: 15), .onMarchandise(percentage: 25)])

        case .maintenance:  areaAccessArray.append(contentsOf: [.amusementAreas, .kitchenAreas, .rideControlAreas, .maintenanceAreas])
        rideAccessArray.append(contentsOf: [.allRides])
        discountAccessArray.append(contentsOf: [.onFood(percentage: 15), .onMarchandise(percentage: 25)])

        case .manager: areaAccessArray.append(contentsOf: [.amusementAreas, .kitchenAreas, .rideControlAreas, .maintenanceAreas,.officeAreas])
        rideAccessArray.append(contentsOf: [.allRides])
        discountAccessArray.append(contentsOf: [.onFood(percentage: 25), .onMarchandise(percentage: 25)])

            
        }
        
        access = Access(areaAccess: areaAccessArray, rideAccess: rideAccessArray, discountAccess: discountAccessArray)
        
        return self.access
    }
    
    func swipe() {
        var message: String = ""
        if isBirthdayDay() {
            message = "Happy birthday \(firstName) !!"
        }
        
        switch type {
        case .foodServices:
            if let areaAccessArray = self.access.areaAccess, let  rideAccessArray =                                             self.access.rideAccess, let discountAccessArray = self.access.discountAccess{
                if areaAccessArray.contains(AreaAccess.amusementAreas) || areaAccessArray.contains(AreaAccess.kitchenAreas) || rideAccessArray.contains(RideAccess.allRides) || contains(foodDiscount: 15, marchandiseDiscount: 25, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                
            }
        case .rideServices:
            if let areaAccessArray = self.access.areaAccess, let  rideAccessArray = self.access.rideAccess, let discountAccessArray = self.access.discountAccess{
                if areaAccessArray.contains(AreaAccess.amusementAreas) ||
                                areaAccessArray.contains(AreaAccess.rideControlAreas)  || rideAccessArray.contains(RideAccess.allRides) || contains(foodDiscount: 15, marchandiseDiscount: 25, discountAccessArray: discountAccessArray)
                {
                    print("discountAccessArray \(discountAccessArray)")
                                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                
            }
        case .maintenance:
            if let areaAccessArray = self.access.areaAccess, let  rideAccessArray =                                             self.access.rideAccess, let discountAccessArray = self.access.discountAccess{
            if areaAccessArray.contains(AreaAccess.amusementAreas) ||
                areaAccessArray.contains(AreaAccess.kitchenAreas) ||
                areaAccessArray.contains(AreaAccess.rideControlAreas) ||
                areaAccessArray.contains(AreaAccess.maintenanceAreas) || rideAccessArray.contains(RideAccess.allRides) || contains(foodDiscount: 15, marchandiseDiscount: 25, discountAccessArray: discountAccessArray) {
                self.permission = .granted(description: "Access Granted !", message: message)
            }
           
            }
        case .manager:
                        if let areaAccessArray = self.access.areaAccess, let  rideAccessArray = self.access.rideAccess, let discountAccessArray = self.access.discountAccess{
                                if areaAccessArray.contains(AreaAccess.amusementAreas) ||
                                    areaAccessArray.contains(AreaAccess.kitchenAreas) ||
                                    areaAccessArray.contains(AreaAccess.rideControlAreas) ||
                                    areaAccessArray.contains(AreaAccess.maintenanceAreas) ||
                                    areaAccessArray.contains(AreaAccess.officeAreas) || rideAccessArray.contains(RideAccess.allRides) ||
                                    contains(foodDiscount: 25, marchandiseDiscount: 25, discountAccessArray: discountAccessArray){
                                    self.permission = .granted(description: "Access Granted !", message: message)
                                }
                            
            }
       
    }
}
    
    func contains(foodDiscount: Double, marchandiseDiscount: Double, discountAccessArray: [DiscountAccess]) -> Bool {
        var  discountAccessArrayCopy: [DiscountAccess] = Array()
        var index = 0
        var contains = false
        for item in discountAccessArray{
            discountAccessArrayCopy.append(item)
        }
        
        while index < discountAccessArrayCopy.count {
            if let item = discountAccessArrayCopy.popLast(){
                if item == DiscountAccess.onFood(percentage: foodDiscount) {
                    contains = true
                }
                else {
                    if item == DiscountAccess.onMarchandise(percentage: marchandiseDiscount){
                        contains = true
                    }
                }
                
                }
            
            index += 1
        }
        return contains
    }
    
    func isBirthdayDay() -> Bool{
        
        let date = Date()
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: date)
        let currentMonth = calendar.component(.month, from: date)
        
        if let dateOfBirth = self.dateOfBirth{
            let birthdayDay = calendar.component(.day, from: dateOfBirth)
            let birthdayMonth = calendar.component(.month, from: dateOfBirth)
            if currentDay == birthdayDay && currentMonth == birthdayMonth{
                return true
            }
            else {
                return false
            }
        }
        // otherwise
        return false
    }


}

class Guest: Accessable, Swipeable {
    
    var access: Access
    
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let socialSecurityNumber: String?
    let dateOfBirth: Date?
    let type: GuestType
    var permission: Permission
    
    init(){
        self.firstName = nil
        self.lastName = nil
        self.streetAddress = nil
        self.city = nil
        self.state = nil
        self.zipCode = nil
        self.socialSecurityNumber = nil
        self.dateOfBirth = nil
        self.type = .classic
        access = Access(areaAccess: [],rideAccess: [],discountAccess: [])
        permission = .denied(description: "Access Denied", message: "")
    }
    
    init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String, dateOfBirth: Date?, type: GuestType) throws {
        
        if type == GuestType.freeChild {
            guard let dateOfBirth = dateOfBirth else {
                throw EntrantDataError.missingBirthday(description: "Date of birthday required")
            }
            
            let date = Date()
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: date)
            let birthdayYear = calendar.component(.year, from: dateOfBirth)
            let kidAge = currentYear - birthdayYear
            
            if kidAge > 5 {
                throw EntrantDataError.overFiveYearsOldError(description: "Free child must be under 5 years old")
            }
            
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.socialSecurityNumber = socialSecurityNumber
        self.dateOfBirth = dateOfBirth
        self.type = type
        access = Access(areaAccess: [],rideAccess: [],discountAccess: [])
        permission = .denied(description: "Access Denied", message: "")
    }
    
    func generateAccessByEntrantType() -> Access {
        var areaAccessArray: [AreaAccess] = Array()
        var rideAccessArray: [RideAccess] = Array()
        var discountAccessArray: [DiscountAccess] = Array()
        switch self.type {
        case .classic:
            areaAccessArray.append(contentsOf: [.amusementAreas])
            rideAccessArray.append(contentsOf: [.allRides])
        case .vip: areaAccessArray.append(contentsOf: [.amusementAreas])
        rideAccessArray.append(contentsOf: [.allRides,.skipAllRideLines])
        discountAccessArray.append(contentsOf: [.onFood(percentage: 10), .onMarchandise(percentage: 20)])
            
        case .freeChild:  areaAccessArray.append(contentsOf: [.amusementAreas])
        rideAccessArray.append(contentsOf: [.allRides])
          
        }
        
        access = Access(areaAccess: areaAccessArray, rideAccess: rideAccessArray, discountAccess: discountAccessArray)
        
        return self.access
    }
    
    func initialSwipe(){
        // Run timer
        if isTimerRunning == false {
            isTimerRunning = true
            swipe()
            timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(self.updateCounter)), userInfo: nil, repeats: true)
        }
        else {
            print("You are not able to swipe, try again in a few seconds")
        }
        

    }
    
    func swipe() {
        var message: String = ""
        if isBirthdayDay() {
            if let firstName = self.firstName {
            message = "Happy birthday \(firstName)!!"
            }
            else{
                message = "Happy birthday!!"
            }
        }
        
        
        switch type {
        case .classic:
            if let areaAccessArray = self.access.areaAccess, let  rideAccessArray =                                             self.access.rideAccess {
                if areaAccessArray.contains(AreaAccess.amusementAreas) || rideAccessArray.contains(RideAccess.allRides)  {
                    self.permission = .granted(description: "Access Granted !", message: message)
                    }
               
            }
        case .vip:
            if let areaAccessArray = self.access.areaAccess, let  rideAccessArray =                                             self.access.rideAccess, let discountAccessArray = self.access.discountAccess{
                if areaAccessArray.contains(AreaAccess.amusementAreas) || rideAccessArray.contains(RideAccess.allRides) || rideAccessArray.contains(RideAccess.skipAllRideLines) || contains(foodDiscount: 10, marchandiseDiscount: 20, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
              
            }
        case .freeChild:
            if let areaAccessArray = self.access.areaAccess, let  rideAccessArray =                                             self.access.rideAccess {
                if areaAccessArray.contains(AreaAccess.amusementAreas) || rideAccessArray.contains(RideAccess.allRides) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
            
            }
    }
}
    
    func contains(foodDiscount: Double, marchandiseDiscount: Double, discountAccessArray: [DiscountAccess]) -> Bool {
        var  discountAccessArrayCopy: [DiscountAccess] = Array()
        var index = 0
        var contains = false
        for item in discountAccessArray{
            discountAccessArrayCopy.append(item)
        }
        
        while index < discountAccessArrayCopy.count {
            if let item = discountAccessArrayCopy.popLast(){
                if item == DiscountAccess.onFood(percentage: foodDiscount) {
                    contains = true
                }
                else {
                    if item == DiscountAccess.onMarchandise(percentage: marchandiseDiscount){
                        contains = true
                    }
                }
                
            }
            
            index += 1
        }
        return contains
    }
    
    func isBirthdayDay() -> Bool{
        
        let date = Date()
        let calendar = Calendar.current
        let currentDay = calendar.component(.day, from: date)
        let currentMonth = calendar.component(.month, from: date)
        
        if let dateOfBirth = self.dateOfBirth{
            let birthdayDay = calendar.component(.day, from: dateOfBirth)
            let birthdayMonth = calendar.component(.month, from: dateOfBirth)
            if currentDay == birthdayDay && currentMonth == birthdayMonth{
                return true
            }
            else {
                return false
            }
        }
        // otherwise
        return false
    }
    
    // MARK: - Timer Methods
    
    func stopTimer(){
        timer.invalidate()
    }
    
    // update counter for Timer
     @objc func updateCounter() {
        if seconds < 1 { // if time out
            timer.invalidate()
            isTimerRunning = false
            seconds = 5
        } else {
            seconds -= 1
            print("Seconds \(seconds)")
        }
       
    }

}

// Protocols

protocol Accessable {
    var access: Access {get set}
    
    func generateAccessByEntrantType() -> Access
}

protocol Swipeable {
    func swipe()
    
}










