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
    private let subNameLabel = PostLabel(font: UIFont.boldSystemFont(ofSize: 14), alignment: .left)
    private let upvotesLabel = PostLabel(font: UIFont.systemFont(ofSize: 14), alignment: .center)
    private let commentsLabel = PostLabel(font: UIFont.systemFont(ofSize: 14), alignment: .center)
    private let timeLabel = PostLabel(font: UIFont.systemFont(ofSize: 14), alignment: .left)
    private let imageVideoView = ImageVideoView()
    private var postImageHeightConstraint = NSLayoutConstraint()
    private let noImageHeight: CGFloat = 0
    private let errorImage = UIImage(named: "error")
    private lazy var errorView  = ErrorView(errorMessage: "", errorImage: errorImage)
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAppearance()
        let padding: CGFloat = 8
        
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
        
        containerView.addSubview(subNameLabel)
        subNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding).isActive = true
        subNameLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
        subNameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding).isActive = true
        
        let authorMaxRightConstant: CGFloat = 70
        containerView.addSubview(authorLabel)
        authorLabel.topAnchor.constraint(equalTo: subNameLabel.bottomAnchor, constant: padding).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
        authorLabel.rightAnchor.constraint(lessThanOrEqualTo: containerView.rightAnchor, constant: -authorMaxRightConstant).isActive = true
        
        addSubview(timeLabel)
        timeLabel.leftAnchor.constraint(equalTo: authorLabel.rightAnchor, constant: 0).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        timeLabel.topAnchor.constraint(equalTo: authorLabel.topAnchor).isActive = true
        
        containerView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: padding).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding).isActive = true
        
        containerView.addSubview(imageVideoView)
        imageVideoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding).isActive = true
        postImageHeightConstraint = imageVideoView.heightAnchor.constraint(equalToConstant: noImageHeight)
        postImageHeightConstraint.isActive = true
        postImageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        imageVideoView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        imageVideoView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        
        containerView.addSubview(selfTextLabel)
        selfTextLabel.topAnchor.constraint(equalTo: imageVideoView.bottomAnchor, constant: padding).isActive = true
        selfTextLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
        selfTextLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding).isActive = true
        
        let bottomPadding: CGFloat = 12
        
        containerView.addSubview(upvotesLabel)
        upvotesLabel.topAnchor.constraint(equalTo: selfTextLabel.bottomAnchor, constant: padding).isActive = true
        upvotesLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding).isActive = true
        upvotesLabel.rightAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        upvotesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -bottomPadding).isActive = true
        
        containerView.addSubview(commentsLabel)
        commentsLabel.topAnchor.constraint(equalTo: selfTextLabel.bottomAnchor, constant: padding).isActive = true
        commentsLabel.leftAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        commentsLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding).isActive = true
        commentsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -bottomPadding).isActive = true
        
        containerView.addSubview(errorView)
        errorView.centerXAnchor.constraint(equalTo: imageVideoView.centerXAnchor).isActive = true
        errorView.centerYAnchor.constraint(equalTo: imageVideoView.centerYAnchor).isActive = true
    
    }
    
    private func setAppearance(){
        backgroundColor = UIColor(hexString: "#f5f0ec")
        self.selectionStyle = .none
        
        let postInfoColor = UIColor.gray//UIColor(hexString: "#8c8987")
        subNameLabel.textColor = postInfoColor
        authorLabel.textColor = postInfoColor
        timeLabel.textColor = postInfoColor
    }
    
    func setData(post: PostData){
        errorView.alpha = 0
        titleLabel.text = post.title
        authorLabel.text = "u/" + post.author + " • "
        selfTextLabel.text = post.selftext
        subNameLabel.text = "r/" + post.subreddit
        timeLabel.text = UnitConverter.convertTime(post.createdUtc)
        upvotesLabel.text = UnitConverter.convertToKs(post.score) + " ups"
        commentsLabel.text = UnitConverter.convertToKs(post.numComments) + " comments"
        
        guard let urlString = post.preview?.images.first?.source.url else { postImageHeightConstraint.constant = noImageHeight; return }
        setImageHeight(post: post)
        
        if let videoUrl = post.videoUrl {
            imageVideoView.setVideoView(urlString: videoUrl)
        } else {
            imageVideoView.setImageView(urlString: urlString)
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
