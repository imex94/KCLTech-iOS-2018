//
//  MapViewController.swift
//  ExMap
//
//  Created by Alex Telek on 07/02/2018.
//  Copyright © 2018 KCLTech. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, LocationProviderDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let radius = 800
    
    private var model: DataModel?
    private var locationProvider = LocationProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        locationProvider.delegate = self
        locationProvider.provideLocation()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: TubeStationCollectionViewCell.identifier, bundle: Bundle.main), forCellWithReuseIdentifier: TubeStationCollectionViewCell.identifier)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            let padding = collectionView.frame.size.width/2 - flowLayout.itemSize.width/2
            collectionView.contentInset = UIEdgeInsets(top: 0.0, left: padding, bottom: 0.0, right: padding)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model?.stations.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TubeStationCollectionViewCell.identifier, for: indexPath)
        guard let stationCell = cell as? TubeStationCollectionViewCell else { return cell }
        
        stationCell.configure(model: model, at: indexPath)
        
        return stationCell
    }
    
    // MARK: - Location
    
    func didUpdateLocation(currentLocation: CLLocation) {
        
        fetchStations(at: (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude))
        setMapRegion(for: currentLocation)
    }
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "tube-pin")
        annotationView.animatesDrop = true
        
        return annotationView
    }
    
    // MARK: - Private methods
    
    private func fetchStations(at location: (Double, Double)) {
        
        TFLFetcher.fetchStations(at: location, radius: radius) { [weak self] (stations) in
            
            self?.addAnnotations(for: stations)
            
            TFLFetcher.fetchArrivalTubes(for: stations, handler: { [weak self] (model) in
                
                self?.model = model
                self?.collectionView.reloadData()
            })
        }
    }
    
    private func setMapRegion(for location: CLLocation) {
        
        let mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(mapRegion, animated: true)
    }
    
    private func addAnnotations(for stations: [Station]) {
        
        let annotations = stations.map { (station) -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: station.lat, longitude: station.lon)
            return annotation
        }
        
        mapView.addAnnotations(annotations)
    }
}
