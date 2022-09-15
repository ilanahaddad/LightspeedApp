//
//  APIManager.swift
//  LightspeedApp
//
//  Created by Ilana Haddad on 2022-09-12.
//

import Foundation

class APIManager {
    func getPictures(completionHandler: @escaping ([PictureData]) -> Void) {
        if let url = URL(string: "https://picsum.photos/v2/list") {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let e = error {
                    print("Error accessing url: \(e.localizedDescription)")
                    return
                }
                if let data = data {
                    do {
                        let pictures = try JSONDecoder().decode([PictureData].self, from: data)
                        completionHandler(pictures)
                    } catch {
                        print("Error decodind data: \(error.localizedDescription)")
                    }
                }
            })
            task.resume()
        }
        
    }
}
