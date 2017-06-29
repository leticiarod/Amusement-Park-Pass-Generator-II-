//
//  Employee.swift
//  AmusementParkPassGenerator (II)
//
//  Created by Leticia Rodriguez on 6/29/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import Foundation

class Employee {
    let firstName: String
    let lastName: String
    let streetAddress: String
    let city: String
    let state: String
    let zipCode: String
    let socialSecurityNumber: String?
    let dateOfBirth: String?
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
    
    init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String?, dateOfBirth: String?, type: EmployeeType) throws {
        
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
        
        let validZipCodeNumber = Int(zipCode)
        
        if validZipCodeNumber == nil {
            throw EntrantDataError.itemShouldBeNUmerical(description: "Zipcode must be a number")
        }
        
        // Input validation to ensure that all text entries are of “reasonable” length
        try inputValidation(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber)
        
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
    
    override init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String?, dateOfBirth: String?, type: EmployeeType) throws {
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
    
    init(firstName: String, lastName: String, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String?, dateOfBirth: String?, type: EmployeeType, projectID: String) throws {
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
