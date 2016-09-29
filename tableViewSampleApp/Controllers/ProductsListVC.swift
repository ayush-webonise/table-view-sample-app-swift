//
//  ProductsListVC.swift
//  tableViewSampleApp
//
//  Created by webonise on 28/09/16.
//  Copyright © 2016 webonise. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProductsListVC: UIViewController {
    var productsObject: Products!
    @IBOutlet var textFieldProductName: UITextField!
    @IBOutlet var textFieldProductPrice: UITextField!
    @IBOutlet var textFieldProductCategory: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /** This function checks for validations whether the user has added only whitespaces in the text field
     * \returns Returns YES if the names and prices are added correctly else returns NO
     */
    func isValid(isValidString: NSString) -> Bool {
        if(isValidString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).characters.count == 0)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    
    /** This function checks for validations whether the user has added only whitespaces in the text field
     * \returns Returns YES if the names and prices are added correctly else returns NO
     */
    func checkValidation() -> Void {
        if(!(self.isValid(textFieldProductName.text!)))
        {
            textFieldProductName.becomeFirstResponder()
        }
        else if(!(self.isValid(textFieldProductPrice.text!)))
        {
            textFieldProductPrice.becomeFirstResponder()
        }
        else if(!(self.isValid(textFieldProductCategory.text!)))
        {
            textFieldProductCategory.becomeFirstResponder()
        }
        else
        {
            self.addProduct()
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
    

/** This function adds product in the database. It checks for the object and updates it, else it inserts it into the database
 * \returns Nothing
 */
    func addProduct() -> Void {
        let context: NSManagedObjectContext = self.managedObjectContext()
        let newProduct: NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName("Products", inManagedObjectContext: context)
        newProduct.setValue(self.textFieldProductName.text, forKey: "productName")
        newProduct.setValue(self.textFieldProductPrice.text, forKey: "productPrice")
    
        do{
              try context.save()
            
        } catch let error{
               print("core data error \(error)")
            }
        self.navigationController!.popViewControllerAnimated(true)
    }
    
  
    /** It performs action when ADD button is pressed. Calls checkValidation method and UIAlertView
     * \param sender ID of ADD button
     */
    @IBAction func buttonAddPressed(sender: AnyObject) {
        self.checkValidation()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
