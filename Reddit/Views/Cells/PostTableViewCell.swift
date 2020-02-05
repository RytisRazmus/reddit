//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by rytis razmus on 04/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let viewModel = PostCellViewModel()
    private let postImage = ImageLoader()
    private var postImageHeightConstraint = NSLayoutConstraint()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(postImage)
        postImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        postImageHeightConstraint = postImage.heightAnchor.constraint(equalToConstant: 0)
        postImageHeightConstraint.isActive = true
        postImageHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        postImage.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        postImage.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: postImage.topAnchor, constant: -8).isActive = true
        
    }
    
    func setData(post: PostData){
        titleLabel.text = post.title
        guard  let images = post.preview?.images,
            let urlString = post.preview?.images.first?.source.url else { postImageHeightConstraint.constant = 0; return }
        postImage.loadImageWithUrl(String(htmlEncodedString: urlString), completion: nil)
        guard let imgHeight = post.imageScaledHeight else {
            let h = viewModel.calculateImageHeight(images.first?.source.width, images.first?.source.height)
            postImageHeightConstraint.constant = h
            post.imageScaledHeight = h
            return }
        postImageHeightConstraint.constant = imgHeight
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
