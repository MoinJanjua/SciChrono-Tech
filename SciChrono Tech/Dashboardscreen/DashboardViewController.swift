//
//  DashboardViewController.swift
//  SciChrono Tech
//
//  Created by UCF 2 on 10/02/2025.
//

    
    import UIKit

class DashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var MainView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let imagesList = ["scal","scical","agecal","histry2","Image",]
    let titleList = [
        "Standard Calculator",
        "Scientific Calculator",
        "Age Calculator",
        "History",
        "Unit Conversion",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        applyCornerRadiusToBottomCorners(view: MainView, cornerRadius: 25)
        
        // Register the custom cell
    }
    
    @IBAction func appSetting(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.modalTransitionStyle = .crossDissolve
        self.present(newViewController, animated: true, completion: nil)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        
        cell.titleImage.image = UIImage(named: imagesList[indexPath.row])
        cell.titleLb.text = titleList[indexPath.row]
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.systemYellow.cgColor
        cell.contentView.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 10
        let availableWidth = collectionViewWidth - (spacing * 3)
        let width = availableWidth / 2
        return CGSize(width: width - 20, height: width + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20) // Adjust as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "StandardcalculatorViewController") as! StandardcalculatorViewController
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 1
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScientificCalculatorViewController") as! ScientificCalculatorViewController
           
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 2
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AgeCalculatorViewController") as! AgeCalculatorViewController
            
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 3
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
          
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
        else if indexPath.row == 4
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "UnitconversionViewController") as! UnitconversionViewController
           
            newViewController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            newViewController.modalTransitionStyle = .crossDissolve
            self.present(newViewController, animated: true, completion: nil)
        }
    }
}


    
    
    
    
   
    
//    @IBAction func Scical(_ sender: Any) {
//        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ScientificCalculatorViewController") as! ScientificCalculatorViewController
//        newViewController.modalPresentationStyle = .fullScreen
//        newViewController.modalTransitionStyle = .crossDissolve
//        self.present(newViewController, animated: true, completion: nil)
//    
//    }
//    @IBAction func AgeCal(_ sender: Any) {
//        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AgeCalculatorViewController") as! AgeCalculatorViewController
//        newViewController.modalPresentationStyle = .fullScreen
//        newViewController.modalTransitionStyle = .crossDissolve
//        self.present(newViewController, animated: true, completion: nil)
//    
//    }
//    @IBAction func History(_ sender: Any) {
//        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
//        newViewController.modalPresentationStyle = .fullScreen
//        newViewController.modalTransitionStyle = .crossDissolve
//        self.present(newViewController, animated: true, completion: nil)
//    
//    }
    

//    @IBAction func Unitconversion(_ sender: Any) {
//        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "UnitconversionViewController") as! UnitconversionViewController
//        newViewController.modalPresentationStyle = .fullScreen
//        newViewController.modalTransitionStyle = .crossDissolve
//        self.present(newViewController, animated: true, completion: nil)
//    
//    }


