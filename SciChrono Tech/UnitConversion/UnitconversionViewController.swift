import UIKit

class UnitconversionViewController: UIViewController {

    @IBOutlet weak var inputtext: UITextField!
    @IBOutlet weak var lengthrest: UITextField!
    @IBOutlet weak var btnconvert: UIButton!
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var fromdpdown: DropDown!
    @IBOutlet weak var todpdown: DropDown!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let units = ["Meters", "Kilometers", "Miles", "Feet", "Inches"]
        fromdpdown.optionArray = units
        todpdown.optionArray = units

        fromdpdown.selectedIndex = 0
        todpdown.selectedIndex = 0
    }


    @IBAction func btnconversion(_ sender: Any) {
        guard let inputText = inputtext.text, !inputText.isEmpty,
              let inputValue = Double(inputText) else {
            showError(message: "Please enter a valid number")
            return
        }

        // Ensure selected indexes are valid
        guard let fromIndex = fromdpdown.selectedIndex, fromIndex >= 0, fromIndex < fromdpdown.optionArray.count,
              let toIndex = todpdown.selectedIndex, toIndex >= 0, toIndex < todpdown.optionArray.count else {
            showError(message: "Please select valid units")
            return
        }

        let fromUnit = fromdpdown.optionArray[fromIndex]
        let toUnit = todpdown.optionArray[toIndex]

        if let result = convertLength(value: inputValue, fromUnit: fromUnit, toUnit: toUnit) {
            DispatchQueue.main.async {
                self.lengthrest.text = String(format: "%.2f", result)
            }
        } else {
            showError(message: "Conversion Error: Invalid unit")
        }
    }

    func convertLength(value: Double, fromUnit: String, toUnit: String) -> Double? {
        let unitsToMeters: [String: Double] = [
            "Meters": 1.0,
            "Kilometers": 1000.0,
            "Miles": 1609.34,
            "Feet": 0.3048,
            "Inches": 0.0254
        ]

        guard let fromFactor = unitsToMeters[fromUnit], let toFactor = unitsToMeters[toUnit] else {
            return nil
        }

        return (value * fromFactor) / toFactor
    }
    @IBAction func btnback(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func showError(message: String) {
        DispatchQueue.main.async {
            self.lengthrest.text = message
        }
    }
}
