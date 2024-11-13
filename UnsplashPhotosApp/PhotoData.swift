//
//  PhotoData.swift
//  UnsplashPhotosApp
//
//  Created by Asset on 11/13/24.
//

import Foundation

struct PhotoData: Codable {
    let urls: PhotoURLs
}

struct PhotoURLs: Codable {
    let regular: String
}
