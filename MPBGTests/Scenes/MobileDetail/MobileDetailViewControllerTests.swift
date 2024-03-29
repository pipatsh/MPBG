//
//  MobileDetailViewControllerTests.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 6/7/2562 BE.
//  Copyright (c) 2562 Pipat Shuleepongchad. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import MPBG
import XCTest

class MobileDetailViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MobileDetailViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupMobileDetailViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMobileDetailViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "MobileDetailViewController") as? MobileDetailViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class MobileDetailBusinessLogicSpy: MobileDetailBusinessLogic
  {
    var getMobileCalled = false
    
    func getMobile(request: MobileDetail.GetMobile.Request) {
      getMobileCalled = true
    }
    
    var fetchMobileImagesCalled = false
    
    func fetchMobileImages(request: MobileDetail.FetchMobileImages.Request) {
      fetchMobileImagesCalled = true
    }
   
  }
  
  class CollectionViewSpy: UICollectionView
  {
    var reloadDataCalled = false
    
    override func reloadData()
    {
      reloadDataCalled = true
    }
  }
  
  // MARK: Tests
  
  func testShouldGetMobileAndFetchMobileImagesWhenViewIsLoaded() {
    let spy = MobileDetailBusinessLogicSpy()
    sut.interactor = spy
    
    loadView()
    
    XCTAssertTrue(spy.getMobileCalled, "viewDidLoad() should ask the interactor to get mobile")
    XCTAssertTrue(spy.fetchMobileImagesCalled, "viewDidLoad() should ask the interactor to fetch mobileImages")
  }

  func testShouldDisplayMobile() {
    let spy = MobileDetailBusinessLogicSpy()
    sut.interactor = spy
    
    loadView()
    
    let viewModel = Seeds.MobileDetailDisplay.motoG5
    sut.displayMobile(viewModel: viewModel)
    
    XCTAssertEqual(sut.title, viewModel.name, "title should equal to \(viewModel.name)")
    XCTAssertEqual(sut.descriptionLabel.text, viewModel.description, "description should equal to \(viewModel.description)")
    XCTAssertEqual(sut.priceLabel.text, "Price: \(viewModel.price)", "price should equal to Price:  \(viewModel.price)")
    XCTAssertEqual(sut.ratingLabel.text, "Rating: \(viewModel.rating)", "price should equal to Rating:  \(viewModel.rating)")
  }
  
  func testShouldDisplayFetchedMobileImages() {
    let collectionViewSpy = CollectionViewSpy(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    sut.collectionView = collectionViewSpy
    
    let images = ["https://abc.com/image1",
                  "https://abc.com/image2"]
    let viewModel = MobileDetail.FetchMobileImages.ViewModel(images: images)
    sut.displayFetchedMobileImages(viewModel: viewModel)

    XCTAssert(collectionViewSpy.reloadDataCalled, "Displaying fetched mobileImages should reload the collectionView")
  }
  
  func testNumberOfItemsInSectionInCollectionViewShouldEqaulNumberOfImagesToDisplay() {
    let spy = MobileDetailBusinessLogicSpy()
    sut.interactor = spy
    
    loadView()
    
    let collectionView = sut.collectionView
    
    let images = ["https://abc.com/image1",
                  "https://abc.com/image2"]
    sut.images = images
    
    let numberOfItems = sut.collectionView(collectionView!, numberOfItemsInSection: 0)
    XCTAssertEqual(numberOfItems, images.count, "The number of collection view items should equal the number of images to display")
  }
  
  func testShouldConfigureCollectionViewCellToDisplayImages()
  {
    let spy = MobileDetailBusinessLogicSpy()
    sut.interactor = spy
    
    loadView()
    
    let collectionView = sut.collectionView

    let images = ["https://abc.com/image1",
                  "https://abc.com/image2"]
    sut.images = images
    
    images.enumerated().forEach { (index, image) in
      let indexPath = IndexPath(item: index, section: 0)
      let cell = sut.collectionView(collectionView!, cellForItemAt: indexPath) as! MobileDetailImageCollectionViewCell

       XCTAssertEqual(cell.imageURLString, image, "imageURLString should equal to \(image)")
    }
  }
}

