//
//  MainViewController.swift
//  LightspeedApp
//
//  Created by Ilana Haddad on 2022-09-15.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var pictureTableView: UITableView!
    @IBOutlet weak var fetchButton: UIButton!
    
    var allPictures = [FinalPicture]()
    var randomPictures = [FinalPicture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureTableView.dataSource = self
        pictureTableView.delegate = self
        pictureTableView.accessibilityIdentifier = "pictureTableView"
        
//        fetchButton.isEnabled = false
        getPictureData()
    }
    
    private func getPictureData() {
        APIManager().fetchPictureDataFromAPI { pictures, error in
            if let e = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "\(e.localizedDescription)", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            if let pictures = pictures {
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
    }

    @IBAction func fetchRandomImagePressed(_ sender: UIButton) {
        if let randomPicture = APIManager().fetchRandomImage(allPictures: allPictures) {
            randomPictures.append(randomPicture)
        } else {
            let alert = UIAlertController(title: "No image to display. Please try again.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
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
