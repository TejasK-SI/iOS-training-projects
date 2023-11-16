//
//  ViewController.swift
//  Day1OnFloor
//
//  Created by Tejas Kashid on 02/11/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUp()
        
    }
    
    //MARK: Setup TableView
    func setupUp() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CollectionInTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionInTableViewCell")
        tableView.register(UINib(nibName: "SecondCollectionInTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondCollectionInTableViewCell")
    }
    
    //MARK: TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionInTableViewCell", for: indexPath) as? CollectionInTableViewCell else {return UITableViewCell()}
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCollectionInTableViewCell", for: indexPath) as? SecondCollectionInTableViewCell else {return UITableViewCell()}
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    


}

