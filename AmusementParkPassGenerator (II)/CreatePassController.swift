//
//  CreatePassController.swift
//  AmusementParkPassGenerator (II)
//
//  Created by Leticia Rodriguez on 6/25/17.
//  Copyright © 2017 Leticia Rodriguez. All rights reserved.
//

import UIKit

class CreatePassController: UIViewController {
    
    @IBOutlet weak var testItemsStackView: UIStackView!
    
    var guest = Guest()
    var hourlyEmployee = HourlyEmployee()
    var contractEmployee = ContractEmployee()
    var vendor = Vendor()
    var typeOfEntrant: String = ""
    var uiComponents = UIComponents()
    var passGenerator = Guest()
    var areaAccessStringArray: [String] = Array()
    var discountAccessStringArray: [String] = Array()
    var rideAccessStringArray: [String] = Array()
    var audio = Audio()
    
    @IBOutlet weak var testArea: UILabel!
    
    @IBOutlet var testButtonsStackViewCollection: [UIButton]!
    
    @IBOutlet weak var infoPassStackView: UIStackView!
    
    @IBOutlet weak var nameLabelPass: UILabel!
    
    @IBOutlet weak var typeLabelPass: UILabel!
    
    
    @IBOutlet weak var firstBackButton: UIButton!
    
    
    @IBOutlet weak var secondBackButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiComponents.createInterfaceForTestAreaButtons()
        initViews()
        initPassCardArea()
        firstBackButton.isHidden = true
        secondBackButton.isHidden = true
        firstBackButton.isEnabled  = false
        secondBackButton.isEnabled  = false
        audio.loadGameSounds()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func areaAccessButtonPressed(_ sender: Any) {
        
        enableViewsInStackView(uiComponents.areaAccessButtonsArray)
        disableTestButtonsStackViewCollection()
        disableViewsInStackView(uiComponents.discountAccessButtonsArray)
        disableViewsInStackView(uiComponents.rideAccessButtonsArray)
        firstBackButton.isHidden = false
        firstBackButton.isEnabled  = true
    }
    
    @IBAction func rideAccessButtonPressed(_ sender: Any) {
        enableViewsInStackView(uiComponents.rideAccessButtonsArray)
        disableTestButtonsStackViewCollection()
        disableViewsInStackView(uiComponents.discountAccessButtonsArray)
        disableViewsInStackView(uiComponents.areaAccessButtonsArray)
        firstBackButton.isHidden = false
        firstBackButton.isEnabled  = true
    }
    
    @IBAction func discountAccessButtonPressed(_ sender: Any) {
        enableViewsInStackView(uiComponents.discountAccessButtonsArray)
        disableTestButtonsStackViewCollection()
        disableViewsInStackView(uiComponents.areaAccessButtonsArray)
        disableViewsInStackView(uiComponents.rideAccessButtonsArray)
        firstBackButton.isHidden = false
        firstBackButton.isEnabled  = true
    }
    
    @IBAction func firstBackButtonPressed(_ sender: Any) {
        disableViewsInStackView(uiComponents.areaAccessButtonsArray)
        disableViewsInStackView(uiComponents.rideAccessButtonsArray)
        disableViewsInStackView(uiComponents.discountAccessButtonsArray)
       enableTestButtonsStackViewCollection()
        firstBackButton.isHidden = true
        firstBackButton.isEnabled  = false
    }
    
