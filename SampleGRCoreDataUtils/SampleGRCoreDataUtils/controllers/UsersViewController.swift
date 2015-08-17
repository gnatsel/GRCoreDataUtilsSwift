//
//  ViewController.swift
//  GRWebServiceManagerSample
//
//  Created by Gnatsel Revilo on 14/08/2015.
//  Copyright (c) 2015 Gnatsel Reivilo. All rights reserved.
//

import UIKit
import CoreData

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    private var usersFetchedResultsController:NSFetchedResultsController?;
    private var selectedIndexPath:NSIndexPath?;
    @IBOutlet weak var tableView:UITableView?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        usersFetchedResultsController = UserDAO.fetchedResultsControllerWithDelegate(delegate: self)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let identifier = segue.identifier{
            if(identifier == EDIT_USER_SEGUE){
                let editUserViewController:EditUserViewController = segue.destinationViewController as! EditUserViewController
                editUserViewController.currentUser = (usersFetchedResultsController!.objectAtIndexPath(selectedIndexPath!) as! User)
            }
        }
        
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersFetchedResultsController!.fetchedObjects!.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier(USER_TABLE_VIEW_CELL_IDENTIFIER, forIndexPath: indexPath) as! UITableViewCell
        cell.presenter!.configureWithEntity(entity: usersFetchedResultsController!.objectAtIndexPath(indexPath))
        return cell;
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            UserDAO.deleteUser(usersFetchedResultsController!.objectAtIndexPath(indexPath) as! User)
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath;
        self.performSegueWithIdentifier(EDIT_USER_SEGUE, sender: self)
    }
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView!.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if(controller == usersFetchedResultsController){
            switch type{
            case NSFetchedResultsChangeType.Insert:
                var indexPaths:[NSIndexPath] = [newIndexPath!]
                tableView!.insertRowsAtIndexPaths( indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                break;
            case NSFetchedResultsChangeType.Delete:
                var indexPaths:[NSIndexPath] = [indexPath!]
                tableView!.deleteRowsAtIndexPaths( indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
                break;
            case NSFetchedResultsChangeType.Update:
                if let cell:UITableViewCell = tableView!.cellForRowAtIndexPath(indexPath!){
                    cell.presenter!.configureWithEntity(entity: usersFetchedResultsController!.objectAtIndexPath(indexPath!))
                }
                break;
            case NSFetchedResultsChangeType.Move:
                var indexPaths:[NSIndexPath] = [indexPath!]
                tableView!.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
                break;
            default:
                break;
            }
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView!.endUpdates()
        if(self.view.window == nil){
            tableView!.reloadData()
        }
    }
    
    
}

