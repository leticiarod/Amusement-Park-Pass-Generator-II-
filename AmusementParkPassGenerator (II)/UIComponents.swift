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
    let lightGreyColor = UIColor(red:0.89, green:0.88, blue:0.90, alpha:1.0)
    let greenColor = UIColor(red:0.35, green:0.58, blue:0.56, alpha:1.0)
    let grey = UIColor(red:0.68, green:0.67, blue:0.68, alpha:1.0)
    
    let guestButtonTitles = ["Child", "Classic", "Senior", "VIP", "Seasson Pass"]
    let employeeButtonTitles = ["Food Services", "Ride Services", "Maintenance"]
    let managerButtonTitles = ["Senior", "General"]
    let contractorButtonTitles = ["Contractor"]
    let vendorButtonTitles = ["Vendor"]
    
    let areaAccessButtonTitles = ["Amusement", "Ride", "Kitchen", "Maintenance", "Office"]
    let rideAccessButtonTitles = ["Access all rides", "Skip all ride lines"]
    let discountAccessButtonTitles = ["Discount on food", "Discount on merchandise"]
    let discountPercentageOnFoodButtonTitles = ["10% discount on Food", "15% discount on Food", "25% discount on Food"]
    let discountPercentageOnMerchandiseButtonTitles = ["20% discount on Merch","25% discount on Merch","10% discount on Merch"]
    
    
    var buttonsArray: [UIButton] = Array()
    
    var guestButtonsArray: [UIButton] = Array()
    var employeeButtonsArray: [UIButton] = Array()
    var managerButtonsArray: [UIButton] = Array()
    var contractorButtonsArray: [UIButton] = Array()
    var vendorButtonsArray: [UIButton] = Array()
    
    var areaAccessButtonsArray: [UIButton] = Array()
    var rideAccessButtonsArray: [UIButton] = Array()
    var discountAccessButtonsArray: [UIButton] = Array()
    var discountPercentageOnFoodButtonsArray: [UIButton] = Array()
    var discountPercentageOnMerchandiseButtonsArray: [UIButton] = Array()
    
    var buttonsForTestingArray: [UIButton] = Array()
    var totalPrivilegesArray: [UILabel] = Array()
    
    //
    func createInterfaceButtons() {
        for buttonTitle in self.guestButtonTitles {
            let button = createButtonForStackViewMenu(for: buttonTitle)
            guestButtonsArray.append(button)
            buttonsArray.append(button)
        }
        for buttonTitle in self.employeeButtonTitles {
            let button = createButtonForStackViewMenu(for: buttonTitle)
            employeeButtonsArray.append(button)
            buttonsArray.append(button)
        }
        for buttonTitle in managerButtonTitles {
            let button = createButtonForStackViewMenu(for: buttonTitle)
            managerButtonsArray.append(button)
            buttonsArray.append(button)
        }
        for buttonTitle in contractorButtonTitles {
            let button = createButtonForStackViewMenu(for: buttonTitle)
            contractorButtonsArray.append(button)
            buttonsArray.append(button)
        }
        for buttonTitle in vendorButtonTitles {
            let button = createButtonForStackViewMenu(for: buttonTitle)
            vendorButtonsArray.append(button)
            buttonsArray.append(button)
        }
    }
    
    func createInterfaceForTestAreaButtons() {
        for buttonTitle in self.areaAccessButtonTitles {
            let button = createButtonForTestAreaStackView(for: buttonTitle)
            areaAccessButtonsArray.append(button)
            buttonsForTestingArray.append(button)
        }
        for buttonTitle in self.rideAccessButtonTitles {
            let button = createButtonForTestAreaStackView(for: buttonTitle)
            rideAccessButtonsArray.append(button)
            buttonsForTestingArray.append(button)
        }
        for buttonTitle in self.discountAccessButtonTitles {
            let button = createButtonForTestAreaStackView(for: buttonTitle)
            discountAccessButtonsArray.append(button)
            buttonsForTestingArray.append(button)
        }
        
        for buttonTitle in self.discountPercentageOnFoodButtonTitles {
            let button = createButtonForTestAreaStackView(for: buttonTitle)
            discountPercentageOnFoodButtonsArray.append(button)
            buttonsForTestingArray.append(button)
        }
        
        for buttonTitle in self.discountPercentageOnMerchandiseButtonTitles {
            let button = createButtonForTestAreaStackView(for: buttonTitle)
            discountPercentageOnMerchandiseButtonsArray.append(button)
            buttonsForTestingArray.append(button)
        }
        
    }
    //
    func createButtonForStackViewMenu(for title: String) -> UIButton {
        
        let button = UIButton()
        button.backgroundColor = violetColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }
    
    //
    func createButtonForTestAreaStackView(for title: String) -> UIButton {
        
        let button = UIButton()
        button.backgroundColor = lightGreyColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(greenColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 5
        return button
    }
    
    func createInterfaceForCardPassLabels(areaAccessArray: [String], rideAccessArray: [String], discountAccessArray: [String]) {
        for privilege in areaAccessArray {
            let label = createLabelForPassCardAreaStackView(for: privilege)
            totalPrivilegesArray.append(label)
        }
        for privilege in rideAccessArray {
            let label = createLabelForPassCardAreaStackView(for: privilege)
            totalPrivilegesArray.append(label)
        }
        
        for privilege in discountAccessArray{
            let label = createLabelForPassCardAreaStackView(for: privilege)
            totalPrivilegesArray.append(label)
        }
    }
    
    
    //
    func createLabelForPassCardAreaStackView(for title: String) -> UILabel {
        let label = UILabel()
        let bulletPoint = "\u{2022}"
        label.text = "\(bulletPoint) \(title)"
        label.textColor = grey
        // button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    
    
    
}

