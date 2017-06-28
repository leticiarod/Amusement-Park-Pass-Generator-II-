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
    case senior
    case seassonPass
}

enum EmployeeType {
    case foodServices
    case rideServices
    case maintenance
    case manager
    case nonType
    
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
    case missingDateOfVisit(description: String)
    case missingVendorCompany(description: String)
    case missingName(description: String)
    case missingLastName(description: String)
    case missingStreetAddress(description: String)
    case missingCity(description: String)
    case missingState(description: String)
    case missingZipCode(description: String)
    case overFiveYearsOldError(description: String)
    case dateFormatError(description: String)
    case itemShouldBeNUmerical(description: String)
    case incorrectLengthOfString(description: String)
    
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
    
    init(){
        self.firstName = ""
        self.lastName = ""
        self.streetAddress = ""
        self.city = ""
        self.state = ""
        self.zipCode = ""
        self.socialSecurityNumber = nil
        self.dateOfBirth = nil
        self.type = .nonType
    }
    
    init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String?, dateOfBirth: Date?, type: EmployeeType) throws {
        
        if firstName == "" {
            throw EntrantDataError.missingName(description: "Name is required")
        }
        
        if lastName == ""  {
            throw EntrantDataError.missingLastName(description: "Lastname is required")
        }

        if streetAddress == ""  {
            throw EntrantDataError.missingStreetAddress(description: "Street Address is required")
        }
        
        if city == ""  {
            throw EntrantDataError.missingCity(description: "City is required")
        }
        
        if state == ""  {
            throw EntrantDataError.missingState(description: "State is required")
        }
        
        if zipCode == ""  {
            throw EntrantDataError.missingZipCode(description: "Zipcode is required")
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
 
    override init(){
        self.access = Access(areaAccess: [],rideAccess: [],discountAccess: [])
        self.permission = .denied(description: "Access Denied", message: nil)
        super.init()
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

        case .nonType: break
        }
        
        access = Access(areaAccess: areaAccessArray, rideAccess: rideAccessArray, discountAccess: discountAccessArray)
        
        return self.access
    }
    
    func swipe(areaAccess: AreaAccess?, rideAccess: RideAccess?, discountAccess: DiscountAccess?) {
        permission = .denied(description: "Access Denied", message: "")
        var message: String = ""
        if isBirthdayDay() {
            message = "Happy birthday \(firstName) !!"
        }
        
        if let areaAccess = areaAccess {
        switch areaAccess {
        case .amusementAreas: if let areaAccessArray = self.access.areaAccess{
            if areaAccessArray.contains(AreaAccess.amusementAreas){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
        case .kitchenAreas: if let areaAccessArray = self.access.areaAccess{
            if areaAccessArray.contains(AreaAccess.kitchenAreas){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
            
        case .maintenanceAreas: if let areaAccessArray = self.access.areaAccess{
            if areaAccessArray.contains(AreaAccess.maintenanceAreas){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
            
        case .officeAreas: if let areaAccessArray = self.access.areaAccess{
            if areaAccessArray.contains(AreaAccess.officeAreas){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
            
        case .rideControlAreas: if let  areaAccessArray = self.access.areaAccess {
            if areaAccessArray.contains(AreaAccess.rideControlAreas) {
                self.permission = .granted(description: "Access Granted !", message: message)
            }}
            
        }
    }
    
    if let rideAccess = rideAccess {
        switch rideAccess {
        case .allRides: if let rideAccessArray = self.access.rideAccess {
            if rideAccessArray.contains(RideAccess.allRides){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
        case .skipAllRideLines: if let rideAccessArray = self.access.rideAccess {
            if rideAccessArray.contains(RideAccess.skipAllRideLines){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
        }
    }
    
    if let discountAccess = discountAccess {
        switch discountAccess {
        case .onFood(percentage: 10) : if let discountAccessArray = self.access.discountAccess{
            if contains(foodDiscount: 10, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
        case  .onFood(percentage: 15):
            if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 15, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
            
        case .onFood(percentage: 25): if let discountAccessArray = self.access.discountAccess{
            if contains(foodDiscount: 25, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
            
        case .onMarchandise(percentage: 20): if let discountAccessArray = self.access.discountAccess{
            if contains(foodDiscount: nil, merchDiscount: 20, discountAccessArray: discountAccessArray) {
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
            
        case .onMarchandise(percentage: 25):
            
            if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil, merchDiscount: 25, discountAccessArray: discountAccessArray) {
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
            
        case .onMarchandise(percentage: 10): if let discountAccessArray = self.access.discountAccess{
            if contains(foodDiscount: nil, merchDiscount: 10, discountAccessArray: discountAccessArray) {
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
         default: break
            
        }
    }
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

class ContractEmployee: Employee, Accessable,Swipeable {
    var access: Access
    var permission: Permission
    let projectID: String
    
    override init(){
        self.access = Access(areaAccess: [],rideAccess: [],discountAccess: [])
        self.permission = .denied(description: "Access Denied", message: nil)
        self.projectID = "0000"
        super.init()
    }
    
     init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String?, dateOfBirth: Date?, type: EmployeeType, projectID: String) throws {
        access = Access(areaAccess: [],rideAccess: [],discountAccess: [])
        permission = .denied(description: "Access Denied", message: nil)
        self.projectID = projectID
        try super.init(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber, dateOfBirth: dateOfBirth, type: type)
        
    }
    
    func generateAccessByEntrantType() -> Access {
        var areaAccessArray: [AreaAccess] = Array()
        let rideAccessArray: [RideAccess] = Array()
        let discountAccessArray: [DiscountAccess] = Array()
        
        switch self.projectID {
        case "1001": areaAccessArray.append(contentsOf: [.amusementAreas,.rideControlAreas])
        case "1002": areaAccessArray.append(contentsOf: [.amusementAreas, .rideControlAreas, .maintenanceAreas])
            case "1003": areaAccessArray.append(contentsOf: [.amusementAreas, .rideControlAreas, .kitchenAreas, .maintenanceAreas, .officeAreas])
            case "2001": areaAccessArray.append(contentsOf: [.officeAreas])
            case "2002": areaAccessArray.append(contentsOf: [.kitchenAreas, .maintenanceAreas])
        default: break
        }
        
        access = Access(areaAccess: areaAccessArray, rideAccess: rideAccessArray, discountAccess: discountAccessArray)
        return self.access

    }
    
    func swipe(areaAccess: AreaAccess?, rideAccess: RideAccess?, discountAccess: DiscountAccess?) {
        permission = .denied(description: "Access Denied", message: "")
        let message = ""
        
        if let areaAccess = areaAccess{
            
            switch areaAccess {
            case .amusementAreas: if let areaAccessArray = self.access.areaAccess{
                if areaAccessArray.contains(AreaAccess.amusementAreas){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            case .kitchenAreas: if let areaAccessArray = self.access.areaAccess{
                if areaAccessArray.contains(AreaAccess.kitchenAreas){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .maintenanceAreas: if let areaAccessArray = self.access.areaAccess{
                if areaAccessArray.contains(AreaAccess.maintenanceAreas){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .officeAreas: if let areaAccessArray = self.access.areaAccess{
                if areaAccessArray.contains(AreaAccess.officeAreas){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .rideControlAreas: if let  areaAccessArray = self.access.areaAccess {
                if areaAccessArray.contains(AreaAccess.rideControlAreas) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }}
                
            }
        }
        
        if let rideAccess = rideAccess {
            switch rideAccess {
            case .allRides: if let rideAccessArray = self.access.rideAccess {
                if rideAccessArray.contains(RideAccess.allRides){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            case .skipAllRideLines: if let rideAccessArray = self.access.rideAccess {
                if rideAccessArray.contains(RideAccess.skipAllRideLines){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            }
        }
        
        if let discountAccess = discountAccess {
            switch discountAccess {
            case .onFood(percentage: 10) : if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 10, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            case  .onFood(percentage: 15): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 15, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .onFood(percentage: 25): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 25, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .onMarchandise(percentage: 20): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil, merchDiscount: 20, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .onMarchandise(percentage: 25): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil, merchDiscount: 25, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .onMarchandise(percentage: 10): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil, merchDiscount: 10, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            default: break
                
            }
        }
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
                throw EntrantDataError.missingBirthday(description: "Date of birthday is required")
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
        
        if type == GuestType.senior {
            if firstName == "" {
                throw EntrantDataError.missingName(description: "Name is required")
                
            }
            
            if lastName == ""  {
                throw EntrantDataError.missingLastName(description: "Lastname is required")
                
            }
            
            if dateOfBirth == nil {
                throw EntrantDataError.missingBirthday(description: "Date of birthday is required")
            }
        }
        
        if type == GuestType.seassonPass {
            if firstName == "" {
                throw EntrantDataError.missingName(description: "Name is required")
                
            }
            
            if lastName == ""  {
                throw EntrantDataError.missingLastName(description: "Lastname is required")
                
            }
            
            if streetAddress == ""  {
                throw EntrantDataError.missingStreetAddress(description: "Street Address is required")
                
            }
            if city == ""  {
                throw EntrantDataError.missingCity(description: "City is required")
                
            }
            if state == ""  {
                throw EntrantDataError.missingState(description: "State is required")
                
            }
            if zipCode == ""  {
                throw EntrantDataError.missingZipCode(description: "Zipcode is required")
                
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
          
        case .senior:   areaAccessArray.append(contentsOf: [.amusementAreas])
                        rideAccessArray.append(contentsOf: [.allRides, .skipAllRideLines])
                        discountAccessArray.append(contentsOf: [.onFood(percentage: 10), .onMarchandise(percentage: 10)])
        case .seassonPass: areaAccessArray.append(contentsOf: [.amusementAreas])
                           rideAccessArray.append(contentsOf: [.allRides, .skipAllRideLines])
                           discountAccessArray.append(contentsOf: [.onFood(percentage: 10), .onMarchandise(percentage: 20)])
        }
        
        access = Access(areaAccess: areaAccessArray, rideAccess: rideAccessArray, discountAccess: discountAccessArray)
        
        return self.access
    }
    
    func initialSwipe(areaAccess: AreaAccess?, rideAccess: RideAccess?, discountAccess: DiscountAccess?) -> String? {
        var message: String? = nil
        // Run timer
        if isTimerRunning == false {
            isTimerRunning = true
            swipe(areaAccess: areaAccess, rideAccess: rideAccess, discountAccess: discountAccess)
            timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: (#selector(self.updateCounter)), userInfo: nil, repeats: true)
        }
        else {
            message = "You are not able to swipe, try again in a few seconds"
            print("You are not able to swipe, try again in a few seconds")
        }
        
        return message
    }
    
    func swipe(areaAccess: AreaAccess?, rideAccess: RideAccess?, discountAccess: DiscountAccess?) {
        permission = .denied(description: "Access Denied", message: "")
        var message: String = ""
        if isBirthdayDay() {
            if let firstName = self.firstName {
            message = "Happy birthday \(firstName)!!"
            }
            else{
                message = "Happy birthday!!"
            }
        }
        
        if let areaAccess = areaAccess{
        
        switch areaAccess {
        case .amusementAreas: if let areaAccessArray = self.access.areaAccess{
            if areaAccessArray.contains(AreaAccess.amusementAreas){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }
        case .kitchenAreas: if let areaAccessArray = self.access.areaAccess{
            if areaAccessArray.contains(AreaAccess.kitchenAreas){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }

        case .maintenanceAreas: if let areaAccessArray = self.access.areaAccess{
            if areaAccessArray.contains(AreaAccess.maintenanceAreas){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }

        case .officeAreas: if let areaAccessArray = self.access.areaAccess{
            if areaAccessArray.contains(AreaAccess.officeAreas){
                self.permission = .granted(description: "Access Granted !", message: message)
            }
            }

        case .rideControlAreas: if let  areaAccessArray = self.access.areaAccess {
                                    if areaAccessArray.contains(AreaAccess.rideControlAreas) {
            self.permission = .granted(description: "Access Granted !", message: message)
            }}

        }
    }
        
        if let rideAccess = rideAccess {
            switch rideAccess {
            case .allRides: if let rideAccessArray = self.access.rideAccess {
                                if rideAccessArray.contains(RideAccess.allRides){
                                    self.permission = .granted(description: "Access Granted !", message: message)
                                }
                            }
            case .skipAllRideLines: if let rideAccessArray = self.access.rideAccess {
                if rideAccessArray.contains(RideAccess.skipAllRideLines){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            }
        }
        
        if let discountAccess = discountAccess {
            switch discountAccess {
            case .onFood(percentage: 10) : if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 10, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            case  .onFood(percentage: 15): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 15, merchDiscount:nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }

            case .onFood(percentage: 25): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 25, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }

            case .onMarchandise(percentage: 20): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil, merchDiscount: 20, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }

            case .onMarchandise(percentage: 25): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil,  merchDiscount: 25, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }

            case .onMarchandise(percentage: 10): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil, merchDiscount: 10, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            default: break
              
            }
        }
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

class Vendor: Accessable, Swipeable {
    var access: Access
    
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let socialSecurityNumber: String?
    let dateOfBirth: Date?
    let dateOfVisit: Date?
    let vendorCompany: String
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
        self.dateOfVisit = nil
        self.vendorCompany = ""
        access = Access(areaAccess: [],rideAccess: [],discountAccess: [])
        permission = .denied(description: "Access Denied", message: "")
    }
    
    init(firstName: String?, lastName: String?, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String, dateOfBirth: Date?, dateOfVisit: Date?, vendorCompany: String ) throws {
        
            if firstName == "" || firstName == nil {
                throw EntrantDataError.missingName(description: "Name is required")
            }
            
            if lastName == "" || lastName == nil {
                throw EntrantDataError.missingLastName(description: "Lastname is required")
            }
        
            if dateOfBirth == nil {
                throw EntrantDataError.missingBirthday(description: "Date of birthday is required")
            }
        
            if dateOfVisit == nil {
                throw EntrantDataError.missingDateOfVisit(description: "Vendor date of visit is missing")
            }
        
            if vendorCompany == "" {
                throw EntrantDataError.missingVendorCompany(description: "Vendor company is missing")
            }
        
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.socialSecurityNumber = socialSecurityNumber
        self.dateOfBirth = dateOfBirth
        self.dateOfVisit = dateOfVisit
        self.vendorCompany = vendorCompany
        access = Access(areaAccess: [],rideAccess: [],discountAccess: [])
        permission = .denied(description: "Access Denied", message: "")
    }
    
    func generateAccessByEntrantType() -> Access {
        var areaAccessArray: [AreaAccess] = Array()
        let rideAccessArray: [RideAccess] = Array()
        let discountAccessArray: [DiscountAccess] = Array()
        
        switch self.vendorCompany {
        case "Acme": areaAccessArray.append(contentsOf: [.kitchenAreas])
        case "Orkin": areaAccessArray.append(contentsOf: [.amusementAreas, .rideControlAreas, .kitchenAreas])
        case "Fedex": areaAccessArray.append(contentsOf: [.maintenanceAreas, .officeAreas])
        case "NW Electrical": areaAccessArray.append(contentsOf: [.amusementAreas, .rideControlAreas, .kitchenAreas, .maintenanceAreas, .officeAreas])
        default: break
        }
        
        access = Access(areaAccess: areaAccessArray, rideAccess: rideAccessArray, discountAccess: discountAccessArray)
        return self.access
        

    }
    
    func swipe(areaAccess: AreaAccess?, rideAccess: RideAccess?, discountAccess: DiscountAccess?) {
        permission = .denied(description: "Access Denied", message: "")
        let message = ""
        
        if let areaAccess = areaAccess{
            
            switch areaAccess {
            case .amusementAreas: if let areaAccessArray = self.access.areaAccess{
                if areaAccessArray.contains(AreaAccess.amusementAreas){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            case .kitchenAreas: if let areaAccessArray = self.access.areaAccess{
                if areaAccessArray.contains(AreaAccess.kitchenAreas){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .maintenanceAreas: if let areaAccessArray = self.access.areaAccess{
                if areaAccessArray.contains(AreaAccess.maintenanceAreas){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .officeAreas: if let areaAccessArray = self.access.areaAccess{
                if areaAccessArray.contains(AreaAccess.officeAreas){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .rideControlAreas: if let  areaAccessArray = self.access.areaAccess {
                if areaAccessArray.contains(AreaAccess.rideControlAreas) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }}
                
            }
        }
        
        if let rideAccess = rideAccess {
            switch rideAccess {
            case .allRides: if let rideAccessArray = self.access.rideAccess {
                if rideAccessArray.contains(RideAccess.allRides){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            case .skipAllRideLines: if let rideAccessArray = self.access.rideAccess {
                if rideAccessArray.contains(RideAccess.skipAllRideLines){
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            }
        }
        
        if let discountAccess = discountAccess {
            switch discountAccess {
            case .onFood(percentage: 10) : if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 10, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
            case  .onFood(percentage: 15): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 15, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .onFood(percentage: 25): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: 25, merchDiscount: nil, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .onMarchandise(percentage: 20): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount:nil, merchDiscount: 20, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .onMarchandise(percentage: 25): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil, merchDiscount: 25, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                
            case .onMarchandise(percentage: 10): if let discountAccessArray = self.access.discountAccess{
                if contains(foodDiscount: nil, merchDiscount: 10, discountAccessArray: discountAccessArray) {
                    self.permission = .granted(description: "Access Granted !", message: message)
                }
                }
                default: break
                
            }
        }
    }
}

// Protocols

protocol Accessable {
    var access: Access {get set}
    
    func generateAccessByEntrantType() -> Access
}

protocol Swipeable {
    func swipe(areaAccess: AreaAccess?, rideAccess: RideAccess?, discountAccess: DiscountAccess?)
    
}

extension Swipeable {
    func contains(foodDiscount: Double?, merchDiscount: Double?, discountAccessArray: [DiscountAccess]) -> Bool {
        var  discountAccessArrayCopy: [DiscountAccess] = Array()
        var index = 0
        var contains = false
        for item in discountAccessArray{
            discountAccessArrayCopy.append(item)
        }
        
        while index < discountAccessArrayCopy.count {
            if let discount = foodDiscount{
                if discountAccessArrayCopy[index] == DiscountAccess.onFood(percentage: discount) {
                    contains = true
                }
            }
            else {
                if let discount = merchDiscount {
                    if discountAccessArrayCopy[index] == DiscountAccess.onMarchandise(percentage: discount){
                        contains = true
                    }
                }
            }
            index += 1
        }
        return contains
    }
}
