//
//  AmusementParkPassGeneratorTests.swift
//  AmusementParkPassGeneratorTests
//
//  Created by Leticia Rodriguez on 5/21/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import XCTest
@testable import AmusementParkPassGenerator

class AmusementParkPassGeneratorTests: XCTestCase {
    
    var dateFormatter: DateFormatter = DateFormatter()
    var date: Date? = Date()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        dateFormatter.dateFormat = "dd-mm-yyyy"
        date = dateFormatter.date(from: "20-10-1989")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // Test that you can create a HourlyEmployee object correctly, that means, all required properties are setted correctly in the init method.
    func testInitMethodHourlyEmployee(){
        
        do{
            let employee = try HourlyEmployee(firstName: "Employee1", lastName: "Smith", streetAddress: "Gregorio Suarez", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: "1234", dateOfBirth: (date)!, type: EmployeeType.manager)
            XCTAssert(employee.firstName == "Employee1")
            XCTAssert(employee.lastName == "Smith")
            XCTAssert(employee.streetAddress == "Gregorio Suarez")
            XCTAssert(employee.city == "Montevideo")
            XCTAssert(employee.state == "Montevideo")
            XCTAssert(employee.zipCode == "11800")
            XCTAssert(employee.socialSecurityNumber == "1234")
            XCTAssert(employee.dateOfBirth == date)
            XCTAssert(employee.type == EmployeeType.manager)
            
        } catch let error {
            XCTFail("Caught error: \(error)")
        }
    }
    
    
    // Test that you can create a Guest object correctly, that means, all required properties are setted correctly in the init method.
    func testInitMethodGuest(){
        
        do {
            let guest = try Guest(firstName: "Guest1", lastName: "Roberts", streetAddress: "Williman", city: "Montevideo", state: "Montevideo", zipCode: "11300", socialSecurityNumber: "4567", dateOfBirth: date, type: GuestType.classic)
                
            XCTAssert(guest.firstName == "Guest1")
            XCTAssert(guest.lastName == "Roberts")
            XCTAssert(guest.streetAddress == "Williman")
            XCTAssert(guest.city == "Montevideo")
            XCTAssert(guest.state == "Montevideo")
            XCTAssert(guest.zipCode == "11300")
            XCTAssert(guest.socialSecurityNumber == "4567")
            XCTAssert(guest.dateOfBirth == date)
            XCTAssert(guest.type == GuestType.classic)
            
        } catch let error {
            XCTFail("Caught error: \(error)")
        }
    }
    
    // Test that setting a empty value as first name in HourlyEmployee throws a missingName error.
    func testInitMethod_settingEmptyValueAsFirstNameInHourlyEmployee_ThrowsMissingNameError() {
        
        XCTAssertThrowsError(try HourlyEmployee(firstName: "", lastName: "Smith", streetAddress: "Gregorio Suarez", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: "1234", dateOfBirth: (date)!, type: EmployeeType.manager)
        ) { error in
            guard case EntrantDataError.missingName(let description) = error else {
                return XCTFail()
            }
            
            XCTAssertEqual(description, "Employee name is required")
        }
    }

    // Test that setting a empty value as last name in HourlyEmployee throws a missingLastName error.
    func testInitMethod_settingEmptyValueAsLastNameInHourlyEmployee_ThrowsMissingLastNameError() {
        
        XCTAssertThrowsError(try HourlyEmployee(firstName: "Employee1", lastName: "", streetAddress: "Gregorio Suarez", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: "1234", dateOfBirth: (date)!, type: EmployeeType.manager)
        ) { error in
            guard case EntrantDataError.missingLastName(let description) = error else {
                return XCTFail()
            }
            
            XCTAssertEqual(description, "Employee lastname is required")
        }
    }


