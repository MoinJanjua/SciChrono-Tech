//
//  HomeCollectionViewCell.swift
//  SciChrono Tech
//
//  Created by UCF 2 on 19/02/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
  
    
    // Array to store images for cycling
    var imageList: [UIImage] = []
    var currentImageIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Button styling (optional)
       
    }
}
