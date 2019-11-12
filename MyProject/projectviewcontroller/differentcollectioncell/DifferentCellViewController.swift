//
//  DifferentCellViewController.swift
//  MyProject
//
//  Created by Ben on 2019/11/4.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class DifferentCellViewController: UIViewController{
    
    @IBOutlet weak var dcCollectionView: UICollectionView!
    
    let nameArray = ["Ariel", "Bella", "Cathy", "Dessy", "Elethia", "Fee", "Gigi"]
    let contextArray = ["123456", "234567", "345678", "456789", "567890", "678901", "789012"]
    
    let cellTypeArray = [0, 1, 0, 0, 1, 1, 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dcCollectionView.register(UINib(nibName: "Cell1", bundle: nil), forCellWithReuseIdentifier: "cell1")
        self.dcCollectionView.register(UINib(nibName: "Cell2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        
        dcCollectionView.delegate = self
        dcCollectionView.dataSource = self
    }
}

extension DifferentCellViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellTypeArray[indexPath.row] == 0{
            let cell = dcCollectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? Cell1
            cell?.label1.text = nameArray[indexPath.row]
            cell?.label2.text = contextArray[indexPath.row]
            return cell!
        } else {
            let cell = dcCollectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? Cell2
            cell?.label1.text = nameArray[indexPath.row]
            cell?.label2.text = contextArray[indexPath.row]
            return cell!
        }
        
        
    }
}

extension DifferentCellViewController: UICollectionViewDelegate{
    
}