    // Test that setting a empty value as street address in HourlyEmployee throws a missingStreetAddress error.
    func testInitMethod_settingEmptyValueAsStreetAddressInHourlyEmployee_ThrowsMissingStreetAddressError() {
        
        XCTAssertThrowsError(try HourlyEmployee(firstName: "Employee1", lastName: "Smith", streetAddress: "", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: "1234", dateOfBirth: (date)!, type: EmployeeType.manager)
        ) { error in
            guard case EntrantDataError.missingStreetAddress(let description) = error else {
                return XCTFail()
            }
            
            XCTAssertEqual(description, "Employee Street Address is required")
        }
    }
    
    // Test that setting a empty value as city in HourlyEmployee throws a missingCity error.
    func testInitMethod_settingEmptyValueAsCityInHourlyEmployee_ThrowsMissingCityError() {
        
        XCTAssertThrowsError(try HourlyEmployee(firstName: "Employee1", lastName: "Smith", streetAddress: "Gregorio Suarez", city: "", state: "Montevideo", zipCode: "11800", socialSecurityNumber: "1234", dateOfBirth: (date)!, type: EmployeeType.manager)
        ) { error in
            guard case EntrantDataError.missingCity(let description) = error else {
                return XCTFail()
            }
            
            XCTAssertEqual(description, "Employee city is required")
        }
    }
    
    // Test that setting a empty value as state in HourlyEmployee throws a missingState error.
    func testInitMethod_settingEmptyValueAsStateInHourlyEmployee_ThrowsMissingStateError() {
        
        XCTAssertThrowsError(try HourlyEmployee(firstName: "Employee1", lastName: "Smith", streetAddress: "Gregorio Suarez", city: "Montevideo", state: "", zipCode: "11800", socialSecurityNumber: "1234", dateOfBirth: (date)!, type: EmployeeType.manager)
        ) { error in
            guard case EntrantDataError.missingState(let description) = error else {
                return XCTFail()
            }
            
            XCTAssertEqual(description, "Employee state is required")
        }
    }
    
    // Test that setting a empty value as zipcode in HourlyEmployee throws a missingZipCode error.
    func testInitMethod_settingEmptyValueAsZipCodeInHourlyEmployee_ThrowsMissingZipCodeError() {
        
        XCTAssertThrowsError(try HourlyEmployee(firstName: "Employee1", lastName: "Smith", streetAddress: "Gregorio Suarez", city: "Montevideo", state: "Montevideo", zipCode: "", socialSecurityNumber: "1234", dateOfBirth: (date)!, type: EmployeeType.manager)
        ) { error in
            guard case EntrantDataError.missingZipCode(let description) = error else {
                return XCTFail()
            }
            
            XCTAssertEqual(description, "Employee zipcode is required")
        }
    }
    
    // Test that setting a empty value of birthday date in Guest of type free child throws a missingBirthday error.
    func testInitMethod_settingEmptyValueAsBirthdayDateInHourlyEmployee_ThrowsMissingBirthdayDateError() {
        
        XCTAssertThrowsError(try Guest(firstName: "Guest", lastName: "Roberts", streetAddress: "Gregorio Suarez", city: "Montevideo", state: "Montevideo", zipCode: "", socialSecurityNumber: "1234", dateOfBirth: nil, type: GuestType.freeChild)
        ) { error in
            guard case EntrantDataError.missingBirthday(let description) = error else {
                return XCTFail()
            }
            
            XCTAssertEqual(description, "Date of birthday required")
        }
    }
    
