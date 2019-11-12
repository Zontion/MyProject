//
//  PhotoViewController.swift
//  MyProject
//
//  Created by Ben on 2019/10/16.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagePicker = UIImagePickerController()
    var imageAry: [UIImage] = []
    let spacing: CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.image.image = imageAry[indexPath.row]
        return cell
    }
    
    @IBAction func takePhotos(_ sender: Any){
        let alert = UIAlertController(title: "選擇照片", message: "從", preferredStyle: .actionSheet)
        
        let fromCamera = UIAlertAction(title: "相機", style: .default){(action) in self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let fromAlbum = UIAlertAction(title: "相簿", style: .default){(action) in self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)

        }
        
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(fromCamera)
        alert.addAction(fromAlbum)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage = info[.originalImage] as? UIImage{
            imageAry.append(pickerImage)
            collectionView.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: (self.view.bounds.width - (spacing * 2)) / 3, height: (self.view.bounds.width - (spacing * 2)) / 3)
    }
    
    // 左右間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return spacing
    }
    
    // 上下間距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return spacing
    }
}
