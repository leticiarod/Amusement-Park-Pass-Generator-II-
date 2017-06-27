//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Leticia Rodriguez on 5/21/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit


class ViewController: UIViewController  {
    
    // Colors
    
    let textColorDisabledLabel = UIColor(red:0.64, green:0.62, blue:0.65, alpha:1.0)
    let textColorEnabledLabel = UIColor(red:0.25, green:0.21, blue:0.28, alpha:1.0)
    let borderColorDisabledView = UIColor(red:196/255.0, green:192/255.0, blue:199/255.0, alpha: 1.0)
    let borderColorDisabledTextField = UIColor(red:0.64, green:0.62, blue:0.65, alpha:1.0)
    let backgroundColorDisabledTextField = UIColor(red:0.86, green:0.84, blue:0.87, alpha:1.0)
    let borderColorEnabledTextField = UIColor(red:63/255.0, green:54/255.0, blue:71/255.0, alpha: 1.0)
    let titleColorEnabledButton = UIColor(red:0.35, green:0.58, blue:0.56, alpha:1.0)
    
    @IBOutlet weak var submenuStackView: UIStackView!
    
    @IBOutlet var uiViewCollection: [UIView]!{
         didSet {
            
            uiViewCollection.forEach{
                $0.layer.borderWidth = 1
                $0.layer.borderColor = borderColorDisabledView.cgColor
                $0.isUserInteractionEnabled = false           }
         }
    }
    
    
    @IBOutlet var textFieldCollection: [UITextField]!{
        didSet {
           
            textFieldCollection.forEach{
                $0.layer.borderWidth = 1
                $0.layer.borderColor = borderColorDisabledTextField.cgColor
                $0.layer.cornerRadius = 5
                $0.backgroundColor = backgroundColorDisabledTextField
            }

        }
    }
    
    
    @IBOutlet var labelCollection: [UILabel]!{
        didSet{
            
            labelCollection.forEach {
                $0.textColor = textColorDisabledLabel
            }
        }
    }
    
    
    @IBOutlet weak var generatePassButton: UIButton!
    @IBOutlet weak var populateDataButton: UIButton!
    
    var uiComponents = UIComponents()
    var subEntrantTypeSelected = ""
    
    var guest = Guest()
    var hourlyEmployee = HourlyEmployee()
    var contractEmployee = ContractEmployee()
    var vendor = Vendor()
    var access = Access()
    var firstName = "", lastName = "", SSN = "", date = Date(), streetAddress="", city = "", state = "", zipCode = "", vendorCompany = "", projectID = "", dateOfBirth: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiComponents.createInterfaceButtons()
        initViews()
        disableButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func guestButtonPressed(_ sender: Any) {
        
        enableViewsInStackView(uiComponents.guestButtonsArray)
        disableViewsInStackView(uiComponents.employeeButtonsArray)
        disableViewsInStackView(uiComponents.managerButtonsArray)
        disableViewsInStackView(uiComponents.vendorButtonsArray)
        disableViewsInStackView(uiComponents.contractorButtonsArray)
        disabledForm()
    }
    
    @IBAction func employeeButtonPressed(_ sender: Any) {
        
        enableViewsInStackView(uiComponents.employeeButtonsArray)
        disableViewsInStackView(uiComponents.guestButtonsArray)
        disableViewsInStackView(uiComponents.managerButtonsArray)
        disableViewsInStackView(uiComponents.vendorButtonsArray)
        disableViewsInStackView(uiComponents.contractorButtonsArray)
        disabledForm()
    }
    
    @IBAction func managerButtonPressed(_ sender: Any) {
        
        enableViewsInStackView(uiComponents.managerButtonsArray)
        disableViewsInStackView(uiComponents.employeeButtonsArray)
        disableViewsInStackView(uiComponents.guestButtonsArray)
        disableViewsInStackView(uiComponents.vendorButtonsArray)
        disableViewsInStackView(uiComponents.contractorButtonsArray)
        disabledForm()
    }
    
    
    @IBAction func contractorButtonPressed(_ sender: Any) {
        
        enableViewsInStackView(uiComponents.contractorButtonsArray)
        disableViewsInStackView(uiComponents.managerButtonsArray)
        disableViewsInStackView(uiComponents.employeeButtonsArray)
        disableViewsInStackView(uiComponents.guestButtonsArray)
        disableViewsInStackView(uiComponents.vendorButtonsArray)
        disabledForm()
    }
    