    // Test that create a guest of type freeChild of more than 5 years old throws a overFiveYearsOldError error.
    func testInitMethod_createFreeChildOfMoreThanFiveYearsOld_ThrowsOverFiveYearsOldErrorError() {
        
        XCTAssertThrowsError(try Guest(firstName: "Fake Free Child Guest", lastName: "Smith", streetAddress: "Gregorio Suarez", city: "Montevideo", state: "Montevideo", zipCode: "", socialSecurityNumber: "1234", dateOfBirth: date, type: GuestType.freeChild)
        ) { error in
            guard case EntrantDataError.overFiveYearsOldError(let description) = error else {
                return XCTFail()
            }
            
            XCTAssertEqual(description, "Free child must be under 5 years old")
        }
    }
    

    
    func testGenerateAccessByEntrantType(){
     
        if let employeeType = PlugValues.entrantTest.employeeType {
            do{
            let hourlyEmployee = try HourlyEmployee(firstName: PlugValues.entrantTest.firstName, lastName: PlugValues.entrantTest.lastName, streetAddress: PlugValues.entrantTest.streetAddress, city: PlugValues.entrantTest.city, state: PlugValues.entrantTest.state, zipCode: PlugValues.entrantTest.zipCode, socialSecurityNumber: PlugValues.entrantTest.socialSecurityNumber, dateOfBirth: PlugValues.entrantTest.dateOfBirth, type: employeeType)
            let access = hourlyEmployee.generateAccessByEntrantType()
                switch employeeType {
                case .foodServices: XCTAssert(access.areaAccess?[0] == AreaAccess.amusementAreas)
                                    XCTAssert(access.areaAccess?[1] == AreaAccess.kitchenAreas)
                                    XCTAssert(access.rideAccess?[0] == RideAccess.allRides)
                                    XCTAssert((access.discountAccess?[0])! == DiscountAccess.onFood(percentage: 15))
                                    XCTAssert((access.discountAccess?[1])! == DiscountAccess.onMarchandise(percentage: 25))
                
                case .maintenance:  XCTAssert(access.areaAccess?[0] == AreaAccess.amusementAreas)
                                    XCTAssert(access.areaAccess?[1] == AreaAccess.kitchenAreas)
                                    XCTAssert(access.areaAccess?[2] == AreaAccess.rideControlAreas)
                                    XCTAssert(access.areaAccess?[3] == AreaAccess.maintenanceAreas)
                                    XCTAssert(access.rideAccess?[0] == RideAccess.allRides)
                                    XCTAssert((access.discountAccess?[0])! == DiscountAccess.onFood(percentage: 15))
                                    XCTAssert((access.discountAccess?[1])! == DiscountAccess.onMarchandise(percentage: 25))

                case .manager:      XCTAssert(access.areaAccess?[0] == AreaAccess.amusementAreas)
                                    XCTAssert(access.areaAccess?[1] == AreaAccess.kitchenAreas)
                                    XCTAssert(access.areaAccess?[2] == AreaAccess.rideControlAreas)
                                    XCTAssert(access.areaAccess?[3] == AreaAccess.maintenanceAreas)
                                    XCTAssert(access.areaAccess?[4] == AreaAccess.officeAreas)
                                    XCTAssert(access.rideAccess?[0] == RideAccess.allRides)
                                    XCTAssert((access.discountAccess?[0])! == DiscountAccess.onFood(percentage: 25))
                                    XCTAssert((access.discountAccess?[1])! == DiscountAccess.onMarchandise(percentage: 25))
                    

                case .rideServices: XCTAssert(access.areaAccess?[0] == AreaAccess.amusementAreas)
                                    XCTAssert(access.areaAccess?[1] == AreaAccess.rideControlAreas)
                                    XCTAssert(access.rideAccess?[0] == RideAccess.allRides)
                                    XCTAssert((access.discountAccess?[0])! == DiscountAccess.onFood(percentage: 15))
                                    XCTAssert((access.discountAccess?[1])! == DiscountAccess.onMarchandise(percentage: 25))
                }
            
            
            } catch let error {
                XCTFail("Caught error: \(error)")
        }
            
        }
        
        if let guestType = PlugValues.entrantTest.guestType {
            do{
                let guest = try Guest(firstName: PlugValues.entrantTest.firstName, lastName: PlugValues.entrantTest.lastName, streetAddress: PlugValues.entrantTest.streetAddress, city: PlugValues.entrantTest.city, state: PlugValues.entrantTest.state, zipCode: PlugValues.entrantTest.zipCode, socialSecurityNumber: PlugValues.entrantTest.socialSecurityNumber!, dateOfBirth: PlugValues.entrantTest.dateOfBirth, type: guestType)
                let access = guest.generateAccessByEntrantType()
                switch guestType {
                    
                case .classic:      XCTAssert(access.areaAccess?[0] == AreaAccess.amusementAreas)
                                    XCTAssert(access.rideAccess?[0] == RideAccess.allRides)
                    
                case .vip:          XCTAssert(access.areaAccess?[0] == AreaAccess.amusementAreas)
                                    XCTAssert(access.rideAccess?[0] == RideAccess.allRides)
                                    XCTAssert(access.rideAccess?[1] == RideAccess.skipAllRideLines)
                                    XCTAssert((access.discountAccess?[0])! == DiscountAccess.onFood(percentage: 10))
                                    XCTAssert((access.discountAccess?[1])! == DiscountAccess.onMarchandise(percentage: 20))
                    
                case .freeChild:    XCTAssert(access.areaAccess?[0] == AreaAccess.amusementAreas)
                                    XCTAssert(access.rideAccess?[0] == RideAccess.allRides)
                
            }
                
                
            } catch let error {
                XCTFail("Caught error: \(error)")
            }
            
            
        }

    }
    
