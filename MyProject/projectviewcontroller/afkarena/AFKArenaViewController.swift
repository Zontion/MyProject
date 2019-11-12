//
//  AFKArenaViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/23.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class AFKArenaViewController: UIViewController{
    
    @IBOutlet weak var afkCollectionView: UICollectionView!
    
    var characterList: [AFKCharacter]?
    var selectedCharacter :AFKCharacter?
    
    var afkRefreshContents :UIRefreshControl!
    var customView: UIView!
    var labelsArray: Array<UILabel> = []
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterList = AFKCharacter.createCharacters()
        
        self.afkCollectionView.register(UINib(nibName: "AFKCell", bundle: nil), forCellWithReuseIdentifier: "afkCell")
        
        afkCollectionView.dataSource = self
        afkCollectionView.delegate = self
        
        // 加入刷新content
        afkRefreshContents = UIRefreshControl()
        afkCollectionView.addSubview(afkRefreshContents)
        
        loadAFKRefreshContents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadAFKRefreshContents() {
        
        let refreshContents = Bundle.main.loadNibNamed("AFKRefreshContents", owner: self, options: nil)
        
        customView = refreshContents![0] as? UIView
        customView.frame = afkRefreshContents.bounds
        
        for i in 0..<customView.subviews.count {
            labelsArray.append(customView.viewWithTag(i + 1) as! UILabel)
        }
        
        afkRefreshContents.addSubview(customView)
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
                if self.afkRefreshContents.isRefreshing {
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
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(AFKArenaViewController.endedOfWork), userInfo: nil, repeats: true)
    }
    
    // 關閉重刷
    @objc func endedOfWork() {
        afkRefreshContents.endRefreshing()
        timer.invalidate()
        timer = nil
    }
}

extension AFKArenaViewController : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if afkRefreshContents.isRefreshing {
            if !isAnimating {
                doSomething()
                animateRefreshStep1()
            }
        }
    }
}

extension AFKArenaViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList != nil ? characterList!.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = afkCollectionView.dequeueReusableCell(withReuseIdentifier: "afkCell", for: indexPath) as? AFKCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.afkImageView!.image = characterList![indexPath.row].picture
        cell.afkLabel!.text = characterList![indexPath.row].name
        cell.afkLabel!.textAlignment = .center
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(555)
        selectedCharacter = characterList![indexPath.row]
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            
            let destination = segue.destination as! AFKDetailViewController
            
            destination.afkCharacter = selectedCharacter
        }
    }
}

extension AFKArenaViewController: UICollectionViewDelegateFlowLayout{
    
}
