//
//  MainViewController.swift
//  LightspeedApp
//
//  Created by Ilana Haddad on 2022-09-15.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var pictureTableView: UITableView!
    
    var allPictures = [PictureData]()
    var randomPictures = [PictureData]()
    var imagesForRandomPictures = [String:UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        pictureTableView.dataSource = self
        pictureTableView.delegate = self
        
        APIManager().getPictures { pictures in
            self.allPictures = pictures
        }
    }

    @IBAction func fetchRandomImagePressed(_ sender: UIButton) {
        let totalNumPictures = allPictures.count
        let randomNumber = Int.random(in: 0...(totalNumPictures-1))
        let randomPicture = allPictures[randomNumber]
        
        // Load image for that random picture and store it in dictionary
        if let imageURL = URL(string: randomPicture.download_url) {
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    imagesForRandomPictures["\(randomPictures.count)"] = image
                }
            }
        }
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
        cell.pictureImageView.image = imagesForRandomPictures["\(indexPath.row)"]
        return cell
    }
}

// MARK: UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
}
