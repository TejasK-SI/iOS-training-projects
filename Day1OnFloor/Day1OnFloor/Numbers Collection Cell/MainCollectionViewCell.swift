//
//  MainCollectionViewCell.swift
//  Day1OnFloor
//
//  Created by Tejas Kashid on 02/11/23.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    //MARK: IBOutlets
    
    @IBOutlet weak var outputLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configCell(indexPath: IndexPath) {
        self.outputLabel?.text = "\(indexPath.row+1)"
    }
    
    

}
