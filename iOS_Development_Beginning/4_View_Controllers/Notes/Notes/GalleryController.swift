//
//  GalleryController.swift
//  Notes
//
//  Created by Alexey Danilov on 7/20/19.
//  Copyright © 2019 DanilovDev. All rights reserved.
//

import UIKit

class GalleryController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    
    private let itemsPerRow: CGFloat = 3
    
    private let padding: CGFloat = 16

    private var selectedIndex: Int?
    
    private let galleryCellIdentifier = "GalleryCell"
    
    @IBOutlet weak var galleryCollectionView: UICollectionView! {
        didSet {
            galleryCollectionView.register(UINib(nibName: "GalleryCell",
                                                 bundle: nil),
                                           forCellWithReuseIdentifier: galleryCellIdentifier)
            galleryCollectionView.delegate = self
            galleryCollectionView.dataSource = self
        }
    }
    
    
    private var images = [
        UIImage(named: "image_1"),
        UIImage(named: "image_2"),
        UIImage(named: "image_3"),
        UIImage(named: "image_4"),
        UIImage(named: "image_5")
    ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    @IBAction func addImageButtonTapped(_ sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,
                animated: true,
                completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension GalleryController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: galleryCellIdentifier,
                                                      for: indexPath) as! GalleryCell
        let image = images[indexPath.item]
        cell.galleryImage = image
        return cell
    }
}

// MARK: - UIViewController Style
extension GalleryController {
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension GalleryController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(pickedImage)
        }
        
        dismiss(animated: true, completion: { [weak self] in
            self?.galleryCollectionView.reloadData()
        })
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension GalleryController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = padding * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return  UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        performSegue(withIdentifier: "ShowFullImage",
                     sender: self)
    }
}

// MARK: - Navigation
extension GalleryController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFullImage" {
            if let destination = segue.destination as? FullImageController {
                destination.images = images
                destination.selectedIndex = selectedIndex ?? 0
            }
        }
    }
}
