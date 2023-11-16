//
//  APICollectionViewCell.swift
//  Day1OnFloor
//
//  Created by Tejas Kashid on 02/11/23.
//

import UIKit

class APICollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
  
    func fetchData(indexPath: IndexPath) {
        let url = URL(string: "https://api.imgflip.com/get_memes")
        let dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                print("Error accessing data with URL")
                return
            }
            var allMemeData: MemeData?
            do{
                try allMemeData = JSONDecoder().decode(MemeData.self, from: data)
            }
            catch {
                print("Error decoding JSON object into struct")
            }
            let imageUrl = URL(string: allMemeData!.data.memes[indexPath.item].url)
            guard let data = try? Data(contentsOf: imageUrl!) else {
                return
            }
            
            
            DispatchQueue.main.async {
                
                self.memeImageView?.image = UIImage(data: data)
                self.memeLabel?.text = "\(allMemeData!.data.memes[indexPath.item].name)"
                
//                Working and Shows how we want it
//                print("\(allMemeData!.data.memes[indexPath.item].name)")
                
//                Working but only shows first name
//                self.memeLabel?.text = "\(allMemeData!.data.memes.first!.name)"
                
            }
        }
        dataTask.resume()
    }
}
