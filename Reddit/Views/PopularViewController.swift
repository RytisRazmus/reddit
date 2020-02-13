//
//  ViewController.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController, DataSubscription {
    
    private let cellId = "1"
    private let client = APIClient()
    private lazy var viewModel = PostsViewModel(delegate: self, fetcher: client)
    private let fetchMoreIndex = 5
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(PostTableViewCell.self, forCellReuseIdentifier: cellId)
        table.estimatedRowHeight = 200
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.separatorStyle = .none
        table.delegate = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.fillContainer(layoutGuide: view.safeAreaLayoutGuide)
        viewModel.fetchPosts()
    }
    
    func errorThrown(error: NetworkError) {
        // handle error
        print(error.description)
    }
    
    func dataUpdated() {
        tableView.reloadData()
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
        if viewModel.posts.count - fetchMoreIndex == indexPath.row {
            viewModel.fetchMore()
        }
    }
}
