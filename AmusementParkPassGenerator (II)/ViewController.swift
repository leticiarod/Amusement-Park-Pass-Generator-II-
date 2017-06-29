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
                $0.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
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
    var firstName = "", lastName = "", SSN = "", date = "", streetAddress="", city = "", state = "", zipCode = "", vendorCompany = "", projectID = "", dateOfBirth: String = ""
    
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
    
    // Refresh the form data once a new pass is created.
    override func viewWillAppear(_ animated: Bool) {
        cleanTextFields()
        disabledForm()
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
        
        generatePassButton.isEnabled = true
        generatePassButton.setTitleColor(.white, for: .normal)
        
        // Date of Birth
        textField = textFieldCollection[index]
        textField.text = entrantByType.dateOfBirth
        if let d = textField.text{
            date = d
        }
        index += 1
        // SSN
        textField = textFieldCollection[index]
        textField.text = entrantByType.socialSecurityNumber
        if let ssn = textField.text {
            SSN = ssn
        }
        index += 1
        // Project
        textField = textFieldCollection[index]
        textField.text = entrantByType.projectID
        if let p = textField.text {
            projectID = p
        }
        index += 1
        // First Name
        textField = textFieldCollection[index]
        textField.text = entrantByType.firstName
        if let fn = textField.text as String! {
            firstName = fn
        }
        index += 1
        // Last Name
        textField = textFieldCollection[index]
        textField.text = entrantByType.lastName
        if let ln = textField.text {
            lastName = ln
        }
        index += 1
        
        // Company
        textField = textFieldCollection[index]
        textField.text = entrantByType.vendorCompany
        if let c = textField.text {
            vendorCompany = c
        }
        index += 1
        // Street Address
        textField = textFieldCollection[index]
        textField.text = entrantByType.streetAddress
        if let st = textField.text {
            streetAddress = st
        }
        index += 1
        // City
        textField = textFieldCollection[index]
        textField.text = entrantByType.city
        if let c = textField.text {
            city = c
        }
        index += 1
        // State
        textField = textFieldCollection[index]
        textField.text = entrantByType.state
        if let s = textField.text {
            state = s
        }
        index += 1
        // Zip Code
        textField = textFieldCollection[index]
        textField.text = entrantByType.zipCode
        if let zc = textField.text {
            zipCode = zc
        }
        index += 1
        
    }
    
    // textFieldDidChange is triggered when a textfield is edited
    func textFieldDidChange(textField: UITextField) {
        generatePassButton.isEnabled = true
        generatePassButton.setTitleColor(.white, for: .normal)
        switch textField.tag {
        case 1: date = textField.text!
        case 2: SSN = textField.text!
        case 3: projectID = textField.text!
        case 4: firstName = textField.text!
        case 5: lastName = textField.text!
        case 6: vendorCompany = textField.text!
        case 7: streetAddress = textField.text!
        case 8: city = textField.text!
        case 9: state = textField.text!
        case 10: zipCode = textField.text!
        default: break
        }
    }
    
    // ButtonClicked is the targeted method, it is called when a button of the stack view menu is tapped.
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
        case 10: // Contractor option was tapped
            print("contractor")
            cleanTextFields()
            enableForm()
            subEntrantTypeSelected = "Contractor"
        case 11: // Vendor option was tapped
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
            createEntrantObjectByType()
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
    
    //  Given an array of buttons, this buttons are added to the stack view menu.
    func addSubViewToStackView(_ array: [UIButton]){
        for button in array {
            submenuStackView.addArrangedSubview(button)
        }
    }
    
    // Show the buttons added to the stack view menu.
    func enableViewsInStackView(_ array: [UIButton]){
        for button in array {
            button.isHidden = false
            button.isEnabled = true
        }
    }
    
    // Hide the buttons added to the stack view menu.
    func disableViewsInStackView(_ array: [UIButton]){
        for button in array {
            button.isHidden = true
            button.isEnabled = false
        }
    }
    
    // Initialize the stack view menu by adding all the buttons corresponding to each type of Entrant.
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
    
    // Add target to the buttons created programmatically for the stack view menu.
    func addTarget() {
        // indexTag is used to identify each button created programmatically
        var indexTag = 0
        for button in uiComponents.buttonsArray{
            button.tag = indexTag
            indexTag += 1
            button.addTarget(self, action: #selector(buttonClicked(sender:)), for:.touchUpInside)
        }
    }
    
    // Disable Form, it "paints" all textfields, views, buttons and labels in grey color.
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
    
    // Paints "buttons" in grey color
    func disableButtons(){
        generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
        populateDataButton.setTitleColor(textColorDisabledLabel, for: .normal)
    }
    
    // Enable Form (get rid of the grey parts) for all type of Entrant (Except Vendor)
    func enableForm(){
        for textField in textFieldCollection{
            if textField.tag != 2 && textField.tag != 3 && textField.tag != 6 {
                textField.backgroundColor = .white
                textField.layer.borderColor = borderColorEnabledTextField.cgColor
            }
        }
        
        for label in labelCollection{
            if subEntrantTypeSelected == "Contractor" {
                if label.text != "Company" {
                    label.textColor = textColorEnabledLabel
                }
            }
            else {
                if label.text != "Project #" && label.text != "Company" {
                    label.textColor = textColorEnabledLabel
                }
            }
        }
        
        for uiview in uiViewCollection {
            uiview.isUserInteractionEnabled = true
        }
        
        for textField in textFieldCollection{
            if textField.tag == 2 || textField.tag == 3 || textField.tag == 6 {
                textField.isEnabled = false
            }
        }
        
        generatePassButton.setTitleColor(.white, for: .normal)
        populateDataButton.setTitleColor(titleColorEnabledButton, for: .normal)
    }
    
    // Enable Form (get rid of the grey parts) for a type of Entrant = Vendor
    func enableVendorForm(){
        for textField in textFieldCollection{
            if textField.tag != 2 && textField.tag != 3 {
                textField.backgroundColor = .white
                textField.layer.borderColor = borderColorEnabledTextField.cgColor
            }
        }
        
        for label in labelCollection{
            if /*label.text != "SSN" &&*/ label.text != "Project #" {
                label.textColor = textColorEnabledLabel
            }
        }
        
        for uiview in uiViewCollection {
            uiview.isUserInteractionEnabled = true
        }
        generatePassButton.setTitleColor(.white, for: .normal)
        populateDataButton.setTitleColor(titleColorEnabledButton, for: .normal)
    }
    
    // Set empty string to the textfields in the form
    func cleanTextFields(){
        textFieldCollection.forEach{
            $0.text = ""
        }
        date = "00.00.0000"
        SSN = ""
        projectID = ""
        firstName = ""
        lastName = ""
        vendorCompany = ""
        streetAddress = ""
        city = ""
        state = ""
        zipCode = ""
    }
    
    // Create object an Entrant Object given the the subtype of entrant (Child, contractor, food services Employee) selected in the submenu
    func createEntrantObjectByType() {
        generatePassButton.isEnabled = true
        generatePassButton.setTitleColor(.white, for: .normal)
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
            case "Food":
                
                try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .foodServices)
                access = hourlyEmployee.generateAccessByEntrantType()
            case "Ride": try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .rideServices)
            access = hourlyEmployee.generateAccessByEntrantType()
            case "Maintenance": try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .maintenance)
            access = hourlyEmployee.generateAccessByEntrantType()
            case "SeniorManager": try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .manager)
            access = hourlyEmployee.generateAccessByEntrantType()
            case "General": print("case general")
            print("first name \(firstName)")
            try hourlyEmployee = HourlyEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .manager)
                access = hourlyEmployee.generateAccessByEntrantType()
            case "Assistant": break
                
            case "Contractor": try contractEmployee = ContractEmployee(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, type: .nonType, projectID: projectID)
            access = contractEmployee.generateAccessByEntrantType()
            case "Vendor":
                try vendor = Vendor(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, socialSecurityNumber: SSN, dateOfBirth: date, dateOfVisit: "28-06-2017", vendorCompany: vendorCompany)
                access = vendor.generateAccessByEntrantType()
            default: break
            }
        } catch EntrantDataError.missingName(description: "Name is required") {
            //disable generatePassButton until populate data button be pressed again
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Name is required! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.missingLastName(description: "Lastname is required"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Lastname is required! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.missingBirthday(description: "Date of birthday is required") {
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Date of birthday required! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.missingDateOfVisit(description: "Vendor date of visit is missing"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Vendor date of visit is missing! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.missingVendorCompany(description: "Vendor company is missing"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Vendor company is missing! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.missingCity(description: "City is required") {
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "City is required! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.missingStreetAddress(description: "Street Address is required"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Street Address is required! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.missingState(description: "State is required"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "State is required! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.missingZipCode(description: "Zipcode is required"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Zipcode is required! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.overFiveYearsOldError(description: "Free child must be under 5 years old"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Free child must be under 5 years old! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.itemShouldBeNUmerical(description: "Zipcode must be a number"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Zipcode must be a number! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.dateFormatError(description: "Invalid date format"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Invalid date format! You will not able to generate a new pass until you fix the problem.")
        } catch EntrantDataError.incorrectLengthOfString(description: "Incorrect length of input"){
            generatePassButton.isEnabled = false
            generatePassButton.setTitleColor(textColorDisabledLabel, for: .normal)
            createAlert(with: "Inconrect length of input! You will not able to generate a new pass until you fix the problem.")
        } catch   {
            print("error \(error)")
            fatalError()
        }
        
    }
    
    // Create an UIAlertController
    func createAlert(with message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

