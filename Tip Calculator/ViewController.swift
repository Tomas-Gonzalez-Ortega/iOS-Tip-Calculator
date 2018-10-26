//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Tom Nuss on 2018-02-07.
//  Copyright © 2018 Tom Nuss. All rights reserved.
//

import UIKit

// overloaded + operator to add NSDecimalNumbers
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.adding(right)
}

// overloaded * operator to multiply NSDecimalNumbers
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.multiplying(by: right)
}

// overloaded / operator to divide NSDecimalNumbers
func /(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.dividing(by: right)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var BillTotal: UILabel!
    @IBOutlet weak var tip10Field: UITextField!
    @IBOutlet weak var tip15Field: UITextField!
    @IBOutlet weak var tip20Field: UITextField!
    @IBOutlet weak var total10Field: UITextField!
    @IBOutlet weak var total15Field: UITextField!
    @IBOutlet weak var total20Field: UITextField!
    @IBOutlet weak var customTipPercentageSlider: UISlider!
    @IBOutlet weak var customTipPercentage: UILabel!
    @IBOutlet weak var customTipField: UITextField!
    @IBOutlet weak var customTotalField: UITextField!
    @IBOutlet weak var inputTextField: UITextField!
    
    // called when the user edits the text in the inputTextField or moves the customTipPercentageSlider's thumb
    @IBAction func calculateTip(sender: AnyObject) {
        print("is this called?")
        let decimal100 = NSDecimalNumber(decimal: 100.00)
        let decimal10Percent = NSDecimalNumber(decimal: 0.10)
        let decimal15Percent = NSDecimalNumber(decimal: 0.15)
        let decimal20Percent = NSDecimalNumber(decimal: 0.20)
        let inputString = inputTextField.text // get user input
        // convert slider value to an NSDecimalNumber
        let sliderValue = NSDecimalNumber(decimal: Decimal(Int(customTipPercentageSlider.value)))
        // divide sliderValue by 100.00 to get tip %
        let customPercent = sliderValue / decimal100
        
        // if there is a bill amount
        if !(inputString?.isEmpty)! {
            
            // convert to NSDecimalNumber and insert decimal point
            let billAmount = NSDecimalNumber(string: inputString)
        
            // did customTipPercentageSlider generate the event?
            if sender is UISlider {
                // thumb moved so update the Labels with new custom percent
                customTipPercentage.text = NumberFormatter.localizedString(from: customPercent, number: NumberFormatter.Style.percent)
                
                // calculate custom tip and display custom tip and total
                let customTip = billAmount * customPercent
                customTipField.text = formatAsCurrency(number: customTip)
                customTotalField.text = formatAsCurrency(number: billAmount + customTip)
            }
            
            // did inputTextField generate the event?
            if sender is UITextField {
            
                // update billAmountLabel with currency-formatted total
                //billAmountLabel.text = " " + formatAsCurrency(number: billAmount)
                // calculate and display the 10% tip and total
                let tenTip = billAmount * decimal10Percent
                tip10Field.text = formatAsCurrency(number: tenTip)
                total10Field.text = formatAsCurrency(number: billAmount + tenTip)
                
                // calculate and display the 15% tip and total
                let fifteenTip = billAmount * decimal15Percent
                tip15Field.text = formatAsCurrency(number: fifteenTip)
                total15Field.text = formatAsCurrency(number: billAmount + fifteenTip)
            
                // calculate and display the 20% tip and total
                let twentyTip = billAmount * decimal20Percent
                tip20Field.text = formatAsCurrency(number: twentyTip)
                total20Field.text = formatAsCurrency(number: billAmount + twentyTip)
            }
        }
        else { // clear all Labels
            //billAmountLabel.text = ""
            tip10Field.text = ""
            total10Field.text = ""
            tip15Field.text = ""
            total15Field.text = ""
            tip20Field.text = ""
            total20Field.text = ""
            customTipField.text = ""
            customTotalField.text = ""
        }
    }
    
    // convert a numeric value to localized currency string
    func formatAsCurrency(number: NSNumber) -> String {
        return NumberFormatter.localizedString(
            from: number, number: NumberFormatter.Style.currency)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // select inputTextField so keypad displays when the view loads
        inputTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
