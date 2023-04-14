//
//  ViewController.swift
//  SignInGoogleFacebookProject
//
//  Created by Talor Levy on 2/23/23.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore
import FacebookLogin


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

    
    //MARK: - override
    
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
    
    
    //MARK: - functions
    
    // For trouble shooting - delete this later!
    func checkSignedInUsers() {
        print("SignInVC - Google: \(String(describing: GIDSignIn.sharedInstance.currentUser))")
        print("SignInVC - Facebook: \(String(describing: AccessToken.current))")
        print("SignInVC - Firebase: \(String(describing: Auth.auth().currentUser?.email))")
        print("Local user: \(String(describing: LocalData.shared.currentUser?.provider))")
    }
    // For trouble shooting - delete this later!

    func configureSignInViewModel() {
        signInViewModel = SignInViewModel(firebaseAuthManager: FirebaseAuthenticationManager.shared, firebaseDBManager: FirebaseDatabaseManager.shared, vc: self)
    }
    
    func checkIfLoggedIn() {
        signInViewModel?.isLoggedIn() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success():
                    guard let vc = UIStoryboard(name: "SignedIn", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                    self.setRootViewController(vc: vc)
                case .failure(let error):
                    print("Error fetching user at SignInViewController: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func localizeUI() {
        emailTextField.placeholder = SignInString.emailPlaceholder.localized.firstUppercased
        passwordTextField.placeholder = SignInString.passwordPlaceholder.localized.firstUppercased
        signInButton.setTitle(SignInString.signInButton.localized.capitalized, for: .normal)
        signUpButton.setTitle(SignInString.signUpButton.localized.capitalized, for: .normal)
        facebookButton.setTitle(SignInString.facebookButton.localized.capitalized, for: .normal)
        googleButton.setTitle(SignInString.googleButton.localized.capitalized, for: .normal)
    }
        
    
    //MARK: - @IBAction
        
    @IBAction func signInButtonAction(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        signInViewModel?.signInWithEmail(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success():
                    print("Success fetching user at SignInViewController")
                    guard let vc = UIStoryboard(name: "SignedIn", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                    self.setRootViewController(vc: vc)
                case .failure(let error):
                    print("Error fetching user at SignInViewController: \(error)")
                }
            }
        }
    }
    
    
    @IBAction func signInToGoogleButtonAction(_ sender: Any) {
        signInViewModel?.signInWithGoogle() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success():
                    print("Success fetching user at SignInViewController")
                    guard let vc = UIStoryboard(name: "SignedIn", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                    self.setRootViewController(vc: vc)
                case .failure(let error):
                    print("Error fetching user at SignInViewController: \(error)")
                }
            }
        }
    }
    
    @IBAction func signInToFacebookButtonAction(_ sender: Any) {
        signInViewModel?.signInWithFacebook() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success():
                    print("Success fetching user at SignInViewController")
                    guard let vc = UIStoryboard(name: "SignedIn", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController else { return }
                    self.setRootViewController(vc: vc)
                case .failure(let error):
                    print("Error fetching user at SignInViewController: \(error.localizedDescription)")
                }
            }
        }
    }
    
    @IBAction func signUpLabelAction(_ sender: Any) {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}

