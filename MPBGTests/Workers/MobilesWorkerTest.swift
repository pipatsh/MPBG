//
//  MobilesWorkerTest.swift
//  MPBGTests
//
//  Created by Pipat Shuleepongchad on 6/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

@testable import MPBG
import XCTest

class MobilesWorkerTest: XCTestCase
{

  // MARK: - Subject under test
  
  var sut: MobilesWorker!
  static var testMobiles: [Mobile]!
  static var testMobileImages: [MobileImage]!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMobilesWorker()
  }
  
  func setupMobilesWorker()
  {
    sut = MobilesWorker(mobilesStore: MobilesStoreSpy())
    MobilesWorkerTest.testMobiles = [Seeds.MobileModel.motoG5, Seeds.MobileModel.sonyL1]
    MobilesWorkerTest.testMobileImages = [Seeds.MobileImageModel.motoG5Image1, Seeds.MobileImageModel.motoG5Image2]
  }
  
  class MobilesStoreSpy: MobilesStoreProtocol
  {
    
    var fetchMobilesCalled = false
    
    func fetchMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
    {
      fetchMobilesCalled = true
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        completionHandler(MobilesWorkerTest.testMobiles, nil)
      }
    }
    
    var fetchMobileImagesCalled = false
    
    func fetchMobileImages(id: Int, completionHandler: @escaping ([MobileImage]?, DataError?) -> Void)
    {
      fetchMobileImagesCalled = true
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        completionHandler(MobilesWorkerTest.testMobileImages, nil)
      }
    }
    
    var fetchFavouriteMobilesCalled = false
    
    func fetchFavouriteMobiles(completionHandler: @escaping ([Mobile]?, DataError?) -> Void)
    {
      fetchFavouriteMobilesCalled = true
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        completionHandler(MobilesWorkerTest.testMobiles, nil)
      }
    }
    
    var addFavouriteMobileCalled = false
    
    func addFavouriteMobile(mobile: Mobile, completionHandler: @escaping (Mobile?, DataError?) -> Void)
    {
      addFavouriteMobileCalled = true
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        completionHandler(MobilesWorkerTest.testMobiles.first!, nil)
      }
    }
    
    var deleteFavouriteMobileCalled = false
    
    func deleteFavouriteMobile(id: Int, completionHandler: @escaping (Mobile?, DataError?) -> Void)
    {
      deleteFavouriteMobileCalled = true
      DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        completionHandler(MobilesWorkerTest.testMobiles.first!, nil)
      }
    }
  }
  
  // MARK: - Tests
  
  func testFetchMobilesShouldReturnListOfMobiles_OptionalError()
  {
    let mobilesStoreSpy = sut.mobilesStore as! MobilesStoreSpy

    var testMobiles: [Mobile]?
    var testError: DataError?
    let expect = expectation(description: "Wait for fetchMobiles() to return")
    sut.fetchMobiles { (mobiles, error) in
      testMobiles = mobiles
      testError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.1)
    
    XCTAssert(mobilesStoreSpy.fetchMobilesCalled, "Calling fetchMobiles() should ask the data store for a list of mobiles")
    XCTAssertNotNil(testMobiles, "fetchMobiles() should not be nil")
    XCTAssertEqual(testMobiles!.count, MobilesWorkerTest.testMobiles.count, "fetchMobiles() should return a list of mobiles")
    for mobile in testMobiles! {
      XCTAssert(MobilesWorkerTest.testMobiles.contains(mobile), "Fetched mobiles should match the mobiles in the data store")
    }
    XCTAssertNil(testError, "error should be nil")
  }
  
  func testFetchMobileImagesShouldReturnListOfMobileImages_OptionalError()
  {
    let mobilesStoreSpy = sut.mobilesStore as! MobilesStoreSpy

    var testMobileImages: [MobileImage]?
    var testError: DataError?
    let expect = expectation(description: "Wait for fetchMobileImages() to return")
    sut.fetchMobileImages(id: 1) { (mobileImages, error) in
      testMobileImages = mobileImages
      testError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.1)
    
    XCTAssert(mobilesStoreSpy.fetchMobileImagesCalled, "Calling fetchMobileImages() should ask the data store for a list of mobileImages")
    XCTAssertNotNil(testMobileImages, "fetchMobileImages() should not be nil")
    XCTAssertEqual(testMobileImages!.count, MobilesWorkerTest.testMobileImages.count, "fetchMobileImages() should return a list of mobileImages")
    for mobileImage in testMobileImages! {
      XCTAssert(MobilesWorkerTest.testMobileImages.contains(mobileImage), "Fetched mobileImages should match the mobileImages in the data store")
    }
    XCTAssertNil(testError, "error should be nil")
  }
  
  func testFetchFavouriteMobilesShouldReturnListOfMobiles_OptionalError()
  {
    let mobilesStoreSpy = sut.mobilesStore as! MobilesStoreSpy
    
    var testMobiles: [Mobile]?
    var testError: DataError?
    let expect = expectation(description: "Wait for fetchFavouriteMobiles() to return")
    sut.fetchFavoriteMobiles { (mobiles, error) in
      testMobiles = mobiles
      testError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.1)
    
    XCTAssert(mobilesStoreSpy.fetchFavouriteMobilesCalled, "Calling fetchFavouriteMobilesCalled() should ask the data store for a list of mobiles")
    XCTAssertNotNil(testMobiles, "fetchMobiles() should not be nil")
    XCTAssertEqual(testMobiles!.count, MobilesWorkerTest.testMobiles.count, "fetchMobiles() should return a list of mobiles")
    for mobile in testMobiles! {
      XCTAssert(MobilesWorkerTest.testMobiles.contains(mobile), "Fetched mobiles should match the mobiles in the data store")
    }
    XCTAssertNil(testError, "error should be nil")
  }
  
  func testAddFavouriteMobileShouldReturnMobile_OptionalError()
  {
    let mobilesStoreSpy = sut.mobilesStore as! MobilesStoreSpy

    let mobileToAdd = MobilesWorkerTest.testMobiles.first!
    var testMobile: Mobile?
    var testError: DataError?
    let expect = expectation(description: "Wait for addFavouriteMobiles() to return")
    sut.addFavouriteMobile(mobile: mobileToAdd) { (mobile, error) in
      testMobile = mobile
      testError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.1)
    
    XCTAssert(mobilesStoreSpy.addFavouriteMobileCalled, "Calling addFavouriteMobiles() should ask the data store for a mobile")
    XCTAssertNotNil(testMobile, "mobile should not be nil")
    XCTAssertEqual(testMobile, mobileToAdd, "mobile should equal to mobileToAdd")
    XCTAssertNil(testError, "error should be nil")
  }
  
  func testDeleteFavouriteMobileShouldReturnMobile_OptionalError()
  {
    let mobilesStoreSpy = sut.mobilesStore as! MobilesStoreSpy

    var testMobile: Mobile?
    var testError: DataError?
    let expect = expectation(description: "Wait for deleteFavouriteMobiles() to return")
    sut.deleteFavouriteMobile(id: 1) { (mobile, error) in
      testMobile = mobile
      testError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.1)
    
    XCTAssert(mobilesStoreSpy.deleteFavouriteMobileCalled, "Calling deleteFavouriteMobiles() should ask the data store for a mobile")
    XCTAssertNotNil(testMobile, "mobile should not be nil")
    XCTAssertEqual(testMobile, MobilesWorkerTest.testMobiles.first!, "mobile should equal to testMobiles.first")
    XCTAssertNil(testError, "error should be nil")
  }
}
