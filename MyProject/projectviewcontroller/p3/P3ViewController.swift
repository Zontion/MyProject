//
//  P3ViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/21.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class P3ViewController: UIViewController{
    @IBOutlet weak var myTableView: UITableView!
    
    var valueList = ["1", "2", "3", "4", "5", "6", "7", "8"]
    var imageList = [UIImage(named: "view1.jpeg"),UIImage(named: "view2.jpeg"),UIImage(named: "view3.jpeg"),UIImage(named: "view4.jpeg"),UIImage(named: "view5.jpeg"),UIImage(named: "view6.jpeg"),UIImage(named: "view7.jpeg"),UIImage(named: "view8.jpeg")]
    
    var refreshController: UIRefreshControl!
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        refreshController = UIRefreshControl()
        myTableView.addSubview(refreshController)
        
        self.myTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        
        loadCustomRefreshContents()
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        
    }
    
    func loadCustomRefreshContents() {
        
        let refreshContents = Bundle.main.loadNibNamed("RefreshContents", owner: self, options: nil)
        
        customView = refreshContents![0] as? UIView
        customView.frame = refreshController.bounds
        
        for i in 0..<customView.subviews.count {
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        refreshController.addSubview(customView)
    }
    
    // 變色旋轉動畫
    func animateRefreshStep1() {
        isAnimating = true
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
            self.labelsArray[self.currentLabelIndex].transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
            self.labelsArray[self.currentLabelIndex].textColor = self.getNextColor()
        }, completion: { _ in
            UIView.animate(withDuration: 0.05, delay: 0.0, options: .curveLinear, animations: {
                self.labelsArray[self.currentLabelIndex].transform = .identity
                self.labelsArray[self.currentLabelIndex].textColor = UIColor.black
            }, completion: { _ in
                self.currentLabelIndex += 1
                if self.currentLabelIndex < self.labelsArray.count {
                    self.animateRefreshStep1()
                }else {
                    self.animateRefreshStep2()
                }
            })
        })
    }
    
    // 變黑放大動畫
    func animateRefreshStep2() {
        UIView.animate(withDuration: 0.40, delay: 0.0, options: .curveLinear, animations: {
            let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
            for i in 0...self.labelsArray.count-1{
                self.labelsArray[i].transform = scale
            }
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
                for i in 0...self.labelsArray.count-1{
                    self.labelsArray[i].transform = .identity
                }
            }, completion: { _ in
                if self.refreshController.isRefreshing {
                    self.currentLabelIndex = 0
                    self.animateRefreshStep1()
                } else {
                    self.isAnimating = false
                    self.currentLabelIndex = 0
                    for i in 0 ..< self.labelsArray.count {
                        self.labelsArray[i].textColor = UIColor.black
                        self.labelsArray[i].transform = .identity
                    }
                }
            })
        })
    }
    
    func getNextColor() -> UIColor {
        var colorsArray: Array<UIColor> = [.magenta, .brown, .yellow,
                                           .red, .green, .blue, .orange]
        if currentColorIndex == colorsArray.count {
            currentColorIndex = 0
        }
        let returnColor = colorsArray[currentColorIndex]
        currentColorIndex += 1
        return returnColor
    }
    
    func doSomething() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(P3ViewController.endedOfWork), userInfo: nil, repeats: true)
    }
    
    // 關閉重刷
    @objc func endedOfWork() {
        refreshController.endRefreshing()
        timer.invalidate()
        timer = nil
    }
}

extension P3ViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if refreshController.isRefreshing {
            if !isAnimating {
                doSomething()
                animateRefreshStep1()
            }
        }
    }
}

extension P3ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        
        cell.tableLabel!.text = valueList[indexPath.row]
        cell.tableImageView!.image = imageList[indexPath.row]
        cell.tableLabel!.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? TableViewCell else {
            return
        }
        
        let animations = {
            cell.frame = self.view.bounds
        }
        
        let completion: (_ finished: Bool) -> () = { _ in
            self.myTableView.isScrollEnabled = false
        }
        
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: animations, completion: completion)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "🗑\nDelete") { action, index in
            print("Delete button tapped")
        }
        delete.backgroundColor = UIColor.gray
        
        let share = UITableViewRowAction(style: .normal, title: "🤗\nShare") { (action, indexPath) in
            print("Share button tapped")
        }
        share.backgroundColor = UIColor.red
        
        let download = UITableViewRowAction(style: .normal, title: "⬇️\nDownload") { action, index in
            print("Download button tapped")
        }
        download.backgroundColor = UIColor.blue
        
        return [download, share, delete]
    }
}