    @IBAction func vendorButtonPressed(_ sender: Any) {
        
        enableViewsInStackView(uiComponents.vendorButtonsArray)
        disableViewsInStackView(uiComponents.contractorButtonsArray)
        disableViewsInStackView(uiComponents.managerButtonsArray)
        disableViewsInStackView(uiComponents.employeeButtonsArray)
        disableViewsInStackView(uiComponents.guestButtonsArray)
        disabledForm()
    }
    
    
    @IBAction func populateDataButtonPressed(_ sender: Any) {
        
        let entrants = Entrants()
        let entrantByType = entrants.getEntrantByType(subEntrantTypeSelected)
        var index = 0
        var textField = UITextField()
        
        // Convert date to string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy" //Your New Date format as per requirement change it own
        if let d = entrantByType.dateOfBirth {
         dateOfBirth = dateFormatter.string(from: d) //pass Date here
        }
        
        // Date of Birth
        textField = textFieldCollection[index]
        textField.text = dateOfBirth
        if let d = entrantByType.dateOfBirth{
            date = d
        }
        index += 1
        // SSN
        textField = textFieldCollection[index]
        textField.text = entrantByType.socialSecurityNumber
        if let ssn = entrantByType.socialSecurityNumber {
            SSN = ssn
        }
        index += 1
        // Project
         textField = textFieldCollection[index]
        textField.text = entrantByType.projectID
        if let p = entrantByType.projectID {
            projectID = p
        }
        index += 1
        // First Name
        textField = textFieldCollection[index]
        textField.text = entrantByType.firstName
        if let fn = entrantByType.firstName as String! {
            firstName = fn
        }
        index += 1
        // Last Name
        textField = textFieldCollection[index]
        textField.text = entrantByType.lastName
        if let ln = entrantByType.lastName {
            lastName = ln
        }
        index += 1
        // Company
         textField = textFieldCollection[index]
        textField.text = entrantByType.vendorCompany
        if let c = entrantByType.vendorCompany {
            vendorCompany = c
        }
        index += 1
        // Street Address
        textField = textFieldCollection[index]
        textField.text = entrantByType.streetAddress
        if let st = entrantByType.streetAddress {
            streetAddress = st
        }
        index += 1
        // City
        textField = textFieldCollection[index]
        textField.text = entrantByType.city
        if let c = entrantByType.city {
            city = c
        }
        index += 1
        // State
        textField = textFieldCollection[index]
        textField.text = entrantByType.state
        if let s = entrantByType.state {
            state = s
        }
        index += 1
        // Zip Code
        textField = textFieldCollection[index]
        textField.text = entrantByType.zipCode
        if let zc = entrantByType.zipCode {
            zipCode = zc
        }
        index += 1
        
        createEntrantObjectByType()
        
    }
    
    //
    func buttonClicked(sender: UIButton)
    {
        switch sender.tag {
        case 0: // Child option was tapped
                print("Child")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "Child"
        case 1: // Classic option was tapped
                print("classic")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "Classic"
        case 2: // Senior option was tapped
                print("Senior")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "SeniorGuest"
        case 3: // VIP option was tapped
                print("VIP")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "VIP"
        case 4: // Seasson Pass option was tapped
                print("seasson pass")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "SeassonPass"
        case 5: // Food Employee option was tapped
                print("food")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "Food"
        case 6: // Ride Employee option was tapped
                print("ride")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "Ride"
        case 7: // Maintenance Employee option was tapped
                print("maintenance")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "Maintenance"
        case 8: // Senior Manager option was tapped
                print("senior ")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "SeniorManager"
        case 9: // General Manager option was tapped
                print("general")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "General"
        case 10: // Assistant option was tapped
                print("asssistant")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "Assistant"
        case 11: // Contractor option was tapped
                print("contractor")
                cleanTextFields()
                enableForm()
                subEntrantTypeSelected = "Contractor"
        case 12: // Vendor option was tapped
                print("vendor")
                cleanTextFields()
                enableVendorForm()
                subEntrantTypeSelected = "Vendor"
        default:
            break
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CreatePass" {
            guard let createPassController = segue.destination as? CreatePassController else {
                return
            }
            switch subEntrantTypeSelected {
            case "Child", "Classic", "SeniorGuest", "VIP", "SeassonPass":
                createPassController.guest = self.guest
            case "Food", "Ride", "Maintenance", "SeniorManager", "General": createPassController.hourlyEmployee = self.hourlyEmployee
            case "Contractor": createPassController.contractEmployee = self.contractEmployee
            case "Vendor": createPassController.vendor = self.vendor
            default:
                break
            }
           createPassController.typeOfEntrant = subEntrantTypeSelected
        }
    }

    // MARK: Helper Methods
    
    //
    func addSubViewToStackView(_ array: [UIButton]){
        for button in array {
            submenuStackView.addArrangedSubview(button)
        }
    }
    
    //
    func enableViewsInStackView(_ array: [UIButton]){
        for button in array {
            button.isHidden = false
            button.isEnabled = true
        }
    }
    
    //
    func disableViewsInStackView(_ array: [UIButton]){
        for button in array {
            button.isHidden = true
            button.isEnabled = false
        }
    }
    
    //
    func initViews(){
        addSubViewToStackView(uiComponents.guestButtonsArray)
        addSubViewToStackView(uiComponents.employeeButtonsArray)
        addSubViewToStackView(uiComponents.managerButtonsArray)
        addSubViewToStackView(uiComponents.contractorButtonsArray)
        addSubViewToStackView(uiComponents.vendorButtonsArray)
        disableViewsInStackView(uiComponents.guestButtonsArray)
        disableViewsInStackView(uiComponents.employeeButtonsArray)
        disableViewsInStackView(uiComponents.managerButtonsArray)
        disableViewsInStackView(uiComponents.contractorButtonsArray)
        disableViewsInStackView(uiComponents.vendorButtonsArray)
        addTarget()
    }
    
