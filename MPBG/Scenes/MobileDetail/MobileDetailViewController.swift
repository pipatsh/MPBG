//
//  MobileDetailViewController.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 4/7/2562 BE.
//  Copyright (c) 2562 Pipat Shuleepongchad. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MobileDetailDisplayLogic: class
{
  func displayMobile(viewModel: MobileDetail.GetMobile.ViewModel)
  func displayFetchedMobileImages(viewModel: MobileDetail.FetchMobileImages.ViewModel)
}

class MobileDetailViewController: UIViewController, MobileDetailDisplayLogic
{
  var interactor: MobileDetailBusinessLogic?
  var router: (NSObjectProtocol & MobileDetailRoutingLogic & MobileDetailDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = MobileDetailInteractor()
    let presenter = MobileDetailPresenter()
    let router = MobileDetailRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    getMobile()
    fetchMobileImages()
  }
  
  func getMobile()
  {
    let request = MobileDetail.GetMobile.Request()
    interactor?.getMobile(request: request)
  }
  
  func fetchMobileImages()
  {
    let request = MobileDetail.FetchMobileImages.Request()
    interactor?.fetchMobileImages(request: request)
  }
  
  // MARK: Do something
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  
  var images: [String] = []
  
  func displayMobile(viewModel: MobileDetail.GetMobile.ViewModel)
  {
    title = viewModel.name
    priceLabel.text = "Price: \(viewModel.price)"
    ratingLabel.text = "Rating: \(viewModel.rating)"
    descriptionLabel.text = viewModel.description
  }
  
  func displayFetchedMobileImages(viewModel: MobileDetail.FetchMobileImages.ViewModel)
  {
    images = viewModel.images
    collectionView.reloadData()
  }
  
}

extension MobileDetailViewController: UICollectionViewDataSource
{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
  {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MobileDetailImageCell", for: indexPath) as! MobileDetailImageCollectionViewCell
    cell.imageURLString = images[indexPath.item]
    return cell
  }
}

extension MobileDetailViewController: UICollectionViewDelegateFlowLayout
{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
  {
    return collectionView.frame.size
  }
}