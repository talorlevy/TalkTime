//
//  SignUpViewController.swift
//  SignInGoogleFacebookProject
//
//  Created by Talor Levy on 2/24/23.
//

import UIKit

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

    //MARK: - Lifecycle

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
    
    //MARK: - @IBAction
    
    @IBAction func maleButtonAction(_ sender: Any) {
        selectMaleButton()
    }
    
    @IBAction func femaleButtonAction(_ sender: Any) {
        selectFemaleButton()
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        attemptSignUp()
    }
}
