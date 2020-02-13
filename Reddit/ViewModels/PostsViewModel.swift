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
    private weak var fetcher: DataFetcher?
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
    
    func fetchPosts(){
        fetcher?.fetch(urlString: "https://api.reddit.com/r/\(subreddit)?limit=\(fetchLimit)") { [ weak self ] (data, error)  in
            self?.handleFetchResult(data: data, error: error)
        }
    }
    
    func fetchMore(){
        guard let name = posts.last?.name else { return }
        let redditUrlString = "https://api.reddit.com/r/\(subreddit)?&after=\(name)&limit=\(fetchLimit)"
        fetcher?.fetch(urlString: redditUrlString) { [weak self] (data, error) in
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
    
    private func decodeToPostData(data: Data?) -> NetworkError? {
        guard let data = data else { return .badData }
        if let postsData = jsonParser.decodeToPostData(data: data){
            postsData.forEach{
                $0.imageScaledHeight = $0.preview?.images.first?.calculateImageHeight()
                checkIsVideoOrGif(post: $0)
            }
            posts += postsData
            return nil
        }
        return .badData
    }
    // reddit does not have any node to identify if a post contains a video
    // they have a node is_video but it's always false
    // you have to look into the json and figure out the media type
    // also there's a possability I'm an idiot
    
    func checkIsVideoOrGif(post: PostData){
        if let mp4 = post.preview?.images.first?.variants?.mp4?.source.url {
            post.videoUrl = mp4.htmlDecoded
            return
        }
        
        if let fallbackUrl = post.preview?.redditVideo?.fallbackUrl {
            post.videoUrl = fallbackUrl
            return
        }
        // TODO: ADD youtube video player
        if let mediaDomainUrl = post.secureMediaEmbed?.mediaDomainUrl {
            post.videoUrl = mediaDomainUrl
            return
        }
        
        if let fallbackUrl = post.secureMedia?.redditVideo?.fallbackUrl {
            post.videoUrl = fallbackUrl
            return
        }
        checkGif(post: post)
    }
    
    // they also have is_gif node but it's not always accurate...
    
    private func checkGif(post: PostData){
        guard let url = post.url else { return }
        // .gifv is really .mp4
        if url.contains(".gifv"){
            post.videoUrl = url.replacingOccurrences(of: ".gifv", with: ".mp4")
            return
        }
        // TODO: add gif player
        if url.contains(".gif"){
            return
        }
    }
    
}

