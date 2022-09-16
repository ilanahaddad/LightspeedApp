//
//  PictureData.swift
//  LightspeedApp
//
//  Created by Ilana Haddad on 2022-09-12.
//

import Foundation
import UIKit

struct PictureData: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
    
    init(id: String, author: String, width: Int, height: Int, url: String, download_url: String) {
        self.id = id
        self.author = author
        self.width = width
        self.height = height
        self.url = url
        self.download_url = url 
    }
}

struct FinalPicture {
    let author: String
    let image: UIImage
}
