//
//  PostViewModel.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import Foundation

class PostsViewModel {
    
    private let jsonParser = JSONParser()
    private let subreddit = "popular"
    private let fetchLimit = 20
    private let client = APIClient()
    private weak var delegate: DataSubscription?
    var posts = [PostData]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.dataUpdated()
            }
        }
    }
    
    init(delegate: DataSubscription) {
        self.delegate = delegate
    }
    
    private func decodeToPostData(data: Data?){
        guard let d = data else { return }
        if let p = jsonParser.decodeToPostData(d: d){
            posts += p
        }
    }
    
    func fetchPosts(){
        client.fetch(redditUrlString: "https://api.reddit.com/r/\(subreddit)?limit=\(fetchLimit)") { [weak self] (data) in
            self?.decodeToPostData(data: data)
        }
    }
    
    func fetchMore(){
        guard let name = posts.last?.name else { return }
        let redditUrlString = "https://api.reddit.com/r/\(subreddit)?&after=\(name)&limit=\(fetchLimit)"
        client.fetch(redditUrlString: redditUrlString) { [weak self] (data) in
            self?.decodeToPostData(data: data)
        }
    }
    
}
