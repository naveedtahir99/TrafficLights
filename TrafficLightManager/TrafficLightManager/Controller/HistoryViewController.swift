//
//  HistoryViewController.swift
//  TrafficLightManager
//
//  Created by Naveed on 23/10/2023.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "History"
       setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
 
}
//MARK:- TableView delegate
extension HistoryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.fetchDataEntities().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let lightState = CoreDataManager.shared.fetchDataEntities()[indexPath.row]
        cell.textLabel?.text = "\(lightState.name!)  \(lightState.stateTime!)"
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0.2
        return cell
    }
}
