//
//  CollectionInTableViewCell.swift
//  Day1OnFloor
//
//  Created by Tejas Kashid on 02/11/23.
//

import UIKit

class CollectionInTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var apiCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAPICollectionView()
    }
    
    func setupAPICollectionView() {
        apiCollectionView.delegate = self
        apiCollectionView.dataSource = self
        apiCollectionView.register(UINib(nibName: "APICollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "APICollectionViewCell")
        apiCollectionView.backgroundColor = .lightGray
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "APICollectionViewCell", for: indexPath) as? APICollectionViewCell else {return UICollectionViewCell()}
        
        cell.fetchData(indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 500)
    }
    
}
