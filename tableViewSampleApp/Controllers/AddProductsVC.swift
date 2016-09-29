//
//  ViewController.swift
//  tableViewSampleApp
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import UIKit
import CoreData

class AddProductsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var cellIdentifier: String!
    var arrayProducts: [Products] = []
    
    @IBOutlet var tableViewObject: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let item = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(AddProductsVC.addProductsToList))
        self.navigationItem.rightBarButtonItem = item
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedObjectContext:NSManagedObjectContext = appDel.managedObjectContext

        let fetchRequest = NSFetchRequest.init(entityName:"Products")
        do{
            self.arrayProducts = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Products]
            self.tableViewObject.reloadData()
        }
        catch let error as NSError{
            print("Error Found \(error)!!")
        }
    }
    
    func  managedObjectContext() -> NSManagedObjectContext {
        var context = NSManagedObjectContext()
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if(delegate.performSelector(#selector(managedObjectContext)) != nil)
        {
            context = delegate.managedObjectContext
        }
        return context
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
         print(arrayProducts.count)
         return arrayProducts.count
       
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 130
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        cellIdentifier = "ProductDetailsTableViewCell"
        var productDetailsTableViewCell = (tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? ProductDetailsTableViewCell)
        
       if(productDetailsTableViewCell == nil)
       {
           let nib: NSArray = NSBundle.mainBundle().loadNibNamed(cellIdentifier, owner: self, options: nil)
            productDetailsTableViewCell = (nib .objectAtIndex(0) as? ProductDetailsTableViewCell)!
       }
        let saveProduct = self.arrayProducts[indexPath.row]
        productDetailsTableViewCell?.labelProductName.text = saveProduct.valueForKey("productName") as? String
        productDetailsTableViewCell?.labelProductPrice.text = saveProduct.valueForKey("productPrice") as? String
        return productDetailsTableViewCell!
    }
    
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(self.arrayProducts[indexPath.row])
            do{
                try context.save()
            } catch let error{
                print("Core Data error \(error)")
            }
            // remove the deleted item from the `UITableView`
            self.arrayProducts.removeAtIndex(indexPath.row)
            self.tableViewObject.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
            
        }
    }
    
    func addProductsToList() -> Void {
        print("Added")
        if let productsListVC = storyboard!.instantiateViewControllerWithIdentifier("ProductsListVC") as? ProductsListVC {
           self.navigationController!.pushViewController(productsListVC, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

