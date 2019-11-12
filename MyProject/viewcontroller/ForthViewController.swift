//
//  ForthViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/15.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    var searchData = [String]()
    var isSearching = false
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = self.searchData[indexPath.item]
        cell.textLabel?.text = item
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        
        switchView.addTarget(self, action:
            #selector(switchChanged(_:)),
                             for: .valueChanged)
        cell.accessoryView = switchView

        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.backgroundColor = UIColor.red
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchtext: String){
        
        searchData = items
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            myTableView.reloadData()
        } else {
            isSearching = true
            searchData.removeAll()
            for name in items{
                if name.lowercased().contains(searchtext.lowercased()){
                    searchData.append(name)
                }
            }
            
            print(searchData)
            
            myTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myTableView.dataSource = self
        
        self.myTableView.delegate = self
        
        self.mySearchBar.delegate = self
        mySearchBar.returnKeyType = UIReturnKeyType.done
    
        searchData = items
    }
}
