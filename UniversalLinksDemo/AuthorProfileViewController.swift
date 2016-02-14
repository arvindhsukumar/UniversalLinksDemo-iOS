//
//  AuthorProfileViewController.swift
//  UniversalLinksDemo
//
//  Created by Arvindh Sukumar on 14/02/16.
//  Copyright © 2016 Arvindh Sukumar. All rights reserved.
//

import UIKit

class AuthorProfileViewController: UIViewController {

    var authorID:Int!
    @IBOutlet weak var authorLabel: UILabel!
    @IBAction func viewBooks(sender: AnyObject) {
        self.performSegueWithIdentifier("booksListSegue", sender: self)
    }
    
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        containerView.hidden = true
        getAuthor(authorID)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getAuthor(authorID:Int){
        Just.get("\(kBaseURL)/authors/\(authorID).json",asyncCompletionHandler: {
            result in
            
            guard let authorInfo = result.json as? NSDictionary else {
                return
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if let name = authorInfo.valueForKey("name") as? String {
                    self.authorLabel.text = name
                    self.containerView.hidden = false
                }                
            })
        })

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "booksListSegue"{
            let destination = segue.destinationViewController as! BooksTableViewController
            destination.authorID = self.authorID
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
