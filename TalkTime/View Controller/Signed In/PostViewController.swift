//
//  PostViewController.swift
//  TalkTime
//
//  Created by Talor Levy on 3/10/23.
//

import UIKit


protocol SendPost {
    func sendPostToHome(post: PostModel)
}


class PostViewController: UIViewController {
    
    var postViewModel: PostViewModel?
        
    var imagePicker: UIImagePickerController?
    var delegate: SendPost?
    
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    
    
    //MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureClassProperties()
        localizeUI()
        setImagePickerDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        clearUI()
        localizeUI()
    }
    
    
    //MARK: - functions
    
    func configureClassProperties() {
        postViewModel = PostViewModel(firebaseDBManager: FirebaseDatabaseManager.shared, firebaseStoreManager: FirebaseStorageManager.shared, vc: self)
        imagePicker = UIImagePickerController()
    }
    
    func localizeUI() {
        postTextField.placeholder = PostString.postTextFieldPlaceholder.localized.firstUppercased
        postButton.setTitle(PostString.postButton.localized.firstUppercased, for: .normal)
    }
    
    func clearUI() {
        postTextField.text = ""
        postImageView.image = nil
    }
    
    
    //MARK: - @IBAction
    
    @IBAction func uploadImageButtonAction(_ sender: Any) {
        showActionSheet()
    }
    
    @IBAction func postButtonAction(_ sender: Any) {

        guard let userUID = LocalData.shared.currentUser?.uid,
              let username = LocalData.shared.currentUser?.username,
              let image = postImageView.image?.pngData() else { return }
        let uploadTime = Date()
        let description = postTextField.text ?? ""
        let userProfilePictureUrl = LocalData.shared.currentUser?.profilePictureUrl
        
        let postModel = PostModel(userUID: userUID, username: username,
                                  uploadTime: uploadTime, description: description,
                                  userProfilePictureUrl: userProfilePictureUrl)
        
        postViewModel?.savePost(postModel: postModel, image: image) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let postModel):
                DispatchQueue.main.async {
                    self.clearUI()
                    if let delegate = self.delegate, let tabBarController = self.tabBarController {
                        delegate.sendPostToHome(post: postModel)
                        tabBarController.selectedIndex = 0
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}


//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setImagePickerDelegate() {
        guard let imagePicker = imagePicker else { return }
        imagePicker.delegate = self
    }
    
    func openGalleryCamera() {
        guard let imagePicker = imagePicker else { return }
        imagePicker.allowsEditing = false
        if imagePicker.sourceType == .photoLibrary {
            imagePicker.sourceType = .photoLibrary
        } else {
            imagePicker.sourceType = .camera
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            postImageView.contentMode = .scaleAspectFill
            postImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: ImagePickerString.camera.localized.firstUppercased,
                                            style: .default, handler: { [weak self] (action) in
            guard let self = self else { return }
            print("open camera functionality")
            self.localizeUI()
        }))
        actionSheet.addAction(UIAlertAction(title: ImagePickerString.gallery.localized.firstUppercased,
                                            style: .default, handler: { [weak self] (action) in
            guard let self = self else { return }
            self.openGalleryCamera()
            self.localizeUI()
        }))
        actionSheet.addAction(UIAlertAction(title: ImagePickerString.cancel.localized.firstUppercased,
                                            style: .cancel, handler: { [weak self] (action) in
            guard let self = self else { return }
            self.localizeUI()
        }))
        present(actionSheet, animated: true, completion: nil)
    }
}
