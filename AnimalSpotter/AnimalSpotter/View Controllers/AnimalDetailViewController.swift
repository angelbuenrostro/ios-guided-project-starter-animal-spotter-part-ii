//
//  AnimalDetailViewController.swift
//  AnimalSpotter
//
//  Created by Ben Gohlke on 6/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var timeSeenLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var animalImageView: UIImageView!
    
    var animalName: String?
    var apiController: APIController?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetails()

    }
    
    func getDetails() {
        guard let apiController = apiController,
            let animalName = animalName else { return }
        apiController.fetchDetails(for: animalName) { (result) in
            if let animal = try? result.get() {
                DispatchQueue.main.async {
                    self.updateViews(with: animal)
                }
                //fetch image for animal
            }
        }
    }
    
    func updateViews(with animal: Animal) {
        title = animal.name
        descriptionLabel.text = animal.description
        coordinatesLabel.text = "lat: \(animal.latitude), long: \(animal.longitude)"
        
        // Convert date to a string format
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        timeSeenLabel.text = df.string(from: animal.timeSeen)
    }
}
