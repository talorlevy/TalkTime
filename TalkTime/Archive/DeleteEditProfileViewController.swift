////
////  EditProfileViewController.swift
////  FirebaseProjectV2
////
////  Created by Talor Levy on 3/1/23.
////
//
//import UIKit
//import FirebaseAuth
//import GoogleMaps
//
//class DeleteEditProfileViewController: UIViewController {
//
//    var editProfileViewModel: DeleteEditProfileViewModel?
//    var localUser: UserModel?
//    var imagePicker: UIImagePickerController?
//
//
//    //MARK: - @IBOutlet
//
//    @IBOutlet weak var profileLabel: UILabel!
//    @IBOutlet weak var profilePicImageView: UIImageView!
//    @IBOutlet weak var profilePicButton: UIButton!
//    @IBOutlet weak var firstNameTextField: UITextField!
//    @IBOutlet weak var lastNameTextField: UITextField!
//    @IBOutlet weak var phoneTextField: UITextField!
//    @IBOutlet weak var myLocationButton: UIButton!
//    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
//    @IBOutlet weak var maleButton: UIButton!
//    @IBOutlet weak var femaleButton: UIButton!
//    @IBOutlet weak var DOBStackView: UIStackView!
//    @IBOutlet weak var maleLabel: UILabel!
//    @IBOutlet weak var femaleLabel: UILabel!
//    @IBOutlet weak var saveButton: UIButton!
//
//
//    //MARK: - override
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureClassProperties()
//        setImagePickerDelegate()
//        configureUI()
//        localizeUI()
//        configureDatePicker()
//        setFieldsToLocalUserInfo()
//        downloadProfilePicture()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        localUser = LocalData.shared.currentUser
////        fetchUserLocation()
//    }
//
//
//    //MARK: - functions
//
//    func configureClassProperties() {
//        editProfileViewModel = DeleteEditProfileViewModel(firebaseDBManager: FirebaseDatabaseManager.shared, firebaseStoreManager: FirebaseStorageManager.shared, vc: self)
//        localUser = LocalData.shared.currentUser
//        imagePicker = UIImagePickerController()
//    }
//
//    func configureUI() {
//        profilePicImageView.layer.cornerRadius = min(profilePicImageView.frame.size.width, profilePicImageView.frame.size.height) / 2.0
//        profilePicImageView.layer.masksToBounds = true
//
//        profilePicButton.layer.cornerRadius = min(profilePicButton.frame.size.width, profilePicButton.frame.size.height) / 2.0
//        profilePicButton.layer.masksToBounds = true
//
//        maleButton.isSelected = false
//        femaleButton.isSelected = false
//        DOBStackView.layer.cornerRadius = 10
//    }
//
//    func localizeUI() {
//        profileLabel.text = ProfileString.profileLabel.localized.capitalized
//        firstNameTextField.placeholder = ProfileString.firstNamePlaceholder.localized.firstUppercased
//        lastNameTextField.placeholder = ProfileString.lastNamePlaceholder.localized.firstUppercased
//        phoneTextField.placeholder = ProfileString.phonePlaceholder.localized.firstUppercased
//        myLocationButton.setTitle(ProfileString.myLocationButton.localized.firstUppercased, for: .normal)
//        maleLabel.text = ProfileString.maleLabel.localized.firstUppercased
//        femaleLabel.text = ProfileString.femaleLabel.localized.firstUppercased
//        saveButton.setTitle(ProfileString.saveButton.localized.capitalized, for: .normal)
//    }
//
//    func configureDatePicker() {
//        dateOfBirthPicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
//    }
//
//    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
//        presentedViewController?.dismiss(animated: true, completion: nil)
//    }
//
//    func setFieldsToLocalUserInfo() {
//        firstNameTextField.text = localUser?.firstName
//        lastNameTextField.text = localUser?.lastName
//        phoneTextField.text = localUser?.phone
//        dateOfBirthPicker.setDate(localUser?.dateOfBirth ?? Date(), animated: true)
//        fetchUserLocation()
//        if localUser?.gender == Constants.Gender.male { maleButton.isSelected = true }
//        if localUser?.gender == Constants.Gender.female { femaleButton.isSelected = true }
//    }
//
//    func fetchUserLocation() {
//        if localUser?.location?.latitude != 0.0 && localUser?.location?.longitude != 0.0 {
//            guard let location = localUser?.location else { return }
//            Formatting.getCityAndStateFromLatLong(latitude: location.latitude, longitude: location.longitude)
//            { [weak self] result in
//                guard let self = self else { return }
//                switch result {
//                case .success(let locationName):
//                    print("Success transcoding location coordinates to name at ProfileViewController")
//                    DispatchQueue.main.async {
//                        self.myLocationButton.setTitle(locationName, for: .normal)
//                    }
//                case .failure(let error):
//                    print("Error transcoding location coordinates to name at ProfileViewController: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//
//    func downloadProfilePicture() {
//        guard let imageUrl = localUser?.profilePictureUrl else { return }
//        ImageProvider.shared.fetchImage(url: imageUrl) { [weak self] image in
//            guard let self = self else { return }
//            DispatchQueue.main.async {
//                self.profilePicImageView.image = image
//            }
//        }
//    }
//
//    func getSelectedGender() -> Constants.Gender {
//        if maleButton.isSelected {
//            return Constants.Gender.male
//        } else if femaleButton.isSelected {
//            return Constants.Gender.female
//        } else {
//            return Constants.Gender.undefined
//        }
//    }
//
//
//    //MARK: - @IBAction
//
//    @IBAction func profilePicButtonAction(_ sender: Any) {
//        showActionSheet()
//    }
//
//    @IBAction func myLocationButtonAction(_ sender: Any) {
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "GoogleMapsViewController") as? GoogleMapsViewController else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    @IBAction func maleButtonAction(_ sender: Any) {
//        maleButton.isSelected = true
//        femaleButton.isSelected = false
//    }
//
//    @IBAction func femaleButtonAction(_ sender: Any) {
//        femaleButton.isSelected = true
//        maleButton.isSelected = false
//    }
//
//    @IBAction func saveButtonAction(_ sender: Any) {
//        let uid = localUser?.uid ?? ""
//        let firstName = firstNameTextField.text ?? ""
//        let lastName = lastNameTextField.text ?? ""
//        let phone = phoneTextField.text ?? ""
//        let dateOfBirth = dateOfBirthPicker.date
//        let gender = getSelectedGender()
//
//        if !Validation.validateProfileUpdate(firstName: firstName, lastName: lastName, phone: phone,
//                                             dateOfBirth: dateOfBirth, gender: gender, vc: self) { return }
//
//        let strDateOfBirth = Formatting.dateToString(date: dateOfBirth)
//        let strGender = Formatting.genderToString(gender: gender)
//        let userUpdate = ["first_name": firstName, "last_name": lastName, "phone": phone,
//                          "gender": strGender, "date_of_birth": strDateOfBirth]
//
//        if let profilePicture = profilePicImageView.image?.pngData() {
//            editProfileViewModel?.updateUser(uid: uid, image: profilePicture, userDictionary: userUpdate) { result in
//                DispatchQueue.main.async {
//                    switch result {
//                    case .success():
//                        self.navigationController?.popViewController(animated: true)
//                    case .failure(let error):
//                        print("Error updating user at ProfileViewController: \(error.localizedDescription)")
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                }
//            }
//        }
//    }
//}
//
//
////MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
//
//extension DeleteEditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func setImagePickerDelegate() {
//        guard let imagePicker = imagePicker else { return }
//        imagePicker.delegate = self
//    }
//
//    func openGalleryCamera() {
//        guard let imagePicker = imagePicker else { return }
//        imagePicker.allowsEditing = false
//        if imagePicker.sourceType == .photoLibrary {
//            imagePicker.sourceType = .photoLibrary
//        } else {
//            imagePicker.sourceType = .camera
//        }
//        present(imagePicker, animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            profilePicImageView.contentMode = .scaleAspectFill
//            profilePicImageView.image = image
//        }
//        dismiss(animated: true, completion: nil)
//    }
//
//    func showActionSheet() {
//        let actionSheet = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
//        actionSheet.addAction(UIAlertAction(title: ImagePickerString.camera.localized.firstUppercased,
//                                            style: .default, handler: { [weak self] (action) in
//            guard let self = self else { return }
//            print("open camera functionality")
//            self.localizeUI()
//        }))
//        actionSheet.addAction(UIAlertAction(title: ImagePickerString.gallery.localized.firstUppercased,
//                                            style: .default, handler: { [weak self] (action) in
//            guard let self = self else { return }
//            self.openGalleryCamera()
//            self.localizeUI()
//        }))
//        actionSheet.addAction(UIAlertAction(title: ImagePickerString.cancel.localized.firstUppercased,
//                                            style: .cancel, handler: { [weak self] (action) in
//            guard let self = self else { return }
//            self.localizeUI()
//        }))
//        present(actionSheet, animated: true, completion: nil)
//    }
//}
