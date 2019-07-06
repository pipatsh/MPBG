//
//  MobileDetailPresenterTests.swift
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

class MobileDetailPresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MobileDetailPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMobileDetailPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMobileDetailPresenter()
  {
    sut = MobileDetailPresenter()
  }
  
  // MARK: Test doubles
  
  class MobileDetailDisplayLogicSpy: MobileDetailDisplayLogic
  {
    
    var displayMobileCalled = false
    var displayMobileViewModel: MobileDetail.GetMobile.ViewModel!
    
    func displayMobile(viewModel: MobileDetail.GetMobile.ViewModel) {
      displayMobileCalled = true
      displayMobileViewModel = viewModel
    }
    
    var displayFetchedMobileImages = false
    var displayFetchedMobileImagesViewModel: MobileDetail.FetchMobileImages.ViewModel!
    func displayFetchedMobileImages(viewModel: MobileDetail.FetchMobileImages.ViewModel) {
      displayFetchedMobileImages = true
      displayFetchedMobileImagesViewModel = viewModel
    }
    
  }
  
  // MARK: Tests
  
  func testPresentMobileShouldFormatFetchedMobileForDisplay()
  {
    let spy = MobileDetailDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let response = MobileDetail.GetMobile.Response(mobile: motoG5)
    
    sut.presentMobile(response: response)

    XCTAssertEqual(spy.displayMobileViewModel.name, "Moto G5", "Presenting fetched mobiles should properly format name")
    XCTAssertEqual(spy.displayMobileViewModel.price, "$165.0", "Presenting fetched mobiles should properly format price")
    XCTAssertEqual(spy.displayMobileViewModel.rating, "3.8", "Presenting fetched mobiles should properly format rating")
    XCTAssertEqual(spy.displayMobileViewModel.description, "Description", "Presenting fetched mobiles should properly format description")
  }
  
  
  func testPresentMobileShouldAskViewControllerToDisplayMobile()
  {
    let spy = MobileDetailDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let response = MobileDetail.GetMobile.Response(mobile: motoG5)
    
    sut.presentMobile(response: response)
    
    XCTAssertTrue(spy.displayMobileCalled, "Presenting mobile should ask view controller to display them")
  }
  
  func testPresentMobileImagesShouldFormatFetchedMobileImagesForDisplay()
  {
    let spy = MobileDetailDisplayLogicSpy()
    sut.viewController = spy
    
    let images = [Seeds.MobileImageModel.motoG5Image1, Seeds.MobileImageModel.motoG5Image2]
    let response = MobileDetail.FetchMobileImages.Response(mobileImages: images)
    
    sut.presentFetchedMobileImages(response: response)
    let displayedImages = spy.displayFetchedMobileImagesViewModel.images
    
    displayedImages.enumerated().forEach { (index, image) in
      XCTAssertEqual(image, images[index].url, "images should be equal to image stored in mobile images")
    }
  }
  
  func testPresentMobileImagesShouldAskViewControllerToDisplayMobileImages()
  {
    let spy = MobileDetailDisplayLogicSpy()
    sut.viewController = spy
    
    let images = [Seeds.MobileImageModel.motoG5Image1, Seeds.MobileImageModel.motoG5Image2]
    let response = MobileDetail.FetchMobileImages.Response(mobileImages: images)
    
    sut.presentFetchedMobileImages(response: response)
    
    XCTAssertTrue(spy.displayFetchedMobileImages, "Presenting fetched mobile images should ask view controller to display them")
  }
}
