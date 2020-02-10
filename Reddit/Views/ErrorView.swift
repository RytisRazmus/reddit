//
//  ErrorView.swift
//  Reddit
//
//  Created by rytis razmus on 06/02/2020.
//  Copyright © 2020 rytis razmus. All rights reserved.
//

import UIKit

class ErrorView: UIView {

    private let errorLabel = PostLabel(font: .boldSystemFont(ofSize: 14), alignment: .center)
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(errorMessage: String, errorImage: UIImage?) {
        super.init(frame: .zero)
        backgroundColor = .red
        errorLabel.textColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
        errorLabel.text = errorMessage
        errorImageView.image = errorImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        let padding: CGFloat = 8
        let imageHeight: CGFloat = 30
        
        addSubview(errorImageView)
        errorImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        errorImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        errorImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        errorImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        addSubview(errorLabel)
        errorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: padding).isActive = true
        errorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        errorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
    
    }
    
}
