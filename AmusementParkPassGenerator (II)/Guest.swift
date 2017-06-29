//
//  Guest.swift
//  AmusementParkPassGenerator (II)
//
//  Created by Leticia Rodriguez on 6/29/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import Foundation
import UIKit


// Counter to set the timer
var seconds = 5 //This variable will hold a starting value of seconds. It could be any amount above 0.

var timer = Timer()
var isTimerRunning = false //This will be used to make sure only one timer is created at a time.

class Guest: Accessable, Swipeable {
    
    var access: Access
    
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let socialSecurityNumber: String?
    let dateOfBirth: String?
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
    
    init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String, dateOfBirth: String?, type: GuestType) throws {
        
        
        
        if type == GuestType.freeChild {
            guard let dateOfBirth = dateOfBirth else {
                throw EntrantDataError.missingBirthday(description: "Date of birthday is required")
            }
            let date = Date()
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: date)
            
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd-MM-yyyy"
            
            if let dateOfBirth = dateFormatterGet.date(from: dateOfBirth){
                let birthdayYear = calendar.component(.year, from: dateOfBirth)
                let kidAge = currentYear - birthdayYear
                
                if kidAge > 5 {
                    throw EntrantDataError.overFiveYearsOldError(description: "Free child must be under 5 years old")
                }
            }
        }
        
        
        if type == GuestType.senior {
            if firstName == "" {
                throw EntrantDataError.missingName(description: "Name is required")
            }
            
            if lastName == ""  {
                throw EntrantDataError.missingLastName(description: "Lastname is required")
                
            }
            guard let _ = dateOfBirth else {
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
        
        // Input validation to ensure that all text entries are of “reasonable” length
        
        try inputValidation(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-mm-yyyy"
        //let birthDate = String(describing: dateOfBirth)
        
        if let dateOfBirth = dateOfBirth as String!{
            if dateFormatterGet.date(from: dateOfBirth) == nil {
                throw EntrantDataError.dateFormatError(description: "Invalid date format")
            }
        }
        if zipCode != "" {
            let validZipCodeNumber = Int(zipCode)
            
            if validZipCodeNumber == nil {
                throw EntrantDataError.itemShouldBeNUmerical(description: "Zipcode must be a number")
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
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        
        if let dateString = dateOfBirth {
            let dateOfBirth = dateFormatterGet.date(from: dateString)
            let birthdayDay = calendar.component(.day, from: dateOfBirth!)
            let birthdayMonth = calendar.component(.month, from: dateOfBirth!)
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