    func addTarget() {
        var indexTag = 0
        for button in uiComponents.buttonsArray{
            button.tag = indexTag
            indexTag += 1
            button.addTarget(self, action: #selector(buttonClicked(sender:)), for:.touchUpInside)
        }
    }
    
    func disabledForm(){
    
        uiViewCollection.forEach{
            $0.isUserInteractionEnabled = false
        }

        textFieldCollection.forEach{
            $0.layer.borderColor = borderColorDisabledTextField.cgColor
            $0.backgroundColor = backgroundColorDisabledTextField
            $0.text = ""
        }
        
        labelCollection.forEach {
            $0.textColor = textColorDisabledLabel
        }
        
        disableButtons()
        submenuStackView.isUserInteractionEnabled = true

    }
    
    func disableButtons(){
        generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
        populateDataButton.setTitleColor(textColorDisabledLabel, for: .normal)
    }
    
    func enableForm(){
        for textField in textFieldCollection{
            if textField.tag != 2 && textField.tag != 3 && textField.tag != 6 {
                textField.backgroundColor = .white
                textField.layer.borderColor = borderColorEnabledTextField.cgColor
            }
        }
        
        for label in labelCollection{
            if label.text != "SSN" && label.text != "Project #" && label.text != "Company" {
                label.textColor = textColorEnabledLabel
            }
        }
        
        for uiview in uiViewCollection {
            uiview.isUserInteractionEnabled = true
        }
        generatePassButton.setTitleColor(.white, for: .normal)
        populateDataButton.setTitleColor(titleColorEnabledButton, for: .normal)
        
       // submenuStackView.isUserInteractionEnabled = false
    }

    func enableVendorForm(){
        for textField in textFieldCollection{
            if textField.tag != 2 && textField.tag != 3 {
                textField.backgroundColor = .white
                textField.layer.borderColor = borderColorEnabledTextField.cgColor
            }
        }
        
        for label in labelCollection{
            if label.text != "SSN" && label.text != "Project #" {
                label.textColor = textColorEnabledLabel
            }
        }
        
        for uiview in uiViewCollection {
            uiview.isUserInteractionEnabled = true
        }
        generatePassButton.setTitleColor(.white, for: .normal)
        populateDataButton.setTitleColor(titleColorEnabledButton, for: .normal)
        
      //  submenuStackView.isUserInteractionEnabled = false
    }
    
    func cleanTextFields(){
        textFieldCollection.forEach{
           $0.text = ""
        }
    }
    
    //
    func createEntrantObjectByType() {
        do {
            
            switch subEntrantTypeSelected {
            case "Child": try guest = Guest(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .freeChild)
            access = guest.generateAccessByEntrantType()
                
            case "Classic": try guest = Guest(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .classic)
            access = guest.generateAccessByEntrantType()
                
            case "SeniorGuest": try guest = Guest(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .senior)
            access = guest.generateAccessByEntrantType()
            case "VIP": try guest = Guest(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .vip)
            access = guest.generateAccessByEntrantType()
            case "SeassonPass": try guest = Guest(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .seassonPass)
            access = guest.generateAccessByEntrantType()
            case "Food": try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .foodServices)
            access = hourlyEmployee.generateAccessByEntrantType()
            case "Ride": try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .rideServices)
            access = hourlyEmployee.generateAccessByEntrantType()
            case "Maintenance": try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .maintenance)
            access = hourlyEmployee.generateAccessByEntrantType()
            case "SeniorManager": try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .manager)
            access = hourlyEmployee.generateAccessByEntrantType()
            case "General": print("case general")
            try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .manager)
            case "Assistant": break
                
            case "Contractor": try contractEmployee = ContractEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .nonType, projectID: projectID)
            access = contractEmployee.generateAccessByEntrantType()
            case "Vendor":
                try vendor = Vendor(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, dateOfVisit: Date(), vendorCompany: vendorCompany)
                access = vendor.generateAccessByEntrantType()
            default: break
            }
        } catch EntrantDataError.missingName(description: "Missing Name") {
            print("missing name")
        } catch EntrantDataError.missingLastName(description: "Missing Lastname"){
            print("missing lastname")
        } catch EntrantDataError.missingBirthday(description: "Missing birthday") {
            print("missing birthday")
        } catch EntrantDataError.missingDateOfVisit(description: "Missing day of visit"){
            print("missing date of visit")
        } catch EntrantDataError.missingVendorCompany(description: "Missing vendor company"){
            print("missing vendor company")
        } catch EntrantDataError.missingCity(description: "Missing city") {
            print("missing city")
        } catch {
            print("otros errores")
        }
        
    }
}

