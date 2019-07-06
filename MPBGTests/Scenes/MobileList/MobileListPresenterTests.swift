//
//  MobileListPresenterTests.swift
//  MPBG
//
//  Created by Pipat Shuleepongchad on 5/7/2562 BE.
//  Copyright (c) 2562 Pipat Shuleepongchad. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import MPBG
import XCTest

class MobileListPresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: MobileListPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMobileListPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMobileListPresenter()
  {
    sut = MobileListPresenter()
  }
  
  // MARK: Test doubles
  
  class MobileListDisplayLogicSpy: MobileListDisplayLogic
  {
    var displayFetchedMobilesCalled = false
    
    var fetchMobilesViewModel: MobileList.FetchMobiles.ViewModel!
    
    func displayFetchedMobiles(viewModel: MobileList.FetchMobiles.ViewModel) {
      displayFetchedMobilesCalled = true
      self.fetchMobilesViewModel = viewModel
    }
    
    var displayAddFavouriteMobileCalled = false
    
    func displayAddFavouriteMobile(viewModel: MobileList.AddFavourite.ViewModel) {
      displayAddFavouriteMobileCalled = true
    }
    
    var displayDeleteFavouriteMobileCalled = false
    
    func displayDeleteFavouriteMobile(viewModel: MobileList.DeleteFavourite.ViewModel) {
      displayDeleteFavouriteMobileCalled = true
    }
    
    var displayMobilesErrorCalled = false
    
    func displayMobilesError(viewModel: MobileList.Error.ViewModel) {
      displayMobilesErrorCalled = true
    }
    
    var displayErroreCalled = false
    
    func displayError(viewModel: MobileList.Error.ViewModel) {
      displayErroreCalled = true
    }
    
    var displayProgressCalled = false
    
    func displayProgress(viewModel: MobileList.Progress.ViewModel) {
      displayProgressCalled = true
    }
    
  }
  
  // MARK: Tests
  func testPresentFetchedMobilesShouldFormatFetchedMobilesForDisplayTypeAll()
  {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let response = MobileList.FetchMobiles.Response(displayMethod: DisplayMethod(type: .all), sortMethod: SortMethod(type: .priceLowToHigh), mobiles: [motoG5], favouriteMobiles: [])
    
    sut.presentFetchedMobiles(response: response)
    let displayedMobiles = spy.fetchMobilesViewModel.displayedMobiles
    for displayedMobile in displayedMobiles {
      XCTAssertEqual(displayedMobile.id, 1, "Presenting fetched mobiles should properly format mobile ID")
      XCTAssertEqual(displayedMobile.name, "Moto G5", "Presenting fetched mobiles should properly format name")
      XCTAssertEqual(displayedMobile.price, "$165.0", "Presenting fetched mobiles should properly format price")
      XCTAssertEqual(displayedMobile.rating, "3.8", "Presenting fetched mobiles should properly format rating")
      XCTAssertEqual(displayedMobile.description, "Description", "Presenting fetched mobiles should properly format description")
      XCTAssertEqual(displayedMobile.isFavourite, false, "Presenting fetched mobiles should properly format isFavourite")
    }
    
  }
  
  func testPresentFetchedMobilesShouldFormatFetchedMobilesForDisplayTypeFavourite()
  {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let response = MobileList.FetchMobiles.Response(displayMethod: DisplayMethod(type: .favourite), sortMethod: SortMethod(type: .priceLowToHigh), mobiles: [motoG5], favouriteMobiles: [motoG5])
    
    sut.presentFetchedMobiles(response: response)
    let displayedMobiles = spy.fetchMobilesViewModel.displayedMobiles
    for displayedMobile in displayedMobiles {
      XCTAssertEqual(displayedMobile.id, 1, "Presenting fetched mobiles should properly format mobile ID")
      XCTAssertEqual(displayedMobile.name, "Moto G5", "Presenting fetched mobiles should properly format name")
      XCTAssertEqual(displayedMobile.price, "$165.0", "Presenting fetched mobiles should properly format price")
      XCTAssertEqual(displayedMobile.rating, "3.8", "Presenting fetched mobiles should properly format rating")
      XCTAssertEqual(displayedMobile.description, "Description", "Presenting fetched mobiles should properly format description")
      XCTAssertEqual(displayedMobile.isFavourite, true, "Presenting fetched mobiles should properly format isFavourite")
    }
    
  }
  
  func testPresentFetchedMobilesShouldFormatFetchedMobilesForSortTypePriceLowToHigh()
  {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let sonyL1 = Seeds.MobileModel.sonyL1
    let response = MobileList.FetchMobiles.Response(displayMethod: DisplayMethod(type: .all), sortMethod: SortMethod(type: .priceLowToHigh), mobiles: [motoG5, sonyL1], favouriteMobiles: [])
    
    sut.presentFetchedMobiles(response: response)
    let displayedMobiles = spy.fetchMobilesViewModel.displayedMobiles
    let displayedMobile = displayedMobiles[0]
      XCTAssertEqual(displayedMobile.id, 1, "Presenting fetched mobiles should properly format mobile ID")
      XCTAssertEqual(displayedMobile.name, "Moto G5", "Presenting fetched mobiles should properly format name")
      XCTAssertEqual(displayedMobile.price, "$165.0", "Presenting fetched mobiles should properly format price")
      XCTAssertEqual(displayedMobile.rating, "3.8", "Presenting fetched mobiles should properly format rating")
      XCTAssertEqual(displayedMobile.description, "Description", "Presenting fetched mobiles should properly format description")
      XCTAssertEqual(displayedMobile.isFavourite, false, "Presenting fetched mobiles should properly format isFavourite")
  }
  
  func testPresentFetchedMobilesShouldFormatFetchedMobilesForSortTypePriceHighToLow()
  {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let sonyL1 = Seeds.MobileModel.sonyL1
    let response = MobileList.FetchMobiles.Response(displayMethod: DisplayMethod(type: .all), sortMethod: SortMethod(type: .priceHighToLow), mobiles: [motoG5, sonyL1], favouriteMobiles: [])
    
    sut.presentFetchedMobiles(response: response)
    let displayedMobiles = spy.fetchMobilesViewModel.displayedMobiles
    let displayedMobile = displayedMobiles[0]
    XCTAssertEqual(displayedMobile.id, 2, "Presenting fetched mobiles should properly format mobile ID")
    XCTAssertEqual(displayedMobile.name, "Sony Xperia L1", "Presenting fetched mobiles should properly format name")
    XCTAssertEqual(displayedMobile.price, "$171.99", "Presenting fetched mobiles should properly format price")
    XCTAssertEqual(displayedMobile.rating, "4.3", "Presenting fetched mobiles should properly format rating")
    XCTAssertEqual(displayedMobile.description, "Description", "Presenting fetched mobiles should properly format description")
    XCTAssertEqual(displayedMobile.isFavourite, false, "Presenting fetched mobiles should properly format isFavourite")
  }
  
  func testPresentFetchedMobilesShouldFormatFetchedMobilesForSortTypeRating()
  {
    
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let sonyL1 = Seeds.MobileModel.sonyL1
    let response = MobileList.FetchMobiles.Response(displayMethod: DisplayMethod(type: .all), sortMethod: SortMethod(type: .rating), mobiles: [motoG5, sonyL1], favouriteMobiles: [])
    
    sut.presentFetchedMobiles(response: response)
    let displayedMobiles = spy.fetchMobilesViewModel.displayedMobiles
    let displayedMobile = displayedMobiles[0]
    XCTAssertEqual(displayedMobile.id, 2, "Presenting fetched mobiles should properly format mobile ID")
    XCTAssertEqual(displayedMobile.name, "Sony Xperia L1", "Presenting fetched mobiles should properly format name")
    XCTAssertEqual(displayedMobile.price, "$171.99", "Presenting fetched mobiles should properly format price")
    XCTAssertEqual(displayedMobile.rating, "4.3", "Presenting fetched mobiles should properly format rating")
    XCTAssertEqual(displayedMobile.description, "Description", "Presenting fetched mobiles should properly format description")
    XCTAssertEqual(displayedMobile.isFavourite, false, "Presenting fetched mobiles should properly format isFavourite")
  }
  
  func testPresentFetchedMobilesShouldAskViewControllerToDisplayMobiles()
  {

    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let response = MobileList.FetchMobiles.Response(displayMethod: DisplayMethod(type: .all), sortMethod: SortMethod(type: .priceLowToHigh), mobiles: [motoG5], favouriteMobiles: [])
    
    sut.presentFetchedMobiles(response: response)
    
    XCTAssert(spy.displayFetchedMobilesCalled, "Presenting fetched mobiles should ask view controller to display them")
  }
  
  func testPresentAddFavouriteMobileShouldAskViewControllerToDisplayAddFavouriteMobile() {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let response = MobileList.AddFavourite.Response(mobile: motoG5)
    sut.presentAddFavouriteMobile(response: response)
    
    XCTAssert(spy.displayAddFavouriteMobileCalled, "Presenting add favourite mobile should ask view controller to display them")
  }
  
  func testPresentDeleteFavouriteMobileShouldAskViewControllerToDisplayDeleteFavouriteMobile() {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let motoG5 = Seeds.MobileModel.motoG5
    let response = MobileList.DeleteFavourite.Response(displayMethod: DisplayMethod(type: .all), mobile: motoG5)
    sut.presentDeleteFavouriteMobile(response: response)
    
    XCTAssert(spy.displayDeleteFavouriteMobileCalled, "Presenting delete favourite mobile should ask view controller to display them")
  }
  
  func testPresentMobilesErrorAskViewControllerToDisplayMobilesError() {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let response = MobileList.Error.Response(error: DataError.cannotFetch("fetch failed"))
    sut.presentFetchedMobilesError(response: response)
    
     XCTAssert(spy.displayMobilesErrorCalled, "Presenting mobile error should ask view controller to display them")
  }
  
  func testPresentErrorAskViewControllerToDisplayError() {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let response = MobileList.Error.Response(error: DataError.cannotFetch("fetch failed"))
    sut.presentError(response: response)
    
    XCTAssert(spy.displayErroreCalled, "Presenting error should ask view controller to display them")
  }
  
  func testPresentProgressAskViewControllerToDisplayProgress() {
    let spy = MobileListDisplayLogicSpy()
    sut.viewController = spy
    
    let response = MobileList.Progress.Response(show: true)
    sut.presentProgress(response: response)
    
    XCTAssert(spy.displayProgressCalled, "Presenting progress should ask view controller to display them")
  }
  
}

