//
//  SearchViewController.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 3/1/23.
//

import UIKit


class SearchViewController: UIViewController {

    var searchViewModel: SearchViewModel?
    
    var showFollowing: Bool = true
    var showFollowers: Bool = false
    var showOtherUsers: Bool = false

    
    //MARK: - @IBOutlet

    @IBOutlet weak var usersSearchBar: UISearchBar!
    @IBOutlet weak var usersSegmentControl: UISegmentedControl!
    @IBOutlet weak var usersTableView: UITableView!
    
    
    //MARK: - override

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
        fetchAllUsers()
    }
    
    
    //MARK: - functions
    
    func initializeViewModel() {
        searchViewModel = SearchViewModel(firebaseDBManager: FirebaseDatabaseManager.shared, firebaseStoreManager: FirebaseStorageManager.shared, vc: self)
    }
    
    func fetchAllUsers() {
        searchViewModel?.fetchAllUsers { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    print("Success fetching all users at SearchViewController")
                    self.refreshUsersTableView()
                }
            case .failure(let error):
                print("Error fetching all users at SearchViewController: \(error.localizedDescription)")
            }
        }
    }

    func refreshUsersTableView() {
        usersTableView.reloadData()
    }
    
    
    
    //MARK: - @IBAction

    @IBAction func friendSegmentControlAction(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        switch selectedSegmentIndex {
        case 0:
            showFollowing = true
            showFollowers = false
            showOtherUsers = false
            usersTableView.reloadData()
        case 1:
            showFollowing = false
            showFollowers = true
            showOtherUsers = false
            usersTableView.reloadData()
        case 2:
            showFollowing = false
            showFollowers = false
            showOtherUsers = true
            usersTableView.reloadData()
        default:
            break
        }
    }
}


//MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showFollowing {
            return searchViewModel?.following.count ?? 0
        } else if showFollowers {
            return searchViewModel?.followers.count ?? 0
        }
        else {
            return searchViewModel?.otherUsers.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileCell else { return UITableViewCell() }
        if showFollowing {
            let user = searchViewModel?.following[indexPath.row]
            myCell.profileImageView.image = UIImage(named: "no_profile_pic")
            if let imageURL = user?.profilePictureUrl {
                ImageProvider.shared.fetchImage(url: imageURL) { image in
                    DispatchQueue.main.async {
                        myCell.profileImageView.image = image
                    }
                }
            }
            myCell.profileFirstNameLabel.text = user?.firstName
            myCell.profileLastNameLabel.text = user?.lastName
            myCell.profileButton.setTitle("unfollow", for: .normal)
            myCell.profileButton.tag = indexPath.row
            return myCell
        } else if showFollowers {
            let user = searchViewModel?.followers[indexPath.row]
            myCell.profileImageView.image = UIImage(named: "no_profile_pic")
            if let imageURL = user?.profilePictureUrl {
                ImageProvider.shared.fetchImage(url: imageURL) { image in
                    DispatchQueue.main.async {
                        myCell.profileImageView.image = image
                    }
                }
            }
            myCell.profileFirstNameLabel.text = user?.firstName
            myCell.profileLastNameLabel.text = user?.lastName
            myCell.profileButton.setTitle("follow", for: .normal)
            myCell.profileButton.tag = indexPath.row
            return myCell
        } else {
            let user = searchViewModel?.otherUsers[indexPath.row]
            myCell.profileImageView.image = UIImage(named: "no_profile_pic")
            if let imageURL = user?.profilePictureUrl {
                ImageProvider.shared.fetchImage(url: imageURL) { image in
                    DispatchQueue.main.async {
                        myCell.profileImageView.image = image
                    }
                }
            }
            myCell.profileFirstNameLabel.text = user?.firstName
            myCell.profileLastNameLabel.text = user?.lastName
            myCell.profileButton.setTitle("send friend request", for: .normal)
            myCell.profileButton.tag = indexPath.row

            return myCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}


//MARK: - UITableViewCell

class ProfileCell: UITableViewCell {
        
//    var searchViewModel = SearchViewModel(firebaseDBManager: FirebaseDatabaseManager.shared, firebaseStoreManager: FirebaseStorageManager.shared, vc: self)

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileFirstNameLabel: UILabel!
    @IBOutlet weak var profileLastNameLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBAction func profileButtonAction(_ sender: UIButton) {
//        let index = sender.tag
//        let user = searchViewModel?.friends[index]
    }
}
