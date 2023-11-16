//
//  ViewController.swift
//  Child Views
//
//  Created by Tejas Kashid on 05/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var toggleButton: UIButton!
    private lazy var firstChildVC = FirstChildViewController()
    private lazy var secondChildVC = SecondChildViewController()
    
    private var showFirstChildWidget = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSecondChildVC()
    }
    
    func addFirstChildVC(){
        addChild(firstChildVC)
        view.addSubview(firstChildVC.view)
                
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear) {
            self.toggleButton.setTitle("Hide Weather", for: .normal)
            self.firstChildVC.view.frame = CGRect(x: (self.view.frame.size.width/10), y: (self.view.frame.size.height/4.5), width: self.view.frame.size.width/1.25, height: self.view.frame.size.height/2.5)
            
            self.firstChildVC.view.layer.cornerRadius = 10
        }
        firstChildVC.didMove(toParent: self)
    }
    
    func addSecondChildVC(){
        addChild(secondChildVC)
        view.addSubview(secondChildVC.view)
        secondChildVC.view.frame = CGRect(x: 0, y: (view.frame.size.height/1.5), width: view.frame.size.width, height: (view.frame.size.height/2)*3)
    }
    
    //MARK: IBActions
    @IBAction func showWeatherButtonPressed(_ sender: Any) {

        showFirstChildWidget = !showFirstChildWidget
        
        if showFirstChildWidget == true {
            viewDidLayoutSubviews()
            addFirstChildVC()
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn) {
                self.firstChildVC.view.frame = CGRect(x: self.view.frame.size.width*2, y: (self.view.frame.size.height/2), width: self.view.frame.size.width, height: self.view.frame.size.height/2)
                
                
                self.firstChildVC.willMove(toParent: nil)
                self.firstChildVC.view.removeFromSuperview()
                self.firstChildVC.removeFromParent()
                
                self.toggleButton.setTitle("Show Weather", for: .normal)
            }
        }
    }


}

