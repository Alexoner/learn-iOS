//
//  MealViewController.swift
//  FoodTracker
//
//  Created by duhao.dh on 1/18/16.
//  Copyright © 2016 alex. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
    This value is either passed by `MealTableViewController` in `prepareForSegue(_:sender:)`
    or constructed as part of adding a new meal.
    */
    var meal: Meal?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Handle text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
        // set up views if editing an existing Meal.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // enable the save button only if the text field has a valid meal name
        checkValidMealName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITextFieldDelegate
    // called when user taps Return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // disable the save button while editing
        saveButton.enabled = false
    }
    
    func checkValidMealName() {
        // disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }

    func textFieldDidEndEditing(textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("image Picker canceled")
        // dismiss if user canceld
        dismissViewControllerAnimated(true, completion:nil)
    }

    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage]  as! UIImage
        // set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        // dismiss the picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            // when the detail scene was pushed onto the navigation stack on top of list scene
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // configure a view controller before it's presented
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }

    // MARK: Actions

    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        print("selectImageFromPhotoLibrary")
        // hide the keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
    
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    

}

