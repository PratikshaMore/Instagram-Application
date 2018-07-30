//
//  SharePhotoController.swift
//  Instagram Application
//
//  Created by Pratiksha Pradip More on 7/30/18.
//  Copyright © 2018 Pratiksha Pradip More. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        
        setupImageAndTextViews()
    }
    
    var imageView: UIImageView = {
        let iv  = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    
    fileprivate func setupImageAndTextViews() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleShare() {
        
        guard let caption = textView.text, caption.characters.count > 0 else { return }
        
        guard let image = selectedImage else { return }
        guard let uploadData = UIImageJPEGRepresentation(image, 0.5) else { return }
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("Posts").child(filename)
        storageRef.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                print("failed to upload image")
                return
            }
            
            storageRef.downloadURL(completion: { (downloadURL, err) in
                if let err = err {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print("Failed to fetch downloadURL:", err)
                    return
                }
                
                guard let imageUrl = downloadURL?.absoluteString else { return }
                
                print("Successfully uploaded profile image: ", imageUrl)
                
                self.saveToDatabseWithImageUrl(imageUrl: imageUrl)
               
            })
        }
    }
    
    fileprivate func saveToDatabseWithImageUrl(imageUrl: String) {
        guard let postImage = selectedImage else { return }
        guard let caption = textView.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("Posts").child(uid)
        let ref = userPostRef.childByAutoId()
        let values = ["imageUrl": imageUrl, "caption": caption, "imageWidth": postImage.size.width, "imageHeight": postImage.size.height, "creationDate": Date().timeIntervalSince1970] as [String : Any]
        
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB: ", err)
                return
            }
            
            print("Successfully saved posts to db")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
