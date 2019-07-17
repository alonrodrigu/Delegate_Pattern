//
//  Lesson: Delegate_Pattern
//

import UIKit
    // TODO: Mark the ViewController as conforming to the UITextFieldDelegate Protocol
class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    //ViewController Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
    // Keyboard disappears when tapping the screen somewhere else
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        textField.resignFirstResponder()
    }
    // DELEGATE METHOD : Review each character typed to decide to keep it (true) or not (false)
    // TODO: Modify code to reject (return false) if it finds any letters in the replacement string
    //  (hint-use Documentation to find a NSCharacterSet collection for letters, and a String method that finds a range using a NSCharacterSet)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    // DELEGATE METHOD : textFieldDidBeginEditing - is called when the user selects the text field
    // TODO: Add and modify the method to build expectation for the output by changing the celsiusLabel when the input field is selected
    // modify the celsiusLabel text to be a single question mark
    // modify the celsiusLabel color to be 60% red, 60% green, and 40% blue (refer to the Developer Documentation for UIColor)
    
    
    // EVENT HANDLER METHOD : Called when TextField is Changed (notice the optional binding)
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    //Stored Properties for Fahrenheit Temperature Measurement w/Observer
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet { // this property observer will run after the property is assigned a value
            updateCelsiusLabel()
        }
    }
    //Computed Property for Celsius Temperature Measurement (Read only property - getter without setter)
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    // Helper Functions
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    // Limits the number of decimal places in the output label to 1
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
}
