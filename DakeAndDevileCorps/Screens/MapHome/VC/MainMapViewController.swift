//
//  ViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import MapKit
import UIKit

class MainMapViewController: BaseViewController {
    
    // MARK: - subViews
    let searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.entryPoint = .map
        return searchBarView
    }()
    
    let categoryView: CategoryView = {
        let categoryView = CategoryView(entryPoint: .map)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    lazy var storeDetailModalView: CustomModalView = {
        let view = CustomModalView(mode: .tip(screenViewFrame: self.view.frame))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.addGestureRecognizer(panGesture)
        return view
    }()
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        return panGesture
    }()
    
    private lazy var preventTouchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .black
        button.addTarget(self, action: #selector(touchUpCurrentLocationButton), for: .touchUpInside)
        return button
    }()
    
    private var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 2
        return view
    }()
    
    // MARK: - properties
    lazy var shops: [StoreAnnotation] = {
        var category = StoreAnnotation.Category.zeroWasteShop
        return storeList.map { storeInfo in
            category = (category == .zeroWasteShop) ? .refillStation : .zeroWasteShop
            let annotation = StoreAnnotation(
                coordinate: CLLocationCoordinate2D(
                    latitude: storeInfo.latitude,
                    longitude: storeInfo.longitude
                ),
                sellingProductsCategory: [],
                category: category,
                store: storeInfo
            )
            annotation.title = storeInfo.name
            return annotation
        }
    }()
    
    private var initialOffset: CGPoint = .zero
    private var storeDetailViewController: StoreDetailViewController?
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManager()
        setMapView()
        setSearchBarView()
        setCategoryView()
        configureLayout()
        
        drawAnnotationViews()
    }
    
    // MARK: - func
    private func setLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    private func setMapView() {
        mapView.delegate = self
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationView.className)
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    private func setSearchBarView() {
        searchBarView.delegate = self
    }
    
    private func setCategoryView() {
        categoryView.delegate = self
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        
        view.addSubview(searchBarView)
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            searchBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(categoryView)
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor),
            categoryView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        view.addSubview(currentLocationButton)
        let currentButtonBottomConstraint = currentLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -38)
        currentButtonBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            currentLocationButton.widthAnchor.constraint(equalToConstant: 42),
            currentLocationButton.heightAnchor.constraint(equalTo: currentLocationButton.widthAnchor),
            
            currentLocationButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            currentButtonBottomConstraint
        ])
        
    }
    
    private func drawAnnotationViews() {
        mapView.addAnnotations(shops)
    }
    
    @objc
    func didPan(_ recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.location(in: view)
        switch recognizer.state {
        case .began:
            initialOffset = CGPoint(x: storeDetailModalView.frame.origin.x, y: touchPoint.y - storeDetailModalView.frame.origin.y)
        case .changed:
            storeDetailModalView.frame.origin = CGPoint(x: storeDetailModalView.frame.origin.x, y: touchPoint.y - initialOffset.y)
        case .ended, .cancelled:
            switch storeDetailModalView.mode {
            case .tip:
                if storeDetailModalView.frame.origin.y > self.view.frame.height - 75 {
                    storeDetailModalView.removeFromSuperview()
                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
                        self?.currentLocationButton.transform = .identity
                    })

                }
                
                if storeDetailModalView.frame.origin.y > self.view.frame.height - 200 {
                    storeDetailModalView.mode = .tip(screenViewFrame: self.view.frame)
                    preventTouchView.isHidden = false

                } else {
                    storeDetailModalView.mode = .full(screenViewFrame: self.view.frame)
                    preventTouchView.isHidden = true
                }
                switch storeDetailModalView.mode {
                case .tip:
                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                    storeDetailModalView.frame = CGRect(x: 0,
                                                        y: storeDetailModalView.mode.frame.minY,
                                                        width: storeDetailModalView.mode.frame.width,
                                                        height: fullFrame.height)
                    
                    storeDetailViewController?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    
                    storeDetailViewController?.closeStoreDetailButton.isHidden = true
                case .full:
                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                    storeDetailModalView.frame = CGRect(x: 0,
                                                        y: storeDetailModalView.mode.frame.minY,
                                                        width: storeDetailModalView.mode.frame.width,
                                                        height: fullFrame.height)
                    storeDetailModalView.subviews.last?.frame = CGRect(x: 0,
                                                                       y: 0,
                                                                       width: storeDetailModalView.mode.frame.width,
                                                                       height: fullFrame.height)
                    storeDetailViewController?.closeStoreDetailButton.isHidden = false
                }
            case .full:
                if storeDetailModalView.frame.origin.y > self.view.frame.height - 75 {
                    storeDetailModalView.removeFromSuperview()
                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
                        self?.currentLocationButton.transform = .identity
                    })

                }
                
                if storeDetailModalView.frame.origin.y > 200 {
                    storeDetailModalView.mode = .tip(screenViewFrame: self.view.frame)
                    preventTouchView.isHidden = false

                } else {
                    storeDetailModalView.mode = .full(screenViewFrame: self.view.frame)
                    preventTouchView.isHidden = true
                }
                
                switch storeDetailModalView.mode {
                case .tip:
                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                    storeDetailModalView.frame = CGRect(x: 0,
                                                        y: storeDetailModalView.mode.frame.minY,
                                                        width: storeDetailModalView.mode.frame.width,
                                                        height: fullFrame.height)
                    
                    storeDetailViewController?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    
                    storeDetailViewController?.closeStoreDetailButton.isHidden = true
                case .full:
                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                    storeDetailModalView.frame = CGRect(x: 0,
                                                        y: storeDetailModalView.mode.frame.minY,
                                                        width: storeDetailModalView.mode.frame.width,
                                                        height: fullFrame.height)
                    storeDetailModalView.subviews.last?.frame = CGRect(x: 0,
                                                                       y: 0,
                                                                       width: storeDetailModalView.mode.frame.width,
                                                                       height: fullFrame.height)
                    storeDetailViewController?.closeStoreDetailButton.isHidden = false
                }
            }
        default: break
        }
    }
    
    @objc
    func touchUpCurrentLocationButton() {
        mapView.showsUserLocation.toggle()
        mapView.setUserTrackingMode(.follow, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
extension MainMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentLocation = locationManager.location
        }
        let currentLocation = locations[locations.count-1]
        let currentLatitude = currentLocation.coordinate.latitude
        let currentLongitude = currentLocation.coordinate.longitude
         
        UserDefaultHandler.setCurrentLatitude(currentLatitude: String(currentLatitude))
        UserDefaultHandler.setCurrentLongitude(currentLongitude: String(currentLongitude))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
}

