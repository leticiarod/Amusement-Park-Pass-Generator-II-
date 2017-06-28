//
//  PlugValues.swift
//  AmusementParkPassGenerator (II)
//
//  Created by Leticia Rodriguez on 6/24/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import Foundation

struct Entrant {
    let firstName: String?
    let lastName: String?
    let streetAddress: String?
    let city: String?
    let state: String?
    let zipCode: String?
    let socialSecurityNumber: String?
    let dateOfBirth: Date?
    let dateOfVisit: Date?
    let vendorCompany: String?
    let projectID: String?

}

struct Entrants {
    
    static let entrantsDictionary = ["Child" : Entrant(firstName: "Lucas", lastName: "Smith", streetAddress: "Gregorio Suárez", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber : nil, dateOfBirth: Date(), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "Classic" : Entrant(firstName: "Robert", lastName: "Williams", streetAddress: "21 de Setiembre", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -1103760000.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "SeniorGuest" : Entrant(firstName: "Jhon", lastName: "Smith", streetAddress: "Franzini", city: "Montevideo", state: "Montevideo", zipCode: "11900", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -2207520000.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "VIP" : Entrant(firstName: "Alexandra", lastName: "Kravitz", streetAddress: "Williman", city: "Montevideo", state: "Montevideo", zipCode: "11300", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -1103760000.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "SeassonPass" : Entrant(firstName: "Julia", lastName: "Roberts", streetAddress: "Luis de la Torre", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -1103760000.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "Food" : Entrant(firstName: "Ignacio", lastName: "Stewart", streetAddress: "Tierno Galvan", city: "Montevideo", state: "Montevideo", zipCode: "11300", socialSecurityNumber : nil, dateOfBirth: Date(timeIntervalSinceReferenceDate:-123456789.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "Ride" : Entrant(firstName: "Alex", lastName: "Jones", streetAddress: "Ellauri", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -1103760000.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "Maintenance" : Entrant(firstName: "Gerard", lastName: "Lozano", streetAddress: "Boulevard Artigas", city: "Montevideo", state: "Montevideo", zipCode: "11700", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -2207520000.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "SeniorManager" : Entrant(firstName: "Carla", lastName: "Ramsteim", streetAddress: "Buenos Aires", city: "Montevideo", state: "Montevideo", zipCode: "11300", socialSecurityNumber : nil, dateOfBirth: Date(timeIntervalSinceReferenceDate:-123456789.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "General" : Entrant(firstName: "", lastName: "Knight", streetAddress: "Rambla", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -1103760000.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "Assistant" : Entrant(firstName: "Daniel", lastName: "Saredo", streetAddress: "Boulevard España", city: "Montevideo", state: "Montevideo", zipCode: "11700", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -2207520000.0), dateOfVisit: nil, vendorCompany: nil, projectID: nil),
        "Contractor" : Entrant(firstName: "Claudia", lastName: "Yates", streetAddress: "26 de Marzo", city: "Montevideo", state: "Montevideo", zipCode: "11800", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -1103760000.0), dateOfVisit: nil, vendorCompany: nil, projectID: "1001"),
        "Vendor" : Entrant(firstName: "Francis", lastName: "Underwood", streetAddress: "Avenida Brasil", city: "Montevideo", state: "Montevideo", zipCode: "11700", socialSecurityNumber: nil, dateOfBirth: Date(timeIntervalSinceReferenceDate: -2207520000.0), dateOfVisit: Date(), vendorCompany: "NW Electrical", projectID: nil)
        ]
    //-123456789.0

    func getEntrantByType(_ type: String) -> Entrant {
        
        var entrantItem: Entrant? = nil
        
        for entrant in Entrants.entrantsDictionary {
            if let e = Entrants.entrantsDictionary[type], entrant.key == type {
                    entrantItem = e
            }
        }
        
        return entrantItem!
    }
}
