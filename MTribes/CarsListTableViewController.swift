//
//  CarsListTableViewController.swift
//  MTribes
//
//  Created by Deepesh Gairola on 17/10/17.
//  Copyright © 2017 Deepesh Gairola. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CarsListTableViewController: UITableViewController, NVActivityIndicatorViewable {

    var searchResult: [Car]!
    var objCar : Car?
    var selectedCar : Car!
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.title = "List"
        
        startAnimating(NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE, message: "Please wait while we search a suitable ride for you!", messageFont: UIFont.systemFont(ofSize: 24), type: .orbit, color: UIColor.white, padding: nil, displayTimeThreshold: 2, minimumDisplayTime: 2, backgroundColor: UIColor(red: 0.9020, green: 0.3490, blue: 0.4000, alpha: 1), textColor: UIColor.white)
       
        self.getCarsData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getCarsData() {
        
        let cabRequestHandler = CarDataRequestHandler()
        
        cabRequestHandler.requestCabDataFromServer(completion: { (result, error, statusCode) in

            self.searchResult = result.car
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // in half a second...
                self.reloadUI()
            }
        })
    }
    
    func reloadUI()  {
        
            self.tableView.reloadData()
            self.stopAnimating()
        
    }
    
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.searchResult?.count) != nil {
                return (self.searchResult.count)
        }else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        
        objCar = self.searchResult[indexPath.row]
        
        cell.textLabel?.text = objCar?.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedCar = self.searchResult[indexPath.row]
        self.performSegue(withIdentifier: "singleCarSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let vcSingleCarViewController = segue.destination as? SingleCarViewController {
            vcSingleCarViewController.objectCar = self.selectedCar
        }
    }
}
