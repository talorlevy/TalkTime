//
//  SignUpViewControllerExtension.swift
//  TalkTime
//
//  Created by Talor Levy on 6/7/23.
//

import UIKit
import FirebaseAuth

extension SignUpViewController {

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
    
    func selectMaleButton() {
        maleButton.isSelected = true
        femaleButton.isSelected = false
    }
    
    func selectFemaleButton() {
        femaleButton.isSelected = true
        maleButton.isSelected = false
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
    
    func attemptSignUp() {
        DispatchQueue.main.async { [ weak self] in
            guard let self = self else { return }
            let provider = Constants.Provider.email
            let email = self.emailTextField.text ?? ""
            let username = self.usernameTextField.text ?? ""
            let firstName = self.firstNameTextField.text ?? ""
            let lastName = self.lastNameTextField.text ?? ""
            let phone = self.phoneTextField.text ?? ""
            let password = self.passwordTextField.text ?? ""
            let confirmPassword = self.confirmPasswordTextField.text ?? ""
            let dateOfBirth = self.dateOfBirthPicker.date
            let gender = self.getSelectedGender()
            
            if !Validation.validateSignUp(email: email,
                                          username: username,
                                          firstName: firstName,
                                          lastName: lastName,
                                          phone: phone,
                                          password: password,
                                          confirmPassword: confirmPassword,
                                          dateOfBirth: dateOfBirth,
                                          gender: gender,
                                          vc: self) { return }
            
            self.signUpViewModel?.signUp(provider: provider,
                                         email: email,
                                         username: username,
                                         firstName: firstName,
                                         lastName: lastName,
                                         phone: phone,
                                         dateOfBirth: dateOfBirth,
                                         gender: gender,
                                         password: password) { result in
                switch result {
                case .success(let exists):
                    if exists {
                        let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: WarningString.usernameExists.localized.firstUppercased, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    let alert = UIAlertController(title: WarningString.warning.localized.firstUppercased, message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: WarningString.ok.localized.firstUppercased, style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
