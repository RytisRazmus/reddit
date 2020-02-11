//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    private let titleLabel = PostLabel(font: UIFont.boldSystemFont(ofSize: 20), alignment: .left)
    private let authorLabel = PostLabel(font: UIFont.systemFont(ofSize: 14), alignment: .left)
    private let selfTextLabel = PostLabel(font: UIFont.systemFont(ofSize: 14), alignment: .left)
    private let subNameLabel = PostLabel(font: UIFont.boldSystemFont(ofSize: 16), alignment: .left)
    private let upvotesLabel = PostLabel(font: UIFont.systemFont(ofSize: 14), alignment: .center)
    private let commentsLabel = PostLabel(font: UIFont.systemFont(ofSize: 14), alignment: .center)
    private let postImage = ImageLoadingView()
    private var postImageHeightConstraint = NSLayoutConstraint()
    private let padding: CGFloat = 8
    private let noImageHeight: CGFloat = 0
    private let errorImage = UIImage(named: "error")
    private lazy var errorView  = ErrorView(errorMessage: "", errorImage: errorImage)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        addSubview(subNameLabel)
        subNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        subNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        subNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        
        addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: subNameLabel.bottomAnchor, constant: padding).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: padding).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        
        addSubview(postImage)
        postImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding).isActive = true
        postImageHeightConstraint = postImage.heightAnchor.constraint(equalToConstant: noImageHeight)
        postImageHeightConstraint.isActive = true
        postImageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        postImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        postImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        addSubview(selfTextLabel)
        selfTextLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: padding).isActive = true
        selfTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        selfTextLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        
        addSubview(upvotesLabel)
        upvotesLabel.topAnchor.constraint(equalTo: selfTextLabel.bottomAnchor, constant: padding).isActive = true
        upvotesLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        upvotesLabel.rightAnchor.constraint(equalTo: centerXAnchor).isActive = true
        upvotesLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        
        addSubview(commentsLabel)
        commentsLabel.topAnchor.constraint(equalTo: selfTextLabel.bottomAnchor, constant: padding).isActive = true
        commentsLabel.leftAnchor.constraint(equalTo: centerXAnchor).isActive = true
        commentsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        commentsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        
        addSubview(errorView)
        errorView.centerXAnchor.constraint(equalTo: postImage.centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: postImage.centerYAnchor).isActive = true
    }
    
    func setData(post: PostData){
        errorView.alpha = 0
        titleLabel.text = post.title
        authorLabel.text = "u/" + post.author
        selfTextLabel.text = post.selftext
        subNameLabel.text = "r/" + post.subreddit
        upvotesLabel.text = UnitConverter.convertToKs(post.score) + " ups"
        commentsLabel.text = UnitConverter.convertToKs(post.numComments) + " comments"
        
        guard let urlString = post.preview?.images.first?.source.url else { postImageHeightConstraint.constant = noImageHeight; return }
        setImageHeight(post: post)
        postImage.loadImageWithUrl(urlString.htmlDecoded) { [weak self] (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorThrown(error: error)
                }
            }
        }
    }
    
    private func setImageHeight(post: PostData){
        if let imgHeight = post.imageScaledHeight{
            postImageHeightConstraint.constant = imgHeight
        }
    }
    
    private func errorThrown(error: NetworkError) {
        print(error)
        errorView.alpha = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
