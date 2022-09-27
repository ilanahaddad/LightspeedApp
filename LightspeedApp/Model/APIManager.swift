//
//  APIManager.swift
//  LightspeedApp
//
//  Created by Ilana Haddad on 2022-09-16.
//

import Foundation

struct APIManager: APIRequest {
    func makeRequest(from urlString: String) throws -> URLRequest {
        guard let url = URL(string: urlString) else {
            throw RequestError.invalidUrl
        }
        return URLRequest(url: url)
    }

    func parseResponse(data: Data) throws -> [PictureData] {
        return try JSONDecoder().decode([PictureData].self, from: data)
    }
    
    func fetchPictureDataFromAPI(completionHandler: @escaping ([PictureData]?, Error?) -> Void) {
        guard let request = try? makeRequest(from: "https://picsum.photos/v2/list222") else {
            return
        }
//        guard let request = try? makeRequest(from: "https://picsum.photos/v2/list") else {
//            return
//        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let pictures = try self.parseResponse(data: data)
                completionHandler(pictures, nil)
            } catch let e {
                completionHandler(nil, e)
                print("Error parsing data: \(e.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchRandomImage(allPictures: [FinalPicture]) -> FinalPicture? {
        let totalNumPictures = allPictures.count
        if !allPictures.isEmpty {
            let randomNumber = Int.random(in: 0...(totalNumPictures-1))
            return allPictures[randomNumber]
        }
        return nil
    }
}

protocol APIRequest {
    func makeRequest(from urlString: String) throws -> URLRequest
    func parseResponse(data: Data) throws -> [PictureData]
}

enum RequestError: Error{
    case invalidUrl
}
