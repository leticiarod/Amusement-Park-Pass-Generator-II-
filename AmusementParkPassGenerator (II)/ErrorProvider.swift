//
//  ErrorProvider.swift
//  AmusementParkPassGenerator (II)
//
//  Created by Leticia Rodriguez on 6/29/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import Foundation

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
