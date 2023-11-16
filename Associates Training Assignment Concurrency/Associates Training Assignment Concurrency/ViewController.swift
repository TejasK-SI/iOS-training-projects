//
//  ViewController.swift
//  Associates Training Assignment Concurrency
//
//  Created by Tejas Kashid on 08/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    var completeMatchDetails: AllMatchDetails?
    
    let matchOperationQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//MARK: IBAction Button
extension ViewController {
    @IBAction func api1Gcd(_ sender: Any){
        fetchAPI1UsingGCD()
    }
    
    @IBAction func api2Gcd(_ sender: Any){
        fetchAPI2UsingGCD()
    }
    
    @IBAction func api1OQ(_ sender: Any){
        fetchAPI1UsingOQ()
    }
    
    @IBAction func api2OQ(_ sender: Any){
        fetchAPI2UsingOQ()
    }
    
}


//MARK: API Calls
extension ViewController {
    
    //API1 with GCD
    func fetchAPI1UsingGCD() {
        
        let url = URL(string: "https://demo.sportz.io/nzin01312019187360.json")
        let dataTask = URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            guard let data = data, error == nil else {
                print("Error accessing data with URL")
                return
            }
            do {
                self.completeMatchDetails = try? JSONDecoder().decode(AllMatchDetails.self, from: data)
            } catch {
                debugPrint("Error decoding JSON data")
            }
            DispatchQueue.main.async {
                print("//-API1 GCD-//")
                print(self.completeMatchDetails!.matchdetail!.match!.livecoverage!)
                print(self.completeMatchDetails!.matchdetail!.match!.id!)
                print(self.completeMatchDetails!.matchdetail!.series!.tourName!)
                }
        }
        dataTask.resume()
    }

    //API2 with GCD
    func fetchAPI2UsingGCD() {
        
        let url = URL(string: "https://demo.sportz.io/sapk01222019186652.json")
        let dataTask = URLSession.shared.dataTask(with: url!) { [self] data, response, error in
            guard let data = data, error == nil else {
                print("Error accessing data with URL")
                return
            }
            do {
                self.completeMatchDetails = try? JSONDecoder().decode(AllMatchDetails.self, from: data)
            } catch {
                debugPrint("Error decoding JSON data")
            }
            DispatchQueue.main.async {
                print("//-API2 GCD-//")
                print(self.completeMatchDetails!.matchdetail!.match!.livecoverage!)
                print(self.completeMatchDetails!.matchdetail!.match!.id!)
                print(self.completeMatchDetails!.matchdetail!.series!.tourName!)
                }
        }
        dataTask.resume()
    }
    
    //API1 with OperationQueue
    func fetchAPI1UsingOQ() {
        let matchDetailOperation1 = BlockOperation {
            let url = URL(string: "https://demo.sportz.io/nzin01312019187360.json")
            let dataTask = URLSession.shared.dataTask(with: url!) { [self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error accessing data with URL")
                    return
                }
                do {
                    self.completeMatchDetails = try? JSONDecoder().decode(AllMatchDetails.self, from: data)
                } catch {
                    debugPrint("Error decoding JSON data")
                }
                DispatchQueue.global(qos: .userInteractive).async {
                    print("//-API1 OperationQueue-//")
                    print(self.completeMatchDetails!.matchdetail!.match!.livecoverage!)
                    print(self.completeMatchDetails!.matchdetail!.match!.id!)
                    print(self.completeMatchDetails!.matchdetail!.series!.tourName!)
                }
            }
            dataTask.resume()
        }
        matchOperationQueue.addOperation(matchDetailOperation1)
    }

    //API2 with OperationQueue
    func fetchAPI2UsingOQ() {
        let matchDetailOperation2 = BlockOperation {
            let url = URL(string: "https://demo.sportz.io/sapk01222019186652.json")
            let dataTask = URLSession.shared.dataTask(with: url!) { [self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error accessing data with URL")
                    return
                }
                do {
                    self.completeMatchDetails = try? JSONDecoder().decode(AllMatchDetails.self, from: data)
                } catch {
                    debugPrint("Error decoding JSON data")
                }
                DispatchQueue.global(qos: .userInteractive).async {
                    print("//-API2 OperationQueue-//")
                    print(self.completeMatchDetails!.matchdetail!.match!.livecoverage!)
                    print(self.completeMatchDetails!.matchdetail!.match!.id!)
                    print(self.completeMatchDetails!.matchdetail!.series!.tourName!)
                }
            }
            dataTask.resume()
        }
        matchOperationQueue.addOperation(matchDetailOperation2)
    }
    
    
}
