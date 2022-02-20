//
//  detailViewController.swift
//  postsApp
//
//  Created by Camilo Orjuela on 19/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        viewModel?.getDetailPost()
        
        if viewModel?.post.favorite ?? false {
            favoriteButton.image = UIImage(named: "fullFavorite")
        } else {
            favoriteButton.image = UIImage(named: "emptyFavorite")
        }
        
        commentsTable.dataSource = self
    }
    
    private func setupBinding() {
        
        viewModel?.loading = { [weak self] isLoading in
            
            if isLoading {
                self?.showLoader()
            } else {
                self?.removeLoader()
            }
        }
        
        viewModel?.onGetPost = { [weak self] in
            
            self?.setupPostView()
            self?.commentsTable.reloadData()
        }
    }
    
    private func setupPostView() {
        
        descriptionLabel.text = viewModel?.post.body
        nameLabel.text = viewModel?.userPost?.name
        emailLabel.text = viewModel?.userPost?.email
        phoneLabel.text = viewModel?.userPost?.phone
        websiteLabel.text = viewModel?.userPost?.website
        
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        viewModel?.updateFavorite()
        
        if viewModel?.post.favorite ?? false {
            favoriteButton.image = UIImage(named: "fullFavorite")
        } else {
            favoriteButton.image = UIImage(named: "emptyFavorite")
        }
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        viewModel?.deletePost()
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.comments.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = viewModel?.comments[indexPath.row].body
        cell.textLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        return cell
    }
}

