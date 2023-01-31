//
//  ResultMapViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/08/01.
//

import UIKit
import MapKit

class ResultMapViewController: BaseMapViewController {
        
    // MARK: - subViews
    let searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.entryPoint = .search
        return searchBarView
    }()
    
    var searchBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let categoryView: CategoryView = {
        let categoryView = CategoryView(entryPoint: .map)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    lazy var dismissResultButton: UIButton = {
        let button = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
            self.touchUpToDismissResult()
        }))
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.frame.size = CGSize(width: 20, height: 20)
        button.tintColor = .black
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 2
        return view
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
    lazy var storeDetailModalView: CustomModalView = {
        let view = CustomModalView(mode: .tip, superScreenViewFrame: self.view.frame)
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
    
    // MARK: - properties
    var shops: [StoreAnnotation] = []
    
    private var initialOffset: CGPoint = .zero
    private var detailVC: StoreDetailViewController?
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMapView()
        setSearchBarView()
        setCategoryView()
        
        drawAnnotationViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureLayout()
    }
    
    // MARK: - func
    private func setMapView() {
        mapView.delegate = self
        mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationView.className)
    }
    
    private func setSearchBarView() {
        searchBarView.delegate = self
    }
    
    private func setCategoryView() {
        categoryView.delegate = self
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(searchBarBackgroundView)
        NSLayoutConstraint.activate([
            searchBarBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            searchBarBackgroundView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            searchBarBackgroundView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            searchBarBackgroundView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        view.addSubview(searchBarView)
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 8),
            searchBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            searchBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -60)
        ])
        
        view.addSubview(dismissResultButton)
        NSLayoutConstraint.activate([
            dismissResultButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            dismissResultButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -14)
        ])
    }
    
    private func touchUpToDismissResult() {
        searchBarView.text = ""
        self.presentingViewController?.presentingViewController?.dismiss(animated: false)
    }
        
    private func drawAnnotationViews() {
        mapView.addAnnotations(shops)
    }
    
    func updateMapForCoordinate(coordinate: CLLocationCoordinate2D) {
        let camera = MKMapCamera(lookingAtCenter: coordinate, fromDistance: 2000, pitch: 0, heading: 0)
        mapView.setCamera(camera, animated: false)
        let center = coordinate
        mapView.setCenter(center, animated: true)
    }

    @objc
    func didPan(_ recognizer: UIPanGestureRecognizer) {
//        let touchPoint = recognizer.location(in: view)
//        switch recognizer.state {
//        case .began:
//            initialOffset = CGPoint(x: storeDetailModalView.frame.origin.x, y: touchPoint.y - storeDetailModalView.frame.origin.y)
//        case .changed:
//            storeDetailModalView.frame.origin = CGPoint(x: storeDetailModalView.frame.origin.x, y: touchPoint.y - initialOffset.y)
//        case .ended, .cancelled:
//            switch storeDetailModalView.mode {
//            case .tip:
//                if storeDetailModalView.frame.origin.y > self.view.frame.height - 75 {
//                    storeDetailModalView.removeFromSuperview()
//                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
////                        self?.currentLocationButton.transform = .identity
//                    })
//
//                }
//
//                if storeDetailModalView.frame.origin.y > self.view.frame.height - 200 {
//                    storeDetailModalView.mode = .tip(screenViewFrame: self.view.frame)
//                    preventTouchView.isHidden = false
//
//                } else {
//                    storeDetailModalView.mode = .full(screenViewFrame: self.view.frame)
//                    preventTouchView.isHidden = true
//                }
//                switch storeDetailModalView.mode {
//                case .tip:
//                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
//                    storeDetailModalView.frame = CGRect(x: 0,
//                                                        y: storeDetailModalView.mode.frame.minY,
//                                                        width: storeDetailModalView.mode.frame.width,
//                                                        height: fullFrame.height)
//
//                    detailVC?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//
//                    detailVC?.closeStoreDetailButton.isHidden = true
//                case .full:
//                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
//                    storeDetailModalView.frame = CGRect(x: 0,
//                                                        y: storeDetailModalView.mode.frame.minY,
//                                                        width: storeDetailModalView.mode.frame.width,
//                                                        height: fullFrame.height)
//                    storeDetailModalView.subviews.last?.frame = CGRect(x: 0,
//                                                                       y: 0,
//                                                                       width: storeDetailModalView.mode.frame.width,
//                                                                       height: fullFrame.height)
//                    detailVC?.closeStoreDetailButton.isHidden = false
//                }
//            case .full:
//                if storeDetailModalView.frame.origin.y > self.view.frame.height - 75 {
//                    storeDetailModalView.removeFromSuperview()
//                    UIView.animate(withDuration: 0.2, animations: { [weak self] in
////                        self?.currentLocationButton.transform = .identity
//                    })
//
//                }
//
//                if storeDetailModalView.frame.origin.y > 200 {
//                    storeDetailModalView.mode = .tip(screenViewFrame: self.view.frame)
//                    preventTouchView.isHidden = false
//
//                } else {
//                    storeDetailModalView.mode = .full(screenViewFrame: self.view.frame)
//                    preventTouchView.isHidden = true
//                }
//
//                switch storeDetailModalView.mode {
//                case .tip:
//                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
//                    storeDetailModalView.frame = CGRect(x: 0,
//                                                        y: storeDetailModalView.mode.frame.minY,
//                                                        width: storeDetailModalView.mode.frame.width,
//                                                        height: fullFrame.height)
//
//                    detailVC?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//
//                    detailVC?.closeStoreDetailButton.isHidden = true
//                case .full:
//                    let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
//                    storeDetailModalView.frame = CGRect(x: 0,
//                                                        y: storeDetailModalView.mode.frame.minY,
//                                                        width: storeDetailModalView.mode.frame.width,
//                                                        height: fullFrame.height)
//                    storeDetailModalView.subviews.last?.frame = CGRect(x: 0,
//                                                                       y: 0,
//                                                                       width: storeDetailModalView.mode.frame.width,
//                                                                       height: fullFrame.height)
//                    detailVC?.closeStoreDetailButton.isHidden = false
//                }
//            }
//        default: break
//        }
    }
}

