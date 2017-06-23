//
//  UIComponents.swift
//  AmusementParkPassGenerator (II)
//
//  Created by Leticia Rodriguez on 6/22/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit

class UIComponents: NSObject {
    
     let violetColor = UIColor(red:0.25, green:0.21, blue:0.28, alpha:1.0)
     let guestButtonTitles = ["Child", "Classic", "Senior", "VIP", "Seasson Pass"]
     let employeeButtonTitles = ["Food Services", "Ride Services", "Maintenance"]
     let managerButtonTitles = ["Senior", "General", "Assistant"]
     let contractorButtonTitles = ["Contractor"]
     let vendorButtonTitles = ["Vendor"]
     var buttonsArray: [UIButton] = Array()
    
     var guestButtonsArray: [UIButton] = Array()
     var employeeButtonsArray: [UIButton] = Array()
     var managerButtonsArray: [UIButton] = Array()
     var contractorButtonsArray: [UIButton] = Array()
     var vendorButtonsArray: [UIButton] = Array()
    
    //
    func createInterfaceButtons() {
        for buttonTitle in self.guestButtonTitles {
            let button = createButton(for: buttonTitle)
            guestButtonsArray.append(button)
            buttonsArray.append(button)
        }
        for buttonTitle in self.employeeButtonTitles {
            let button = createButton(for: buttonTitle)
            employeeButtonsArray.append(button)
            buttonsArray.append(button)
        }
        for buttonTitle in managerButtonTitles {
            let button = createButton(for: buttonTitle)
            managerButtonsArray.append(button)
            buttonsArray.append(button)
        }
        for buttonTitle in contractorButtonTitles {
            let button = createButton(for: buttonTitle)
            contractorButtonsArray.append(button)
            buttonsArray.append(button)
        }
        for buttonTitle in vendorButtonTitles {
            let button = createButton(for: buttonTitle)
            vendorButtonsArray.append(button)
            buttonsArray.append(button)
        }
    }

    //
    func createButton(for title: String) -> UIButton {
        
        let button = UIButton()
        button.backgroundColor = violetColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    

}
    
