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
    private let fetcher: DataFetcher
    private weak var delegate: DataSubscription?
    
    var posts = [PostData]() {
        didSet {
            DispatchQueue.main.async { [ weak self ] in
                self?.delegate?.dataUpdated()
            }
        }
    }
    
    init(delegate: DataSubscription, fetcher: DataFetcher) {
        self.delegate = delegate
        self.fetcher = fetcher
    }
    
    private func decodeToPostData(data: Data?) -> NetworkError? {
        guard let data = data else { return .badData }
        if let postsData = jsonParser.decodeToPostData(data: data){
            posts += postsData
            return nil
        }
        return .badData
    }
    
    func fetchPosts(){
        fetcher.fetch(urlString: "https://api.reddit.com/r/\(subreddit)?limit=\(fetchLimit)") { [ weak self ] (data, error)  in
            self?.handleFetchResult(data: data, error: error)
        }
    }
    
    func fetchMore(){
        guard let name = posts.last?.name else { return }
        let redditUrlString = "https://api.reddit.com/r/\(subreddit)?&after=\(name)&limit=\(fetchLimit)"
        fetcher.fetch(urlString: redditUrlString) { [weak self] (data, error) in
            self?.handleFetchResult(data: data, error: error)
        }
    }
    
    private func handleFetchResult(data: Data?, error: NetworkError?){
        if let err = error {
            showError(error: err)
        } else if let err = decodeToPostData(data: data){
            showError(error: err)
        }
    }
    
    private func showError(error: NetworkError){
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.errorThrown(error: error)
        }
    }
    
}
