//
//  ViewController.swift
//  CoreDataImage
//
//  Created by Vu on 5/7/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import UIKit
extension TableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

class TableViewController: UITableViewController  {
    var imageShow: [UIImage] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 800
        fetchObject()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchObject()
    }
    func fetchObject() {
        if let data = try? AppDelegate.context.fetch(Entity.fetchRequest()) as [Entity] {
            self.imageShow = data.map{ (($0.imageCoreData) as? UIImage ?? #imageLiteral(resourceName: "girl"))
            }
            self.tableView.reloadData()
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageShow.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.imageTableViewCell.image = imageShow[indexPath.row]
        return cell
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        //dat imageView der hien thi hinh anh
        let entity = Entity(context: AppDelegate.context)
        entity.imageCoreData = selectedImage
        AppDelegate.saveContext()
        self.fetchObject()
        tableView.reloadData()
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
}