// MARK: - MapViewDelegate
extension ResultMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let marker = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView.className) as? AnnotationView else {
            return AnnotationView()
        }
        marker.isSelected = true
        
        guard let annotation = annotation as? StoreAnnotation else {
            return marker
        }
        annotation.title = annotation.store.name
        return marker
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.view.addSubview(storeDetailModalView)
        storeDetailModalView.makeShadow(color: .lightGray, opacity: 0.5, offset: CGSize(width: 0, height: 3), radius: 15)
        
        detailVC = UIStoryboard(name: "StoreDetail", bundle: nil).instantiateViewController(withIdentifier: StoreDetailViewController.className) as? StoreDetailViewController
        detailVC?.delegate = self
        
        guard let annotation = view.annotation as? StoreAnnotation else { return }
        
        for store in storeList {
            if store.longitude == annotation.store.longitude
                && store.latitude == annotation.store.latitude
                && store.name == annotation.store.name {
                detailVC?.store = store
                break
            }
        }
        
        guard let detailVC = detailVC else { return }
        updateMapForCoordinate(coordinate: view.annotation?.coordinate ?? CLLocationCoordinate2D(latitude: 37.541, longitude: 126.986))
        storeDetailModalView.addSubview(detailVC.view)
        detailVC.view.layer.cornerRadius = 20
        detailVC.view.frame = CGRect(x: 0, y: 0, width: storeDetailModalView.frame.width, height: self.view.frame.height)
        detailVC.view.addSubview(preventTouchView)
        NSLayoutConstraint.activate([
            preventTouchView.topAnchor.constraint(equalTo: detailVC.storeDetailTableView.topAnchor),
            preventTouchView.bottomAnchor.constraint(equalTo: detailVC.storeDetailTableView.bottomAnchor),
            preventTouchView.leadingAnchor.constraint(equalTo: detailVC.storeDetailTableView.leadingAnchor),
            preventTouchView.trailingAnchor.constraint(equalTo: detailVC.storeDetailTableView.trailingAnchor)
        ])
        detailVC.view.addSubview(indicatorView)
        indicatorView.constraint(top: detailVC.view.topAnchor,
                                 centerX: detailVC.view.centerXAnchor,
                                 padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        indicatorView.constraint(indicatorView.heightAnchor, constant: 5)
        indicatorView.constraint(indicatorView.widthAnchor, constant: 50)
        
        detailVC.closeStoreDetailButton.isHidden = true
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.storeDetailModalView.removeFromSuperview()
        storeDetailModalView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
}

// MARK: - SearchBarDelegate
extension ResultMapViewController: SearchBarDelegate {
    @objc func didBeginEditing() {
        view.endEditing(true)
        
        let nextViewController = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: SearchViewController.className)
        nextViewController.modalPresentationStyle = .fullScreen
        present(nextViewController, animated: false)
    }
    
    @objc func touchUpInsideLeftButton() {
        dismiss(animated: false)
    }
}

// MARK: - CategoryCollectionViewDelegate
extension ResultMapViewController: CategoryCollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mapView.removeAnnotations(mapView.annotations)
        let categoryName = categoryView.categoryList[indexPath.row]

        shops.forEach { shop in
            if shop.sellingProductsCategory.contains(categoryName) {
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
extension ResultMapViewController: StoreDetailViewControllerDelegate {
    func setupButtonAction(closeButton: UIButton) {

        self.storeDetailModalView.mode = .tip
        self.storeDetailModalView.frame = self.storeDetailModalView.mode.generateFrame(screenViewFrame: storeDetailModalView.superScreenViewFrame)
        self.detailVC?.closeStoreDetailButton.isHidden = true
        self.detailVC?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        self.preventTouchView.isHidden = false
    }
    
    func setupViewWillDisappear(closeButton: UIButton) {
        
    }

}
