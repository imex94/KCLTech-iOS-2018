//
//  MapViewController.swift
//  ExMap
//
//  Created by Alex Telek on 07/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: TubeStationCollectionViewCell.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: TubeStationCollectionViewCell.identifier)
        
        fetchStations()
        fetchArrivalTrains()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let padding = collectionView.frame.size.width/2 - flowLayout.itemSize.width/2
            collectionView.contentInset = UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: padding)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TubeStationCollectionViewCell.identifier, for: indexPath)
        guard let stationCell = cell as? TubeStationCollectionViewCell else { return cell }
        
        return stationCell
    }
    
    // Private methods
    
    private func fetchStations() {
        
        TFLFetcher.fetchStations(at: (51.512067, -0.116733)) { (response) in
            
            print(response)
        }
    }
    
    private func fetchArrivalTrains() {
        
        TFLFetcher.fetchArrivalTrains(for: "940GZZLUTMP") { (response) in
            
            print(response)
        }
    }
}
