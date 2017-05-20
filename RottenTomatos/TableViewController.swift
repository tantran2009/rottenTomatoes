//
//  TableViewController.swift
//  RottenTomatos
//
//  Created by Taku Tran on 5/16/17.
//  Copyright © 2017 Taku Tran. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewController: UITableViewController, UISearchBarDelegate{
    
    var movies = [Movie]()
    
    var nameArray = [String]()
    var imageArray = [String]()
    var scoreArray = [Int]()
    var yearArray = [Int]()
    var descriptionArray = [String]()
    var maapRatingArray = [String]()
    var runtimeArray = [Int]()
    
    var filterData = [String]()
    var filterImangeData = [String]()
    var filterScoreData = [String]()
    var filterDescriptionArray = [String]()
    var filterMaapRatingArray = [String]()
    var filterRuntimeArray = [String]()
    
    var isSearching = false
    
    @IBOutlet var searchBar: UISearchBar!
    
    /*var filterMovies = [Movie]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func filterContentForSearchText (searchText: String, scope: String = "ALL" ){
        filterMovies = nameArray.filter{ movie in
            return movie.model.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://coderschool-movies.herokuapp.com/movies?api_key=xja087zcvxljadsflh214")
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, Any> {
                if let movies = jsonObj?["movies"] as? [Any] {
                    for movie in movies {
                        if let movie = movie as? Dictionary<String, Any> {
                            if let name = movie["title"] as? String {
                                self.nameArray.append(name)
                            }
                            if let rating = movie["ratings"] as? Dictionary<String, Any> {
                                if let score = rating["critics_score"] as? Int {
                                    self.scoreArray.append(score)
                                }
                            }
                            if let poster = movie["posters"] as? Dictionary<String, Any> {
                                if let image = poster["detailed"] as? String {
                                    self.imageArray.append(image)
                                }
                            }
                            if let maaprating = movie["mpaa_rating"] as? String {
                                self.maapRatingArray.append(maaprating)
                            }
                            if let description = movie["synopsis"] as? String {
                                self.descriptionArray.append(description)
                            }
                            if let runtime = movie["runtime"] as? Int {
                                //let runtimeminute = runtime as? Int
                                self.runtimeArray.append(runtime)
                            }
                            if let year = movie["year"] as? Int {
                                //let runtimeminute = runtime as? Int
                                self.yearArray.append(year)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        })
        .resume()
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        /*searchController.searchResultsUpdater = self as! UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar*/
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        // Cai nay ko can, vi default la 1 roi
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if isSearching {
            return filterData.count
        }
        
        return nameArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewControllerCellTableViewCell
        
        /*let movie = movies[indexPath.row]
        cell?.movieName.text = movie.name
        cell?.rateLabel.text = String(movie.score)
        cell?.runtimeMin.text = String(movie.runtime)
        cell?.summary.text = movie.maapRating + "-" + movie.description
        let imageURL = URL(string: movie.imageURL)
        cell?.imageBox.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
            cell?.imageBox.image = image
        })*/

        
        
        if isSearching {
            cell?.movieName.text = filterData[indexPath.row]
        } else {
        
            cell?.movieName.text = nameArray[indexPath.row]
            cell?.rateLabel.text = String(scoreArray[indexPath.row])
            cell?.runtimeMin.text = String(runtimeArray[indexPath.row])
            cell?.summary.text = maapRatingArray[indexPath.row] + "-" + descriptionArray[indexPath.row]
            let imageURL = URL(string: imageArray[indexPath.row])
            cell?.imageBox.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cache, url) in
                cell?.imageBox.image = image
            })
        }
//        photoImageView.kf.setImage(with: group?.photoUrl, placeholder: nil, options: nil, progressBlock: nil) { (image, error, cach, url) in
//            self.photoImageView.image = image
//        }

        return cell!
    }
    
    func searchBar (_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filterData = nameArray.filter({$0 == searchBar.text})
            tableView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "Show Details":
                    let movieDetailVC = segue.destination as! DetailViewController
                    if let indexPath = self.tableView.indexPath (for: sender as! UITableViewCell){
                        movieDetailVC.movietitle = nameArray[indexPath.row]
                        movieDetailVC.imageURL = imageArray[indexPath.row]
                        movieDetailVC.descriptionSummary = descriptionArray[indexPath.row]
                        movieDetailVC.year = yearArray[indexPath.row]
                        movieDetailVC.score = scoreArray[indexPath.row]
                    }
                default: break
            }
        }
    }
       /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editinthe table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

