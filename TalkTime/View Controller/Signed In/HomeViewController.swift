//
//  HomeViewController.swift
//  FirebaseProjectV2
//
//  Created by Talor Levy on 2/28/23.
//

import UIKit
import FirebaseAuth


class HomeViewController: UIViewController {
        
    var homeViewModel: HomeViewModel?
    
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var postStackView: UIStackView!
    
    
    //MARK: - override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeViewModel()
        fetchAllPosts()
    }
    
    
    //MARK: - functions
    
    func configureHomeViewModel() {
        homeViewModel = HomeViewModel(firebaseDBManager: FirebaseDatabaseManager.shared, firebaseStoreManager: FirebaseStorageManager.shared, vc: self)
    }
    
    func fetchAllPosts() {
        homeViewModel?.fetchAllPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success():
                DispatchQueue.main.async {
                    print("Success fetching all posts at HomeViewController")
                    self.refreshPosts()
                }
            case .failure(let error):
                print("Error fetching all posts at HomeViewController: \(error.localizedDescription)")
            }
        }
    }
    
    func refreshPosts() {
        postStackView.removeAllArrangedSubviews()
        guard let posts = homeViewModel?.posts else { return }
        postStackView.refreshPosts(posts: posts)
    }
}


//MARK: - SendPost

extension HomeViewController: SendPost {
    func sendPostToHome(post: PostModel) {
        postStackView.addPost(post: post)
    }
}