// MARK: - MapViewDelegate
extension MainMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let _ = annotation as? MKUserLocation {
            return MKUserLocationView()
        }
        
        guard let marker = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView.className) as? AnnotationView else {
            return AnnotationView()
        }
        
        return marker
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.view.addSubview(storeDetailModalView)
        UIView.animate(withDuration: 0.03, animations: { [weak self] in
            self?.currentLocationButton.transform = CGAffineTransform(translationX: 0, y: -130)
        })
        
        storeDetailViewController = UIStoryboard(name: "StoreDetail", bundle: nil).instantiateViewController(withIdentifier: StoreDetailViewController.className) as? StoreDetailViewController
        storeDetailViewController?.delegate = self
        guard let annotation = view.annotation as? StoreAnnotation else { return }
        
        var index = 0
        
        for store in storeList {
            if store.longitude == annotation.store.longitude
                && store.latitude == annotation.store.latitude
                && store.name == annotation.store.name {
                break
            } else {
                index += 1
            }
        }
        
        storeDetailViewController?.dataIndex = index
        guard let storeDetailViewController = storeDetailViewController else { return }
        storeDetailModalView.addSubview(storeDetailViewController.view)
        storeDetailViewController.view.layer.cornerRadius = 20
        storeDetailViewController.view.frame = CGRect(x: 0, y: 0, width: storeDetailModalView.frame.width, height: self.view.frame.height)
        storeDetailViewController.view.addSubview(preventTouchView)
        NSLayoutConstraint.activate([
            preventTouchView.topAnchor.constraint(equalTo: storeDetailViewController.storeDetailTableView.topAnchor),
            preventTouchView.bottomAnchor.constraint(equalTo: storeDetailViewController.storeDetailTableView.bottomAnchor),
            preventTouchView.leadingAnchor.constraint(equalTo: storeDetailViewController.storeDetailTableView.leadingAnchor),
            preventTouchView.trailingAnchor.constraint(equalTo: storeDetailViewController.storeDetailTableView.trailingAnchor)
        ])
        storeDetailViewController.view.addSubview(indicatorView)
        indicatorView.constraint(top: storeDetailViewController.view.topAnchor,
                                 centerX: storeDetailViewController.view.centerXAnchor,
                                 padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        indicatorView.constraint(indicatorView.heightAnchor, constant: 5)
        indicatorView.constraint(indicatorView.widthAnchor, constant: 50)
        
        storeDetailViewController.closeStoreDetailButton.isHidden = true
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.storeDetailModalView.removeFromSuperview()
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.currentLocationButton.transform = .identity
        })
        storeDetailModalView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
}

// MARK: - SearchBarDelegate
extension MainMapViewController: SearchBarDelegate {
    @objc func didBeginEditing() {
        view.endEditing(true)
        
        let nextViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: SearchViewController.className)
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: false)
    }
    
    @objc func touchUpInsideLeftButton() {
        guard let nextViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: SearchViewController.className) as? SearchViewController else { return }
        nextViewController.isResultShowing = true
        nextViewController.searchBarView.text = searchBarView.text
        nextViewController.didReturnKeyInput()
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: false)
    }
}

// MARK: - CategoryCollectionViewDelegate
extension MainMapViewController: CategoryCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mapView.removeAnnotations(mapView.annotations)
        let categoryName = categoryView.categoryList[indexPath.row]

        shops.forEach { shop in
            var itemCategories: Set<String> = []
            shop.store.items.forEach { item in
                itemCategories.insert(item.category)
            }
            if itemCategories.contains(categoryName) {
                mapView.addAnnotation(shop)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        mapView.removeAnnotations(mapView.annotations)
        drawAnnotationViews()
    }
    
}

// MARK: - StoreDetailViewControllerDelegate
extension MainMapViewController: StoreDetailViewControllerDelegate {
    func setupButtonAction(closeButton: UIButton) {
        self.storeDetailModalView.mode = .tip(screenViewFrame: self.view.frame)
        self.storeDetailModalView.frame = self.storeDetailModalView.mode.frame
        storeDetailViewController?.closeStoreDetailButton.isHidden = true
        storeDetailViewController?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        self.preventTouchView.isHidden = false
    }
    
    func setupViewWillDisappear(closeButton: UIButton) {
        
    }

}
