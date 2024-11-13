//
//  CollectionViewCell.swift
//  UnsplashPhotosApp
//
//  Created by Asset on 11/13/24.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    private var networkingManager = NetworkingManager()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    static var identifier = "ButtonCellIdentifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        networkingManager.delegate = self
        networkingManager.fetchImage()
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

extension PhotoCell: PhotoDataDelegate {
    func uploadPhotoURL(_ imageURL: String) {
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self, let data = data, error == nil,
                      let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }.resume()
        }
    }
}
