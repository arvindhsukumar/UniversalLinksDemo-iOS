//
//  AuthorsTableViewController.swift
//  UniversalLinksDemo
//
//  Created by Arvindh Sukumar on 14/02/16.
//  Copyright © 2016 Arvindh Sukumar. All rights reserved.
//

import UIKit

let kAuthorCellIdentifier = "AuthorCell"

class AuthorsTableViewController: UITableViewController {

    var authors: [Author] = []
    var selectedAuthor: Author?
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: kAuthorCellIdentifier)
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,30,30))
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        activityIndicator.hidesWhenStopped = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)

        loadAuthors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshData(){
        loadAuthors()
    }
    
    private func loadAuthors(){
        self.activityIndicator.startAnimating()
        
        Just.get("\(kBaseURL)/authors.json",asyncCompletionHandler: {
            result in
            
            
            
            guard let authorsArray = result.json as? [NSDictionary] else {
                return
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.activityIndicator.stopAnimating()
                var authors:[Author] = []
                for authorInfo in authorsArray {
                    let name = authorInfo.valueForKey("name") as? String
                    let id = authorInfo.valueForKey("id") as? Int
                    
                    let author = Author(name: name, objectID: id)
                    authors.append(author)
                }
                
                self.authors = authors
                self.tableView.reloadData()

            })
        })
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return authors.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kAuthorCellIdentifier, forIndexPath: indexPath)

        // Configure the cell...
        let author = authors[indexPath.row]
        cell.textLabel?.text = author.name

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let author = authors[indexPath.row]
        selectedAuthor = author
        self.performSegueWithIdentifier("authorProfileSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "authorProfileSegue"{
            let destination = segue.destinationViewController as! AuthorProfileViewController
            destination.authorID = selectedAuthor?.objectID
        }
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
