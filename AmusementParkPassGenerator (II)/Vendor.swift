//
//  Vendor.swift
//  AmusementParkPassGenerator (II)
//
//  Created by Leticia Rodriguez on 6/29/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import Foundation

class Vendor: Accessable, Swipeable {
    var access: Access
    
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let socialSecurityNumber: String?
    let dateOfBirth: String?
    let dateOfVisit: String?
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
    
    init(firstName: String?, lastName: String?, streetAddress:String, city:String, state: String, zipCode:String, socialSecurityNumber:String, dateOfBirth: String?, dateOfVisit: String?, vendorCompany: String ) throws {
        
        if firstName == "" || firstName == nil {
            throw EntrantDataError.missingName(description: "Name is required")
        }
        
        if lastName == "" || lastName == nil {
            throw EntrantDataError.missingLastName(description: "Lastname is required")
        }
        
        guard let dateOfBirth = dateOfBirth else {
            throw EntrantDataError.missingBirthday(description: "Date of birthday is required")
        }
        
        guard let dateOfVisit = dateOfVisit else {
            throw EntrantDataError.missingDateOfVisit(description: "Vendor date of visit is missing")
        }
        
        if vendorCompany == "" {
            throw EntrantDataError.missingVendorCompany(description: "Vendor company is missing")
        }
        
        try checkVendorCompany(company: vendorCompany)
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd-MM-yyyy"
        
        if dateFormatterGet.date(from: dateOfBirth) == nil || dateFormatterGet.date(from: dateOfVisit) == nil {
            throw EntrantDataError.dateFormatError(description: "Invalid date format")
        }
        
        try inputValidation(firstName: firstName!, lastName: lastName!, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: socialSecurityNumber)
        
        if vendorCompany.characters.count > 20 {
            throw EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input")
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
        var message = ""
        
        if isBirthdayDay(){
            message = "Happy Birthday \(String(describing: self.firstName))!!"
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

// MARK: - Helper Method

func checkVendorCompany(company: String) throws{
    switch company {
    case "Acme": break
    case "Orkin": break
    case "Fedex": break
    case "NW Electrical": break
    default: throw EntrantDataError.incorrectCompanyName(description: "Incorrect Company Name")
    }
}