    func testSwipeMethod(){
        
        if let employeeType = PlugValues.entrantTest.employeeType {
            do{
                let hourlyEmployee = try HourlyEmployee(firstName: PlugValues.entrantTest.firstName, lastName: PlugValues.entrantTest.lastName, streetAddress: PlugValues.entrantTest.streetAddress, city: PlugValues.entrantTest.city, state: PlugValues.entrantTest.state, zipCode: PlugValues.entrantTest.zipCode, socialSecurityNumber: PlugValues.entrantTest.socialSecurityNumber, dateOfBirth: PlugValues.entrantTest.dateOfBirth, type: employeeType)
                
                let access = Access(areaAccess: PlugValues.entrantTest.areaAccess, rideAccess: PlugValues.entrantTest.rideAccess, discountAccess: PlugValues.entrantTest.discountAccess)
                hourlyEmployee.access = access
                hourlyEmployee.swipe()
                let permission = hourlyEmployee.permission
                
                switch permission {
                case .granted(let description, let message): XCTAssert(description == "Access Granted !")
                                                            if let message = message {
                                                                print("\(description) \(message)")}

                case .denied(let description, let message):  XCTAssert(description == "Access Denied")
                                                            if let message = message {
                                                                print("\(description) \(message)")}
                }
                
                
            } catch let error {
                XCTFail("Caught error: \(error)")
            }
            
            
        }
        
        if let guestType = PlugValues.entrantTest.guestType {
            do{
                let guest = try Guest(firstName: PlugValues.entrantTest.firstName, lastName: PlugValues.entrantTest.lastName, streetAddress: PlugValues.entrantTest.streetAddress, city: PlugValues.entrantTest.city, state: PlugValues.entrantTest.state, zipCode: PlugValues.entrantTest.zipCode, socialSecurityNumber: PlugValues.entrantTest.socialSecurityNumber!, dateOfBirth: PlugValues.entrantTest.dateOfBirth, type: guestType)
                
                let access = Access(areaAccess: PlugValues.entrantTest.areaAccess, rideAccess: PlugValues.entrantTest.rideAccess, discountAccess: PlugValues.entrantTest.discountAccess)
                guest.access = access
              //  guest.initialSwipe()
                guest.swipe()
                let permission = guest.permission
                
                switch permission {
                case .granted(let description, let message): XCTAssert(description == "Access Granted !")
                                                             if let message = message {
                                                                print("\(description) \(message)")}
                case .denied(let description, let message):  XCTAssert(description == "Access Denied")
                                                             if let message = message {
                                                                print("\(description) \(message)")}
                }
                
            } catch let error {
                XCTFail("Caught error: \(error)")
            }
            
            
        }

    }



}
