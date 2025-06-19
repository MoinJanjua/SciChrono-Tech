import UIKit

class AgeCalculatorViewController: UIViewController {

    @IBOutlet weak var DOBCAL: UIDatePicker!
    @IBOutlet weak var Datetill: UIDatePicker!
    @IBOutlet weak var calculatedageres: UITextField! // Change to UITextField
    @IBOutlet weak var MainView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set default Date till as current date
        Datetill.setDate(Date(), animated: false)
        applyCornerRadiusToBottomCorners(view: MainView, cornerRadius: 25)

    }

    @IBAction func agecalculator(_ sender: Any) {
        let dob = DOBCAL.date
        let dateTill = Datetill.date
        
        // Calculate the difference between the dates
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: dob, to: dateTill)
        
        // Calculate total months
        let totalMonths = calendar.dateComponents([.month], from: dob, to: dateTill).month ?? 0
        
        // Calculate total weeks (assuming 7 days per week)
        let totalDays = calendar.dateComponents([.day], from: dob, to: dateTill).day ?? 0
        let totalWeeks = totalDays / 7
        
        // Display the result in the calculatedageres text field
        let ageString = "\(components.year ?? 0) years, \(components.month ?? 0) months, \(components.day ?? 0) days"
        let monthsString = "\(totalMonths) months, \(components.day ?? 0) days"
        let weeksString = "\(totalWeeks) weeks, \(components.day ?? 0) days"
        let totalDaysString = "\(totalDays) calendar days"
        
        // Combine results into a single string
        let resultString = "Age in Years, Months, Days: \n" + "\(ageString)\n" +
                           "Total Months:  \(monthsString)\n" +
                           "Total Weeks:   \(weeksString)\n" +
                           "Total Calendar Days:   \(totalDaysString)"
        
        // Assign the result to the text field
        calculatedageres.text = resultString
    }
    @IBAction func btnback(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
