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
    
    func fetchPictureDataFromAPI(completionHandler: @escaping ([PictureData]) -> Void) {
        guard let request = try? makeRequest(from: "https://picsum.photos/v2/list") else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let pictures = try self.parseResponse(data: data)
                completionHandler(pictures)
            } catch let e {
                print("Error parsing data: \(e.localizedDescription)")
            }
        }.resume()
    }
}

protocol APIRequest {
    func makeRequest(from urlString: String) throws -> URLRequest
    func parseResponse(data: Data) throws -> [PictureData]
}

enum RequestError: Error{
    case invalidUrl
}
