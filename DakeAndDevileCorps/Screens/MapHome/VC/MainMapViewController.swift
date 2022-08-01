//
//  ViewController.swift
//  DakeAndDevileCorps
//
//  Created by Seungyun Kim on 2022/07/18.
//

import MapKit
import UIKit

class MainMapViewController: UIViewController {
    
    // MARK: - subViews
    private let searchBarView: SearchBarView = {
        let searchBarView = SearchBarView()
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.entryPoint = .map
        return searchBarView
    }()
    
    private let categoryView: CategoryView = {
        let categoryView = CategoryView(entryPoint: .map)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    @IBOutlet weak var mapView: MKMapView!
    
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
        configureLayout()
        
        drawAnnotationViews()
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
            if storeDetailModalView.frame.origin.y > self.view.frame.height / 2 {
                storeDetailModalView.mode = .tip(screenViewFrame: self.view.frame)
            } else {
                storeDetailModalView.mode = .full(screenViewFrame: self.view.frame)
            }
        case .ended, .cancelled:
            switch storeDetailModalView.mode {
            case .tip:
                if storeDetailModalView.frame.origin.y > self.view.frame.height - 75 {
                    storeDetailModalView.removeFromSuperview()
                }
                preventTouchView.isHidden = false
                
                
                let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                storeDetailModalView.frame = CGRect(x: 0,
                                                    y: storeDetailModalView.mode.frame.minY,
                                                    width: storeDetailModalView.mode.frame.width,
                                                    height: fullFrame.height)
                
                detailVC?.storeDetailTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            case .full:
                preventTouchView.isHidden = true
                let fullFrame = CustomModalView.ModalMode.full(screenViewFrame: self.view.frame).frame
                storeDetailModalView.frame = CGRect(x: 0,
                                                    y: storeDetailModalView.mode.frame.minY,
                                                    width: storeDetailModalView.mode.frame.width,
                                                    height: fullFrame.height)
                storeDetailModalView.subviews.last?.frame = CGRect(x: 0,
                                                    y: 0,
                                                    width: storeDetailModalView.mode.frame.width,
                                                    height: fullFrame.height)
            }
        
        default: break
        }
    }
}

// MARK: - MapViewDelegate
extension MainMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let marker = mapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView.className) as? AnnotationView else {
            return AnnotationView()
        }
        
        return marker
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.view.addSubview(storeDetailModalView)
        
        detailVC = UIStoryboard(name: "StoreDetail", bundle: nil).instantiateViewController(withIdentifier: StoreDetailViewController.className) as? StoreDetailViewController
        guard let detailVC = detailVC else { return }
        storeDetailModalView.addSubview(detailVC.view)
        detailVC.view.layer.cornerRadius = 20
        detailVC.view.frame = CGRect(x: 0, y: 0, width: storeDetailModalView.frame.width, height: self.view.frame.height)
        detailVC.view.addSubview(preventTouchView)
        NSLayoutConstraint.activate([
            preventTouchView.topAnchor.constraint(equalTo: detailVC.storeDetailTableView.topAnchor),
            preventTouchView.bottomAnchor.constraint(equalTo: detailVC.storeDetailTableView.bottomAnchor),
            preventTouchView.leadingAnchor.constraint(equalTo: detailVC.storeDetailTableView.leadingAnchor),
            preventTouchView.trailingAnchor.constraint(equalTo: detailVC.storeDetailTableView.trailingAnchor),
        ])
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.storeDetailModalView.removeFromSuperview()
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
        nextViewController.modalTransitionStyle = .crossDissolve
        present(nextViewController, animated: true)
    }
}

// MARK: - CategoryCollectionViewDelegate
extension MainMapViewController: CategoryCollectionViewDelegate {
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
