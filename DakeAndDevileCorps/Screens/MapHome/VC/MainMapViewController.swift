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
        searchBarView.entryPoint = .map
        return searchBarView
    }()
    
    let categoryView: CategoryView = {
        let categoryView = CategoryView(entryPoint: .map)
        return categoryView
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
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
        return view
    }()
    
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
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
        configureMapViewLayout()
        configureSearchBarViewLayout()
        configureCategoryViewLayout()
        configureCurrentLocationButtonLayout()
    }
    
    private func configureMapViewLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(mapView)
        mapView.constraint(
            top: (view.topAnchor, 0),
            leading: (safeArea.leadingAnchor, 0),
            bottom: (view.bottomAnchor, 0),
            trailing: (safeArea.trailingAnchor, 0)
        )
    }
    
    private func configureSearchBarViewLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(searchBarView)
        searchBarView.constraint(
            top: (safeArea.topAnchor, 8),
            leading: (safeArea.leadingAnchor, 16),
            trailing: (safeArea.trailingAnchor, -16)
        )
    }
    
    private func configureCategoryViewLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(categoryView)
        categoryView.constraint(
            top: (searchBarView.bottomAnchor, 0),
            leading: (safeArea.leadingAnchor, 0),
            trailing: (safeArea.trailingAnchor, 0),
            height: (nil, 60)
        )
    }
    
    private func configureCurrentLocationButtonLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(currentLocationButton)
        let currentLocationButtonConstraints = currentLocationButton.constraint(
            bottom: (view.bottomAnchor, -38),
            trailing: (safeArea.trailingAnchor, -20),
            width: (nil, 42),
            height: (currentLocationButton.widthAnchor, 0)
        )
        currentLocationButtonConstraints[.bottom]?.priority = .defaultLow
    }
    
    private func drawAnnotationViews() {
        mapView.addAnnotations(shops)
    }
    
    @objc
    func didPan(_ recognizer: UIPanGestureRecognizer) {
        let touchPoint = recognizer.location(in: view)
        switch recognizer.state {
        case .began:
            initialOffset = CGPoint(
                x: storeDetailModalView.frame.origin.x,
                y: touchPoint.y - storeDetailModalView.frame.origin.y
            )
            
        case .changed:
            storeDetailModalView.frame.origin = CGPoint(
                x: storeDetailModalView.frame.origin.x,
                y: touchPoint.y - initialOffset.y
            )
            
        case .ended, .cancelled:
            switch storeDetailModalView.mode {
            case .tip:
                if storeDetailModalView.frame.origin.y > self.view.frame.height - 75 {
                    storeDetailModalView.removeFromSuperview()
                    UIView.animate(
                        withDuration: 0.2,
                        animations: { [weak self] in
                            self?.currentLocationButton.transform = .identity
                        }
                    )
                }
                
                if storeDetailModalView.frame.origin.y > self.view.frame.height - 200 {
                    setModeOfStoreDetailModalView(to: .tip(screenViewFrame: self.view.frame))
                } else {
                    setModeOfStoreDetailModalView(to: .full(screenViewFrame: self.view.frame))
                }
                switch storeDetailModalView.mode {
                case .tip:
                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                    storeDetailModalView.frame = CGRect(
                        x: 0,
                        y: storeDetailModalView.mode.frame.minY,
                        width: storeDetailModalView.mode.frame.width,
                        height: fullFrame.height
                    )
                    
                    storeDetailViewController?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    storeDetailViewController?.closeStoreDetailButton.isHidden = true
                    
                case .full:
                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                    storeDetailModalView.frame = CGRect(
                        x: 0,
                        y: storeDetailModalView.mode.frame.minY,
                        width: storeDetailModalView.mode.frame.width,
                        height: fullFrame.height
                    )
                    storeDetailModalView.subviews.last?.frame = CGRect(
                        x: 0,
                        y: 0,
                        width: storeDetailModalView.mode.frame.width,
                        height: fullFrame.height
                    )
                    storeDetailViewController?.closeStoreDetailButton.isHidden = false
                }
            case .full:
                if storeDetailModalView.frame.origin.y > self.view.frame.height - 75 {
                    storeDetailModalView.removeFromSuperview()
                    UIView.animate(
                        withDuration: 0.2,
                        animations: { [weak self] in
                            self?.currentLocationButton.transform = .identity
                        }
                    )

                }
                
                if storeDetailModalView.frame.origin.y > 200 {
                    setModeOfStoreDetailModalView(to: .tip(screenViewFrame: self.view.frame))
                } else {
                    setModeOfStoreDetailModalView(to: .full(screenViewFrame: self.view.frame))
                }
                
                switch storeDetailModalView.mode {
                case .tip:
                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                    storeDetailModalView.frame = CGRect(
                        x: 0,
                        y: storeDetailModalView.mode.frame.minY,
                        width: storeDetailModalView.mode.frame.width,
                        height: fullFrame.height
                    )
                    
                    storeDetailViewController?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    
                    storeDetailViewController?.closeStoreDetailButton.isHidden = true
                case .full:
                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                    storeDetailModalView.frame = CGRect(
                        x: 0,
                        y: storeDetailModalView.mode.frame.minY,
                        width: storeDetailModalView.mode.frame.width,
                        height: fullFrame.height
                    )
                    storeDetailModalView.subviews.last?.frame = CGRect(
                        x: 0,
                        y: 0,
                        width: storeDetailModalView.mode.frame.width,
                        height: fullFrame.height
                    )
                    storeDetailViewController?.closeStoreDetailButton.isHidden = false
                }
            }
        default: break
        }
    }
    
    private func setModeOfStoreDetailModalView(to mode: CustomModalView.ModalMode) {
        switch mode {
        case .tip:
            storeDetailModalView.mode = .tip(screenViewFrame: self.view.frame)
            preventTouchView.isHidden = false
        case .full:
            storeDetailModalView.mode = .full(screenViewFrame: self.view.frame)
            preventTouchView.isHidden = true
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
        preventTouchView.constraint(to: storeDetailViewController.storeDetailTableView)
        
        storeDetailViewController.view.addSubview(indicatorView)
        indicatorView.constraint(
            top: (storeDetailViewController.view.topAnchor, 10),
            centerX: (storeDetailViewController.view.centerXAnchor, 0),
            width: (nil, 50),
            height: (nil, 5)
        )
        
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
