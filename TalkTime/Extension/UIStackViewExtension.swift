//
//  UIStackViewExtension.swift
//  TalkTime
//
//  Created by Talor Levy on 3/11/23.
//

import UIKit


extension UIStackView {
    
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
//    func refreshPosts(posts: [PostModel]) {
//        self.removeAllArrangedSubviews()
//        for post in posts {
//            let view = UIView()
//            view.backgroundColor = .orange
//            view.translatesAutoresizingMaskIntoConstraints = false
//
//            let descriptionLabel = UILabel()
//            descriptionLabel.text = post.description
//            descriptionLabel.numberOfLines = 0
//            descriptionLabel.textAlignment = .left
//            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//
//            view.addSubview(descriptionLabel)
//            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
//            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
//
//            ImageProvider.shared.fetchImage(url: post.imageURL) { image in
//                if let image = image {
//                    DispatchQueue.main.async {
//                        let imageView = UIImageView(image: image)
//                        imageView.contentMode = .scaleAspectFill
//                        imageView.translatesAutoresizingMaskIntoConstraints = false
//                        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
//
//                        view.addSubview(imageView)
//                        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//                        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//                        imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
//                        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//
//                        descriptionLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10).isActive = true
//                    }
//                }
//            } else {
//                descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
//            }
//            self.addArrangedSubview(view)
//        }
//    }
    
    func refreshPosts(posts: [PostModel]) {
        self.removeAllArrangedSubviews()
        for post in posts {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.translatesAutoresizingMaskIntoConstraints = false
            
            let profileView = UIView()
            profileView.backgroundColor = .white
            profileView.translatesAutoresizingMaskIntoConstraints = false
            
            let profileImageView = UIImageView(image: UIImage(systemName: "person.fill"))
            profileImageView.contentMode = .scaleAspectFill
            profileImageView.layer.cornerRadius = 25
            profileImageView.layer.masksToBounds = true
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            profileView.addSubview(profileImageView)
            profileImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 10).isActive = true
            profileImageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
            
            let profileNameLabel = UILabel()
            profileNameLabel.text = post.username
            profileNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
            profileView.addSubview(profileNameLabel)
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
            profileNameLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
            profileNameLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -10).isActive = true
            
            view.addSubview(profileView)
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            profileView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            profileView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            
            if let profileImageURL = post.userProfilePictureUrl {
                ImageProvider.shared.fetchImage(url: profileImageURL) { image in
                    if let image = image {
                        DispatchQueue.main.async {
                            profileImageView.image = image
                        }
                    }
                }
            }
            