    @IBAction func secondBackButtonPressed(_ sender: Any) {
        enableViewsInStackView(uiComponents.discountAccessButtonsArray)
        disableViewsInStackView(uiComponents.discountPercentageOnFoodButtonsArray)
        disableViewsInStackView(uiComponents.discountPercentageOnMerchandiseButtonsArray)
        firstBackButton.isHidden = false
        firstBackButton.isEnabled  = true
        secondBackButton.isHidden = true
        secondBackButton.isEnabled  = false
    }
    
    
    @IBAction func createNewPassButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func buttonClicked(sender: UIButton)
    {
        switch sender.tag {
        case 0: // Amusement option was tapped
            let amusementArea: AreaAccess = .amusementAreas
            test(privilege: "Amusement Area", areaAccess: amusementArea, rideAccess: nil, discountAccess: nil)
        case 1: // Ride option was tapped
            let rideArea: AreaAccess = .rideControlAreas
            test(privilege: "Ride Area", areaAccess: rideArea, rideAccess: nil, discountAccess: nil)
        case 2: // Kitchen option was tapped
            let kitchenArea: AreaAccess = .kitchenAreas
            test(privilege: "Kitchen Area", areaAccess: kitchenArea, rideAccess: nil, discountAccess: nil)
        case 3: // Maintenance option was tapped
            let maintenanceArea: AreaAccess = .maintenanceAreas
            test(privilege: "Maintenance Area", areaAccess: maintenanceArea, rideAccess: nil, discountAccess: nil)
        case 4: // Office option was tapped
            let officeArea: AreaAccess = .officeAreas
            test(privilege: "Office Area", areaAccess: officeArea, rideAccess: nil, discountAccess: nil)
        case 5: // Access all rides option was tapped
            let allRideLines: RideAccess = .allRides
            test(privilege: "Unlimited Rides", areaAccess: nil, rideAccess: allRideLines, discountAccess: nil)
        case 6: // Skip all ride lines option was tapped
            let skipAllLines: RideAccess = .skipAllRideLines
            test(privilege: "Skip all ride lines", areaAccess: nil, rideAccess: skipAllLines, discountAccess: nil)
        case 7: // Discount on food option was tapped
            enableViewsInStackView(uiComponents.discountPercentageOnFoodButtonsArray)
            disableViewsInStackView(uiComponents.discountPercentageOnMerchandiseButtonsArray)
            disableViewsInStackView(uiComponents.discountAccessButtonsArray)
            firstBackButton.isHidden = true
            firstBackButton.isEnabled  = false
            secondBackButton.isHidden = false
            secondBackButton.isEnabled  = true
        case 8: // Discount on merchandise option was tapped
            enableViewsInStackView(uiComponents.discountPercentageOnMerchandiseButtonsArray)
            disableViewsInStackView(uiComponents.discountPercentageOnFoodButtonsArray)
            disableViewsInStackView(uiComponents.discountAccessButtonsArray)
            firstBackButton.isHidden = true
            firstBackButton.isEnabled  = false
            secondBackButton.isHidden = false
            secondBackButton.isEnabled  = true
        case 9: // 10% discount on food option was tapped
            let discount: DiscountAccess = .onFood(percentage: 10)
           test(privilege: "10% discount on food", areaAccess: nil, rideAccess: nil, discountAccess: discount)
        case 10: // 15% discount on food option was tapped
            print("aprete el 10 q es el 15 % on food?")
            let discount: DiscountAccess = .onFood(percentage: 15)
            test(privilege: "15% discount on food", areaAccess: nil, rideAccess: nil, discountAccess: discount)
        case 11: // 25% discount on food option was tapped
            let discount: DiscountAccess = .onFood(percentage: 25)
            test(privilege: "25% discount on food", areaAccess: nil, rideAccess: nil, discountAccess: discount)
        case 12: // 20% discount on merchandise option was tapped
            let discount: DiscountAccess = .onMarchandise(percentage: 20)
            test(privilege: "20% discount on merchandise", areaAccess: nil, rideAccess: nil, discountAccess: discount)
        case 13: // 25% discount on merchandise option was tapped
            let discount: DiscountAccess = .onMarchandise(percentage: 25)
            test(privilege: "25% discount on merchandise", areaAccess: nil, rideAccess: nil, discountAccess: discount)
        case 14: // 10% discount on merchandise option was tapped
            let discount: DiscountAccess = .onMarchandise(percentage: 10)
            test(privilege: "10% discount on merchandise", areaAccess: nil, rideAccess: nil, discountAccess: discount)
        default:
            break
        }
        
    }
    
    // MARK: - Helper Methods
    
    func initViews(){
        addSubViewToStackView(uiComponents.areaAccessButtonsArray)
        addSubViewToStackView(uiComponents.rideAccessButtonsArray)
        addSubViewToStackView(uiComponents.discountAccessButtonsArray)
        addSubViewToStackView(uiComponents.discountPercentageOnMerchandiseButtonsArray)
        addSubViewToStackView(uiComponents.discountPercentageOnFoodButtonsArray)
        disableViewsInStackView(uiComponents.areaAccessButtonsArray)
        disableViewsInStackView(uiComponents.rideAccessButtonsArray)
        disableViewsInStackView(uiComponents.discountAccessButtonsArray)
        disableViewsInStackView(uiComponents.discountPercentageOnFoodButtonsArray)
        disableViewsInStackView(uiComponents.discountPercentageOnMerchandiseButtonsArray)
        addTarget()
    }
    
    func addSubViewToStackView(_ array: [UIButton]){
        for button in array {
            testItemsStackView.addArrangedSubview(button)
        }
    }
    
