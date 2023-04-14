//
//  SignUpViewController.swift
//  SignInGoogleFacebookProject
//
//  Created by Talor Levy on 2/24/23.
//

import UIKit
import FirebaseAuth


class SignUpViewController: UIViewController {
    
    var signUpViewModel: SignUpViewModel?
    
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var getStartedLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleLabel: UILabel!
    @IBOutlet weak var femaleLabel: UILabel!
    @IBOutlet weak var DOBStackView: UIStackView!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!

    
    //MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignUpViewModel()
        configureUI()
        localizeUI()
        configureDatePicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        localizeUI()
    }

    
    //MARK: - functions

    func configureSignUpViewModel() {
        signUpViewModel = SignUpViewModel(firebaseAuthManager: FirebaseAuthenticationManager.shared, firebaseDBManager: FirebaseDatabaseManager.shared, vc: self)
    }
    
    func configureUI() {
        getStartedLabel.font = UIFont.systemFont(ofSize: 50)
        DOBStackView.layer.cornerRadius = 5
        DOBStackView.layer.borderWidth = 0.2
        DOBStackView.layer.borderColor = UIColor.lightGray.cgColor
        maleButton.isSelected = false
        femaleButton.isSelected = false
        maleLabel.font = UIFont.systemFont(ofSize: 15)
        femaleLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    func localizeUI() {
        getStartedLabel.text = SignUpString.getStartedLabel.localized.capitalized
        emailTextField.placeholder = SignUpString.emailPlaceholder.localized.firstUppercased
        usernameTextField.placeholder = SignUpString.usernamePlaceholder.localized.firstUppercased
        firstNameTextField.placeholder = SignUpString.firstNamePlaceholder.localized.firstUppercased
        lastNameTextField.placeholder = SignUpString.lastNamePlaceholder.localized.firstUppercased
        phoneTextField.placeholder = SignUpString.phonePlaceholder.localized.firstUppercased
        passwordTextField.placeholder = SignUpString.passwordPlaceholder.localized.firstUppercased
        confirmPasswordTextField.placeholder = SignUpString.confirmPasswordPlaceholder.localized.firstUppercased
        dateOfBirthLabel.text = SignUpString.dateOfBirthLabel.localized.firstUppercased
        maleLabel.text = SignUpString.maleLabel.localized.firstUppercased
        femaleLabel.text = SignUpString.femaleLabel.localized.firstUppercased
        signUpButton.setTitle(SignUpString.signUpButton.localized.capitalized, for: .normal)
    }
    
    func configureDatePicker() {
        dateOfBirthPicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func getSelectedGender() -> Constants.Gender {
        if maleButton.isSelected {
            return Constants.Gender.male
        } else if femaleButton.isSelected {
            return Constants.Gender.female
        } else {
            return Constants.Gender.undefined
        }
    }
    
    func dateOfBirthIsSelected() -> Bool {
        if dateOfBirthPicker.isSelected {
            return true
        } else { return false }
    }
    
    
    //MARK: - @IBAction
    
    @IBAction func maleButtonAction(_ sender: Any) {
        maleButton.isSelected = true
        femaleButton.isSelected = false
    }
    
    @IBAction func femaleButtonAction(_ sender: Any) {
        femaleButton.isSelected = true
        maleButton.isSelected = false
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let provider = Constants.Provider.email
        let email = emailTextField.text ?? ""
        let username = usernameTextField.text ?? ""
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        let dateOfBirth = dateOfBirthPicker.date
        let gender = getSelectedGender()
        
        if !Validation.validateSignUp(email: email, username: username, firstName: firstName, lastName: lastName,
                                      phone: phone, password: password, confirmPassword: confirmPassword,
                                      dateOfBirth: dateOfBirth, gender: gender, vc: self) { return }
        
        signUpViewModel?.signUp(provider: provider, email: email, username: username, firstName: firstName,
                                    lastName: lastName, phone: phone, dateOfBirth: dateOfBirth,
                                    gender: gender, password: password) { result in
            switch result {
            case .success(let exists):
                if exists {
                    let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.usernameExists.localized.firstUppercased, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print("Success creating user at SignUpViewController")
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print("Error creating user at SignUpViewController: \(error.localizedDescription)")
                let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: error.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
