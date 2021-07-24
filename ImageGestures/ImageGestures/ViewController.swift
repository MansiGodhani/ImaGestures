//
//  ViewController.swift
//  ImageGestures
//
//  Created by DCS on 24/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    private let myLabel:UILabel = {
        let label = UILabel()
        label.text = "Image Picker and Gestuer"
        label.font = label.font.withSize(22)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let mydescLabel:UILabel = {
        let label = UILabel()
        label.text = "Tap & pick image from gallery"
        label.font = label.font.withSize(16)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let imageview : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "img1")
        return imageView
    }()
    
    private let imagePicker:UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(imageview)
        view.addSubview(myLabel)
        view.addSubview(mydescLabel)
        title = "Image Gesture"
        imagePicker.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        let pinchGester = UIPinchGestureRecognizer(target: self, action: #selector(didPinchImage))
        view.addGestureRecognizer(pinchGester)
        
        let rotationGester = UIRotationGestureRecognizer(target: self, action: #selector(didRotateImage))
        view.addGestureRecognizer(rotationGester)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeImage))
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeImage))
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeImage))
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeImage))
        view.addGestureRecognizer(downSwipe)
        
        let panGester = UIPanGestureRecognizer(target: self, action: #selector(didPanImage))
        view.addGestureRecognizer(panGester)
    }
    
    override func viewDidLayoutSubviews() {
        
        myLabel.frame = CGRect(x: 20, y: view.height/2-260, width :view.width - 40, height: 40)
        mydescLabel.frame = CGRect(x: 20, y: view.height/2-220, width :view.width - 40, height: 30)
        imageview.frame = CGRect(x: 50, y: view.safeAreaInsets.top + 170, width: 150, height: 200)
    }
}

extension ViewController{
    @objc private func didTapImage(_ gesture:UITapGestureRecognizer){
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true,completion: nil)
    }
    @objc private func didPinchImage(_ gesture:UIPinchGestureRecognizer){
        imageview.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    @objc private func didRotateImage(_ gesture:UIRotationGestureRecognizer){
        imageview.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    @objc private func didSwipeImage(_ gesture:UISwipeGestureRecognizer){
        if gesture.direction == .left{
            UIView.animate(withDuration: 0.2){
                self.imageview.frame = CGRect(x:self.imageview.frame.origin.x - 40,y:self.imageview.frame.origin.y,width:200,height: 200)
            }
        }else if gesture.direction == .right{
            UIView.animate(withDuration: 0.2){
                self.imageview.frame = CGRect(x:self.imageview.frame.origin.x + 40,y:self.imageview.frame.origin.y,width:200,height: 200)
            }
        }else if gesture.direction == .up{
            UIView.animate(withDuration: 0.2){
                self.imageview.frame = CGRect(x:self.imageview.frame.origin.x,y:self.imageview.frame.origin.y - 40,width:200,height: 200)
            }
        }else if gesture.direction == .down{
            UIView.animate(withDuration: 0.2){
                self.imageview.frame = CGRect(x:self.imageview.frame.origin.x + 40,y:self.imageview.frame.origin.y,width:200,height: 200)
            }
        }
    }
    @objc private func didPanImage(_ gesture:UIPanGestureRecognizer){
        
        let x = gesture.location(in: imageview).x
        let y = gesture.location(in: imageview).y
        
        imageview.center = CGPoint(x: x, y: y)
    }
}

extension ViewController : UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageview.image = selectedImage
        }
        picker.dismiss(animated: true,completion: nil)
    }
}