            let postImageView = UIImageView()
            postImageView.contentMode = .scaleAspectFill
            postImageView.clipsToBounds = true
            postImageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(postImageView)
            postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            postImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            postImageView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10).isActive = true
            postImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
            
            if let imageUrl = post.imageUrl {
                ImageProvider.shared.fetchImage(url: imageUrl) { image in
                    if let image = image {
                        DispatchQueue.main.async {
                            postImageView.image = image
                        }
                    }
                }
            }
            
            let actionView = UIView()
            actionView.backgroundColor = .white
            actionView.translatesAutoresizingMaskIntoConstraints = false
            
            let likeButton = UIButton()
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .red
            likeButton.translatesAutoresizingMaskIntoConstraints = false
            actionView.addSubview(likeButton)
            likeButton.leadingAnchor.constraint(equalTo: actionView.leadingAnchor, constant: 10).isActive = true
            likeButton.centerYAnchor.constraint(equalTo: actionView.centerYAnchor).isActive = true
            likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor).isActive = true
            
            let bookmarkButton = UIButton()
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            bookmarkButton.tintColor = .red
            bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
            actionView.addSubview(likeButton)
            bookmarkButton.leadingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: 10).isActive = true
            bookmarkButton.centerYAnchor.constraint(equalTo: actionView.centerYAnchor).isActive = true
            bookmarkButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            bookmarkButton.widthAnchor.constraint(equalTo: bookmarkButton.heightAnchor).isActive = true
            
            view.addSubview(actionView)
            actionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            actionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            actionView.topAnchor.constraint(equalTo: postImageView.bottomAnchor).isActive = true
            actionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            self.addArrangedSubview(view)
        }
    }
    
    
    
    func addPost(post: PostModel) {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let profileView = UIView()
        profileView.backgroundColor = .white
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        let profileImageView = UIImageView(image: UIImage(systemName: "person.fill"))
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 25
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(profileImageView)
        profileImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 10).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        let profileNameLabel = UILabel()
        profileNameLabel.text = post.username
        profileNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(profileNameLabel)
        profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        profileNameLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
        profileNameLabel.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -10).isActive = true
        
        view.addSubview(profileView)
        profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        profileView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        if let profileImageURL = post.userProfilePictureUrl {
            ImageProvider.shared.fetchImage(url: profileImageURL) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        profileImageView.image = image
                    }
                }
            }
        }
        
        let postImageView = UIImageView()
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postImageView)
        postImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        postImageView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        if let imageUrl = post.imageUrl {
            ImageProvider.shared.fetchImage(url: imageUrl) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        postImageView.image = image
                    }
                }
            }
        }
        
        let actionView = UIView()
        actionView.backgroundColor = .white
        actionView.translatesAutoresizingMaskIntoConstraints = false
        
        let likeButton = UIButton()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .red
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        actionView.addSubview(likeButton)
        likeButton.leadingAnchor.constraint(equalTo: actionView.leadingAnchor, constant: 10).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: actionView.centerYAnchor).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor).isActive = true
        
        let bookmarkButton = UIButton()
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .red
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        actionView.addSubview(likeButton)
        bookmarkButton.leadingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: 10).isActive = true
        bookmarkButton.centerYAnchor.constraint(equalTo: actionView.centerYAnchor).isActive = true
        bookmarkButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bookmarkButton.widthAnchor.constraint(equalTo: bookmarkButton.heightAnchor).isActive = true
        
        view.addSubview(actionView)
        actionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        actionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        actionView.topAnchor.constraint(equalTo: postImageView.bottomAnchor).isActive = true
        actionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        insertArrangedSubview(view, at: 0)
    }
    
    

    
//    func addPost(post: PostModel) {
//        let postView = UIView()
//        postView.backgroundColor = .orange
//        postView.translatesAutoresizingMaskIntoConstraints = false
//
//        let descriptionLabel = UILabel()
//        descriptionLabel.text = post.description
//        descriptionLabel.numberOfLines = 0
//        descriptionLabel.textAlignment = .left
//        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        postView.addSubview(descriptionLabel)
//        descriptionLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 10).isActive = true
//        descriptionLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -10).isActive = true
//        descriptionLabel.topAnchor.constraint(equalTo: postView.topAnchor, constant: 10).isActive = true
//
//        if let imageURL = post.imageURL {
//            ImageProvider.shared.fetchImage(url: imageURL) { image in
//                if let image = image {
//                    DispatchQueue.main.async {
//                        let imageView = UIImageView(image: image)
//                        imageView.contentMode = .scaleAspectFill
//                        imageView.translatesAutoresizingMaskIntoConstraints = false
//                        imageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
//
//                        postView.addSubview(imageView)
//                        imageView.leadingAnchor.constraint(equalTo: postView.leadingAnchor).isActive = true
//                        imageView.trailingAnchor.constraint(equalTo: postView.trailingAnchor).isActive = true
//                        imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
//                        imageView.bottomAnchor.constraint(equalTo: postView.bottomAnchor).isActive = true
//
//                        descriptionLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10).isActive = true
//                    }
//                }
//            }
//        } else {
//            descriptionLabel.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -10).isActive = true
//        }
//        insertArrangedSubview(postView, at: 0)
//    }
}
