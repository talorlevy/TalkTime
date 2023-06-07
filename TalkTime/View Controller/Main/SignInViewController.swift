//
//  ViewController.swift
//  SignInGoogleFacebookProject
//
//  Created by Talor Levy on 2/23/23.
//

import UIKit

class SignInViewController: UIViewController {
    
    var signInViewModel: SignInViewModel?
    
    //MARK: - @IBOutlet

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSignInViewModel()
        checkIfLoggedIn()
        localizeUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        localizeUI()
        checkSignedInUsers()
    }

    //MARK: - @IBAction
        
    @IBAction func signInButtonAction(_ sender: Any) {
        emailSignIn()
    }
    
    @IBAction func signInToGoogleButtonAction(_ sender: Any) {
        signInWithGoogle()
    }
    
    @IBAction func signInToFacebookButtonAction(_ sender: Any) {
        signInWithFacebook()
    }
    
    @IBAction func signUpLabelAction(_ sender: Any) {
        pushSignUpVC()
    }
}