    func addLabelToStackView(_ array: [UILabel]){
        for label in array {
            infoPassStackView.addArrangedSubview(label)
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
    
    func addTarget() {
        var indexTag = 0
        for button in uiComponents.buttonsForTestingArray{
            button.tag = indexTag
            indexTag += 1
            button.addTarget(self, action: #selector(buttonClicked(sender:)), for:.touchUpInside)
        }
    }
    
    func disableTestButtonsStackViewCollection(){
        self.testButtonsStackViewCollection.forEach {
            $0.isHidden = true
            
        }
    }
    
    func enableTestButtonsStackViewCollection(){
        self.testButtonsStackViewCollection.forEach {
            $0.isHidden = false
            
        }
    }
    
    func convertToStringAreaAccessArray(areaAccessArray: [AreaAccess]){
        for item in areaAccessArray {
            switch item {
            case .amusementAreas: areaAccessStringArray.append("Amusement Area Access")
            case .kitchenAreas: areaAccessStringArray.append("Kitchen Area Access")
            case .rideControlAreas: areaAccessStringArray.append("Ride Control Access")
            case .maintenanceAreas: areaAccessStringArray.append("Maintenance Area Access")
            case .officeAreas: areaAccessStringArray.append("Office Area Access")
            }
        }
    }
    
    func convertToStringRideAccessArray(rideAccessArray: [RideAccess]){
        for item in rideAccessArray {
            switch item {
            case .allRides: rideAccessStringArray.append("Unlimited Rides")
            case .skipAllRideLines: rideAccessStringArray.append("Skip All Ride Lines")
            }
        }
    }

    func convertToStringDiscountAccessArray(discountAccessArray: [DiscountAccess]){
        for item in discountAccessArray {
            switch item {
            case .onFood(percentage: 10): discountAccessStringArray.append("10% Food Discount")
            case .onFood(percentage: 15): discountAccessStringArray.append("15% Food Discount")
            case .onFood(percentage: 25): discountAccessStringArray.append("25% Food Discount")
            case .onMarchandise(percentage: 10): discountAccessStringArray.append("10% Merch Discount")
            case .onMarchandise(percentage: 20): discountAccessStringArray.append("20% Merch Discount")
            case .onMarchandise(percentage: 25): discountAccessStringArray.append("25% Merch Discount")
            default: break
            }
        }
    }
    
    func initPassCardArea() {
        switch typeOfEntrant {
        case "Child", "Classic", "SeniorGuest", "VIP", "SeassonPass":
            if let firstName = guest.firstName as String!, let lastName = guest.lastName as String! {
                nameLabelPass.text = "\(firstName) \(lastName)"
                typeLabelPass.text = "\(typeOfEntrant) Pass"
            }
            if let areaAccessArray = guest.access.areaAccess {
                convertToStringAreaAccessArray(areaAccessArray: areaAccessArray)
            }
            if let rideAccessArray = guest.access.rideAccess {
                convertToStringRideAccessArray(rideAccessArray: rideAccessArray)
            }
            if let discountAccessArray = guest.access.discountAccess {
                convertToStringDiscountAccessArray(discountAccessArray: discountAccessArray)
            }
            
            uiComponents.createInterfaceForCardPassLabels(areaAccessArray: areaAccessStringArray, rideAccessArray: rideAccessStringArray, discountAccessArray: discountAccessStringArray)
            addLabelToStackView(uiComponents.totalPrivilegesArray)
            
        case "Food", "Ride", "Maintenance", "SeniorManager", "General": if let firstName = hourlyEmployee.firstName as String!, let lastName = hourlyEmployee.lastName as String! {
            nameLabelPass.text = "\(firstName) \(lastName)"
            typeLabelPass.text = "\(typeOfEntrant) Pass"
        }
        if let areaAccessArray = hourlyEmployee.access.areaAccess {
            convertToStringAreaAccessArray(areaAccessArray: areaAccessArray)
        }
        if let rideAccessArray = hourlyEmployee.access.rideAccess {
            convertToStringRideAccessArray(rideAccessArray: rideAccessArray)
        }
        if let discountAccessArray = hourlyEmployee.access.discountAccess {
            convertToStringDiscountAccessArray(discountAccessArray: discountAccessArray)
        }
        
        uiComponents.createInterfaceForCardPassLabels(areaAccessArray: areaAccessStringArray, rideAccessArray: rideAccessStringArray, discountAccessArray: discountAccessStringArray)
        addLabelToStackView(uiComponents.totalPrivilegesArray)
            print("privilegios \(uiComponents.totalPrivilegesArray)")
            
        case "Contractor":
            if let firstName = contractEmployee.firstName as String!, let lastName = contractEmployee.lastName as String! {
                nameLabelPass.text = "\(firstName) \(lastName)"
                typeLabelPass.text = "\(typeOfEntrant) Pass"
            }
            if let areaAccessArray = contractEmployee.access.areaAccess {
                convertToStringAreaAccessArray(areaAccessArray: areaAccessArray)
            }
            if let rideAccessArray = contractEmployee.access.rideAccess {
                convertToStringRideAccessArray(rideAccessArray: rideAccessArray)
            }
            if let discountAccessArray = contractEmployee.access.discountAccess {
                convertToStringDiscountAccessArray(discountAccessArray: discountAccessArray)
            }
            
            uiComponents.createInterfaceForCardPassLabels(areaAccessArray: areaAccessStringArray, rideAccessArray: rideAccessStringArray, discountAccessArray: discountAccessStringArray)
            addLabelToStackView(uiComponents.totalPrivilegesArray)
            
        case "Vendor":
            if let firstName = vendor.firstName as String!, let lastName = vendor.lastName as String! {
                nameLabelPass.text = "\(firstName) \(lastName)"
                typeLabelPass.text = "\(typeOfEntrant) Pass"
            }
            if let areaAccessArray = vendor.access.areaAccess {
                convertToStringAreaAccessArray(areaAccessArray: areaAccessArray)
            }
            if let rideAccessArray = vendor.access.rideAccess {
                convertToStringRideAccessArray(rideAccessArray: rideAccessArray)
            }
            if let discountAccessArray = vendor.access.discountAccess {
                convertToStringDiscountAccessArray(discountAccessArray: discountAccessArray)
            }
            
            uiComponents.createInterfaceForCardPassLabels(areaAccessArray: areaAccessStringArray, rideAccessArray: rideAccessStringArray, discountAccessArray: discountAccessStringArray)
            addLabelToStackView(uiComponents.totalPrivilegesArray)
            
        default:
            break
        }

    }
    
    
    func test(privilege: String, areaAccess: AreaAccess?, rideAccess: RideAccess?, discountAccess: DiscountAccess?) {
        
        switch typeOfEntrant {
        case "Child", "Classic", "SeniorGuest", "VIP", "SeassonPass":
            
            
            if let message = guest.initialSwipe(areaAccess: areaAccess, rideAccess: rideAccess, discountAccess: discountAccess){
                testArea.text = "\(message)"
            }
            else {
            let permission = self.guest.permission
            print(permission)
            switch permission {
            case .granted( _, let message):
                if message != nil {
                    testArea.text = "\(privilege): access allowed"
                }
            case .denied( _, let message):
                if message != nil {
                    testArea.text = "\(privilege): access denied"
                }
                }
        }
        case "Food", "Ride", "Maintenance", "SeniorManager", "General":
            hourlyEmployee.swipe(areaAccess: areaAccess, rideAccess: rideAccess, discountAccess: discountAccess)
            let permission = self.hourlyEmployee.permission
            print(permission)
            switch permission {
            case .granted( _, let message):
                if message != nil {
                    testArea.text = "\(privilege): access allowed"
                    audio.playAccessGrantedSound()
                }
            case .denied( _, let message):
                if message != nil {
                    testArea.text = "\(privilege): access denied"
                    audio.playAccessDeniedSound()
                }
            }
            
        case "Contractor":
            contractEmployee.swipe(areaAccess: areaAccess, rideAccess: rideAccess, discountAccess: discountAccess)
            let permission = self.contractEmployee.permission
            print(permission)
            switch permission {
            case .granted( _, let message):
                if message != nil {
                    testArea.text = "\(privilege): access allowed"
                    audio.playAccessGrantedSound()
                }
            case .denied( _, let message):
                if message != nil {
                    testArea.text = "\(privilege): access denied"
                    audio.playAccessDeniedSound()
                }
            }
            
        case "Vendor":
            vendor.swipe(areaAccess: areaAccess, rideAccess: rideAccess, discountAccess: discountAccess)
            let permission = self.vendor.permission
            print(permission)
            switch permission {
            case .granted( _, let message):
                if message != nil {
                    testArea.text = "\(privilege): access allowed"
                    audio.playAccessGrantedSound()
                }
            case .denied( _, let message):
                if message != nil {
                    testArea.text = "\(privilege): access denied"
                    audio.playAccessDeniedSound()
                }
            }
            
        default:
            break
        }
        
    }
    
   
}
