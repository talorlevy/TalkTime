//
//  EditProfileViewController.swift
//  TalkTime
//
//  Created by Talor Levy on 3/31/23.
//

import UIKit

class EditProfileViewController: UIViewController {

    var imagePicker: UIImagePickerController?
    
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var editProfileLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var changePhotoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioButton: UIButton!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var dateOfBirthButton: UIButton!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderButton: UIButton!

    
    // MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()
        makePictureClickable()
        configureButtons()
    }
    
    
    // MARK: - functions

    func configureButtons() {
        emailButton.contentHorizontalAlignment = .right
        usernameButton.contentHorizontalAlignment = .right
        nameButton.contentHorizontalAlignment = .right
        phoneButton.contentHorizontalAlignment = .right
        emailButton.contentHorizontalAlignment = .right
        locationButton.contentHorizontalAlignment = .right
        bioButton.contentHorizontalAlignment = .right
        dateOfBirthButton.contentHorizontalAlignment = .right
        genderButton.contentHorizontalAlignment = .right
    }
    
    func makePictureClickable() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleProfilePhotoTap(tapGestureREcognizer:)))
        profilePictureImageView.isUserInteractionEnabled = true
        profilePictureImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleProfilePhotoTap(tapGestureREcognizer: UITapGestureRecognizer) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            present(imagePickerController, animated: true)
        }
    
    // MARK: - @IBAction
    
    @IBAction func emailButtonAction(_ sender: Any) {
        // show warning saying email cannot be changed
    }
    
    @IBAction func usernameButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditSingleAttributeViewController") as? EditSingleAttributeViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func nameButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditNameViewController") as? EditNameViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func phoneButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditSingleAttributeViewController") as? EditSingleAttributeViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func locationButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditLocationViewController") as? EditLocationViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func bioButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditSingleAttributeViewController") as? EditSingleAttributeViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func dateOfBirthButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditDateOfBirthViewController") as? EditDateOfBirthViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func genderButtonAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditGenderViewController") as? EditGenderViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            profilePictureImageView.contentMode = .scaleAspectFill
            profilePictureImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: ImagePickerString.camera.localized.firstUppercased,
                                            style: .default, handler: { (action) in
//            guard let self = self else { return }
            print("open camera functionality")
//            self.localizeUI()
        }))
        actionSheet.addAction(UIAlertAction(title: ImagePickerString.gallery.localized.firstUppercased,
                                            style: .default, handler: { [weak self] (action) in
            guard let self = self else { return }
            self.openGalleryCamera()
//            self.localizeUI()
        }))
        actionSheet.addAction(UIAlertAction(title: ImagePickerString.cancel.localized.firstUppercased,
                                            style: .cancel, handler: { (action) in
//            guard let self = self else { return }
//            self.localizeUI()
        }))
        present(actionSheet, animated: true, completion: nil)
    }
}
