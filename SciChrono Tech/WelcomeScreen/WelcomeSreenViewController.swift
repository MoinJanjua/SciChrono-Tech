//
//  WelcomeSreenViewController.swift
//  SciChrono Tech
//
//  Created by UCF 2 on 10/02/2025.
//

import UIKit

class WelcomeSreenViewController: UIViewController {
    @IBOutlet weak var btngo: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
     applyGradientToButton(button: btngo)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func Btnletgo(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    
    }



}
