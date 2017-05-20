//
//  DetailViewController.swift
//  Pods
//
//  Created by Taku Tran on 5/19/17.
//
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet var movieName: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    //@IBOutlet var movieYear: UILabel!
    @IBOutlet var imageBox: UIImageView!
    
    @IBOutlet var scrollView: UIScrollView!
    var movietitle: String = ""
    var imageURL: String = ""
    var year = Int()
    var score = Int()
    var descriptionSummary: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //movieName.text =
        // Do any additional setup after loading the view.
        movieName.text = movietitle + "(" + String(year) + ")"
        //imageBox.image = imageURL
        //scrollView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        descriptionLabel.sizeToFit()
        
        self.imageBox.kf.setImage(with: URL(string: imageURL), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            self.imageBox.image = image
        })
        
        descriptionLabel.text = descriptionSummary
        scoreLabel.text = String(score)
        //movieYear.text = String(year)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
