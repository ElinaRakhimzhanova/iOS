////
////  MapViewController.swift
////  vocabulary
////
////  Created by Elina on 12/5/19.
////  Copyright © 2019 KBTU. All rights reserved.
////
//
//import UIKit
//import GoogleMaps
//
//class MapViewController: UIViewController {
//
//
//    lazy var mapView: GMSMapView = {
//        let cameraPosition = GMSCameraPosition(latitude: 43.238643, longitude: 76.933594, zoom: 13)
//        let view = GMSMapView(frame: .zero, camera: cameraPosition)
//        view.delegate = self as! GMSMapViewDelegate
//
//        return view
//    }()
//
//    private func printMapData() {
//        let request = NSFetchRequest<Place>(entityName: "Place")
//        do {
//            let data = try AppDelegate.persistentContainer.viewContext.fetch(request)
//
//            print("$$$$$$$$$$$$$$$$$$$$$$")
//            print(data.map { "\($0.longitude) \($0.latitude)" })
//            print("$$$$$$$$$$$$$$$$$$$$$$")
//        } catch {
//            print(error)
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        printMapData()
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    private func markup() {
//        view.backgroundColor = .red
//
//        [mapView].forEach { view.addSubview($0) }
//
//        mapView.snp.makeConstraints() {
//            $0.edges.equalToSuperview()
//        }
//    }
//}
//
//extension ViewController: GMSMapViewDelegate {
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        let place = Place(context: AppDelegate.persistentContainer.viewContext)
//        place.latitude = coordinate.latitude
//        place.longitude = coordinate.longitude
//        try? AppDelegate.persistentContainer.viewContext.save()
//
//        print("\(coordinate.longitude) \(coordinate.latitude)")
//    }
//}
