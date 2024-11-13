//
//  NetworkingManager.swift
//  UnsplashPhotosApp
//
//  Created by Asset on 11/13/24.
//

import Foundation
import UIKit

protocol PhotoDataDelegate {
    func uploadPhotoURL (_ imageURL: String)
}

struct NetworkingManager {
    
    var delegate: PhotoDataDelegate?
    
    let apiKey = "b3YV_nPjU8eMx7fXRy3HhBVoeI_4aFP2-Jp8HWx8Fa0"
    
    func fetchImage() {
        let urlString = "https://api.unsplash.com/photos/random/?client_id=\(apiKey)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                print(error!)
            }
            
            if let safeData = data {
                do {
                    let result = try JSONDecoder().decode(PhotoData.self, from: safeData)
                    let imageURL = result.urls.regular
                    delegate?.uploadPhotoURL(imageURL)
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        }
        task.resume()
    }
}
