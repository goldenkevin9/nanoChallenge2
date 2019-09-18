//
//  ViewController.swift
//  nanoChallenge2
//
//  Created by Golden Kevin on 17/09/19.
//  Copyright © 2019 Golden Kevin. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    @IBAction func onAddTapped() {
        let alert = UIAlertController(title: "Tambah Barangmu", message: nil, preferredStyle: .alert)
        alert.addTextField { (barangTF) in
            barangTF.placeholder = "Masukkan Barang"
        }
        let action = UIAlertAction(title: "Tambah", style: .default) { (_) in
            guard let barangAndaArrayy = alert.textFields?.first?.text else { return }
            print(barangAndaArrayy)
            self.barangAndaArray.append(barangAndaArrayy)
            self.myTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelAction)
        alert.addAction(action)
        present (alert, animated: true)
        
    }
    
//    var barangAndaArrayy: [NSManagedObject] = []
    //geofencing
    var locationManager = CLLocationManager()
    
    // tabel daftar barang
    var barangAndaArray = ["MacBook Pro", "USB C to Lightning", "USB-C to USB-C", "USB-A to Lightning", "Access Card", "Barang Pribadi Lainnya"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        myTableView.dataSource = self
        myTableView.delegate = self
        
        // Your coordinates go here (lat, lon)
        let geofenceRegionCenter = CLLocationCoordinate2D(
            latitude: -6.302032,
            longitude: 106.652220
        )
        
        /* Create a region centered on desired location,
         choose a radius for the region (in meters)
         choose a unique identifier for that region */
        let geofenceRegion = CLCircularRegion(
            center: geofenceRegionCenter,
            radius: 100,
            identifier: "UniqueIdentifier"
        )
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        self.locationManager.startMonitoring(for: geofenceRegion)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) ->Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barangAndaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel!.text = barangAndaArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return }
        barangAndaArray.remove (at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        //    func save(name: String) {
        //            guard let barangAndaArray = UIApplication.shared.delegate as? AppDelegate else {
        //                return
        //    }
        //
        //        func fetchAllExcercises(){
        //            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        //                return
        //            }
        //            /*Before you can do anything with Core Data, you need a managed object context. */
        //            let managedContext = barangAndaArray.persistentContainer.viewContext
        //
        //            /*As the name suggests, NSFetchRequest is the class responsible for fetching from Core Data.
        //
        //             Initializing a fetch request with init(entityName:), fetches all objects of a particular entity. This is what you do here to fetch all Person entities.
        //             */
        //            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Excercise")
        //
        //            /*You hand the fetch request over to the managed object context to do the heavy lifting. fetch(_:) returns an array of managed objects meeting the criteria specified by the fetch request.*/
        //            do {
        //                barangAndaArray = try managedContext.fetch(fetchRequest)
        //            } catch let error as NSError {
        //                print("Could not fetch. \(error), \(error.userInfo)")
        //            }
        //
        //        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    { if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark
    { tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        
    }
    else
    { tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark}
    }
}
