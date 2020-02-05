//
//  ViewController.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController, DataSubscription {
    
    func dataUpdated() {
        tableView.reloadData()
    }
    // should I move this variable to ViewModel?
    private let cellId = "1"
    private lazy var viewModel = PostsViewModel(delegate: self)
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        table.estimatedRowHeight = 200
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.fillContainer(layoutGuide: view.safeAreaLayoutGuide)
        viewModel.fetchPosts()
    }
}
extension PopularViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PostTableViewCell
        cell.setData(post: viewModel.posts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if viewModel.posts.count - 5 == indexPath.row {
            viewModel.fetchMore()
        }
    }
}
