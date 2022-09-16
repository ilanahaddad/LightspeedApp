//
//  MainViewController.swift
//  LightspeedApp
//
//  Created by Ilana Haddad on 2022-09-15.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var pictureTableView: UITableView!
    
    var allPictures = [FinalPicture]()
    var randomPictures = [FinalPicture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        pictureTableView.dataSource = self
        pictureTableView.delegate = self
        
        getPictureData()
    }
    
    private func getPictureData() {
        APIManager().getPictures { pictures in
            for pic in pictures {
                if let imageURL = URL(string: pic.download_url),
                   let data = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: data) {
                    let finalPic = FinalPicture(author: pic.author, image: image)
                    self.allPictures.append(finalPic)
                }
            }
        }
    }

    @IBAction func fetchRandomImagePressed(_ sender: UIButton) {
        let totalNumPictures = allPictures.count
        let randomNumber = Int.random(in: 0...(totalNumPictures-1))
        let randomPicture = allPictures[randomNumber]
        
        randomPictures.append(randomPicture)
        pictureTableView.reloadData()
    }
}

// MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomPictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pictureDataCell", for: indexPath) as! PictureTableViewCell
        
        let picture = randomPictures[indexPath.row]
        cell.authorValueLabel.text = picture.author
        cell.pictureImageView.image = picture.image
        
        return cell
    }
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
}
