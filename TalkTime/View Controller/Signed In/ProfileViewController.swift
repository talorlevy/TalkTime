//
//  ProfileViewController.swift
//  TalkTime
//
//  Created by Talor Levy on 3/31/23.
//

import UIKit


class ProfileViewController: UIViewController {
    
    var viewModel: ProfileViewModel?
    
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var postCollectionView: UICollectionView!

    
    // MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        configureUI()
        displayProfilePicture()
        displayProfileInformation()
    }
    

    // MARK: - functions
    
    func initializeViewModel() {
        viewModel = ProfileViewModel(firebaseAuthManager: FirebaseAuthenticationManager.shared, vc: self)
    }
    
    func configureUI() {
        profilePictureImageView.layer.cornerRadius = min(profilePictureImageView.frame.size.width, profilePictureImageView.frame.size.height) / 2.0
        profilePictureImageView.layer.masksToBounds = true
    }
    
    func displayProfilePicture() {
        profilePictureImageView.image = UIImage(named: "no_profile_pic")
        guard let imageUrl = LocalData.shared.currentUser?.profilePictureUrl else { return }
        ImageProvider.shared.fetchImage(url: imageUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.profilePictureImageView.image = image
            }
        }
    }
    
    func displayProfileInformation() {
        if let user = LocalData.shared.currentUser {
            nameLabel.text = (user.firstName ?? "") + " " + (user.lastName ?? "")
            usernameLabel.text = user.username
            followingCountLabel.text = String(user.following?.count ?? 0)
            followersCountLabel.text = String(user.followers?.count ?? 0)
            bioLabel.text = user.bio ?? ""
        }
    }
    
    func fetchLikes() {}
    
    
    // MARK: - @IBAction

    @IBAction func settingsButtonAction(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Settings", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editProfileButtonAction(_ sender: Any) {
        guard let vc = UIStoryboard(name: "EditProfile", bundle: nil).instantiateViewController(withIdentifier: "EditProfileViewController") as? EditProfileViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signOutButtonAction(_ sender: Any) {
        viewModel?.signOut { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                print("Success signing out of SettingsViewController")
                DispatchQueue.main.async {
                    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return }
                    self.setRootViewController(vc: vc)
                }
            case .failure(let error):
                print("Error signing out of SettingsViewController: \(error.localizedDescription)")
            }
        }
    }
    
}
