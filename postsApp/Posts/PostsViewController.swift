//
//  PostsViewController.swift
//  postsApp
//
//  Created by Camilo Orjuela on 19/02/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit


class PostsViewController: UIViewController {
    
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var optionsControl: UISegmentedControl!
    
    let viewModel = PostsViewModel ()
    var numberOfSections = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        viewModel.getPosts()
        setupTable()
        optionsControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if optionsControl.selectedSegmentIndex == 0 {
            viewModel.filterPosts(showFavorites: false)
        } else {
            viewModel.filterPosts(showFavorites: true)
        }
        postsTableView.reloadData()
    }
    
    private func setupTable() {
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "reuse")
    }
    
    @IBAction func deleteAllAction(_ sender: Any) {
        
        numberOfSections = 0
        let indexSet = IndexSet(integer: 0)
        postsTableView.deleteSections(indexSet, with: .top)
    }
    
    @IBAction func refreshButton(_ sender: Any) {
        
        numberOfSections = 1
        viewModel.getPosts()
        setupBindings()
    }
    
    
    private func setupBindings() {
        
        viewModel.loading = { [weak self] isLoading in
            
            if isLoading {
                self?.showLoader()
            } else {
                self?.removeLoader()
            }
        }
        
        viewModel.onGetPosts = { [weak self] in
            
            self?.postsTableView.reloadData()
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            viewModel.filterPosts(showFavorites: false)
            
        } else {
            viewModel.filterPosts(showFavorites: true)
        }
        postsTableView.reloadData()
    }
}

extension PostsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        
        cell.configure(post: viewModel.posts[indexPath.row])
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPost = viewModel.posts[indexPath.row]
        let detailViewModel = DetailViewModel(post: selectedPost)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            nextViewController.viewModel = detailViewModel
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
