//
//  AutoTableViewController.swift
//  MyProject
//
//  Created by Ben on 2019/11/5.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class AutoTableViewController: UIViewController{
    
    @IBOutlet weak var autoTable: UITableView!
    
    var cellDataList: [CellData] = [CellData(image: UIImage(named: "view1.jpeg")!, context: "32321asdfasaerwgrwgarwgawgawgawegawegaewgawegawegwegfsd\nasdfadsfadsfs\nasdfadsfasdf\nasfs\n\n"), CellData(image: UIImage(named: "img_head_angelo.png")!, context: "32321"),CellData(image: UIImage(named: "Audio.png")!, context: "32321"),CellData(image: UIImage(named: "img_head_angelo.png")!, context: "32321"),CellData(image: UIImage(named: "img_head_angelo.png")!, context: "32321"), CellData(image: UIImage(named: "view1.jpeg")!, context: "32321")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autoTable.delegate = self
        autoTable.dataSource = self
        
    }
}

extension AutoTableViewController: UITableViewDelegate{
    
}

extension AutoTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = autoTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AutoTableCell else {
            return UITableViewCell()
        }
        
        cell.autoImage.image = cellDataList[indexPath.row].image
        cell.autoLabel.numberOfLines = 0
        cell.autoLabel.text = cellDataList[indexPath.row].context
        
        return cell
        
    }
    
    
}


