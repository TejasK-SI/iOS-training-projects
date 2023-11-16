//
//  DisplayTableViewCell.swift
//  Associates Training Assignment Concurrency
//
//  Created by Tejas Kashid on 08/11/23.
//

import UIKit

class DisplayTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var outputLabel: UILabel!
    
    
    var completeMatchDetails: AllMatchDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
}
