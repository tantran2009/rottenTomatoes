//
//  TableViewController.swift
//  RottenTomatos
//
//  Created by Taku Tran on 5/16/17.
//  Copyright © 2017 Taku Tran. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController{
    
    var nameArray = [String]()
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://coderschool-movies.herokuapp.com/movies?api_key=xja087zcvxljadsflh214")
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) -> Void in
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: <#T##JSONSerialization.ReadingOptions#>) as? NSDictionary{
                //print(jsonObj?.value(forKey: "movies"))
                if let movieArray = jsonObj?.value(forKey: "movies"){
                    for movie in movieArray{
                        if let movieDict = movie as? NSDictionary {
                            if let name = movie.value(forKey: "title"){
                                nameArray.append(name as! String)
                            }
                            if let name = movie.value(forKey: "thumbnail"){
                                imageArray.append(image as! String)
                            }
                            
                            OperationQueue.main.addOperation {
                                self.reloadData()
                            }
                        }
                    }
                }
            }
        })
        .resume()

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nameArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.movieName.text = nameArray[indexPath.row]
        return cell
    }
    
       /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
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
