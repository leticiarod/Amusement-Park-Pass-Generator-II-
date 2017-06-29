//
//  PassGenerator.swift
//  AmusementParkPassGenerator
//
//  Created by Leticia Rodriguez on 5/23/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit

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

// MARK: Protocols

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

// MARK: Helper Methods

func inputValidation(firstName: String, lastName: String, streetAddress: String, city: String, state: String, zipCode: String, socialSecurityNumber: String?) throws{
    
    if firstName != ""{
        if firstName.characters.count < 2 {
            throw EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input")
        }
    }
    if lastName != ""{
        if lastName.characters.count < 2 {
            throw EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input")
        }
    }
    if streetAddress != "" {
        if streetAddress.characters.count < 2 {
            throw EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input")
        }
    }
    if city != "" {
        if city.characters.count < 2  {
            throw EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input")
        }
    }
    if state != "" {
        if state.characters.count < 2 {
            throw EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input")
        }
    }
    if zipCode != ""{
        if zipCode.characters.count != 5{
            throw EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input")
        }
    }
    
    if let socialSecurityNumber = socialSecurityNumber as String! {
       if socialSecurityNumber != "" {
        if socialSecurityNumber.characters.count != 11 {
            throw EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input")
        }
    }
    }
    
}

