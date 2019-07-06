//
//  MobilesCoreDataStoreTest.swift
//  MPBGTests
//
//  Created by Pipat Shuleepongchad on 6/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

@testable import MPBG
import XCTest

class MobilesCoreDataStoreTest: XCTestCase
{
  // MARK: - Subject under test
  
  var sut: MobilesCoreDataStore!
  var testMobiles: [Mobile]!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMobilesCoreDataStore()
  }
  
  override func tearDown()
  {
    deleteAllMobilesInOrdersCoreDataStore()
    sut = nil
    super.tearDown()
  }

  // MARK: - Test setup
  
  func setupMobilesCoreDataStore()
  {
    sut = MobilesCoreDataStore()
    
    testMobiles = [Seeds.MobileModel.motoG5, Seeds.MobileModel.sonyL1]
    
    deleteAllMobilesInOrdersCoreDataStore()
  }
  
  func addFavourtieMobilesToCoreDataStore() {
    for mobile in testMobiles {
      let expect = expectation(description: "Wait for addFavourite() to return")
      sut.addFavouriteMobile(mobile: mobile) { (mobile, error) in
        expect.fulfill()
      }
      waitForExpectations(timeout: 1.0)
    }
  }
  
  func deleteAllMobilesInOrdersCoreDataStore()
  {
    var favouriteMobiles = [Mobile]()
    let fetchMobilesExpectation = expectation(description: "Wait for fetchFavouriteMobiles() to return")
    sut.fetchFavouriteMobiles { (mobiles, error) in
      favouriteMobiles = mobiles!
      fetchMobilesExpectation.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    for mobile in favouriteMobiles {
      let deleteFavouriteMobileExpectation = expectation(description: "Wait for deleteFavouriteMobile() to return")
      sut.deleteFavouriteMobile(id: mobile.id) { (mobiles, error) in
         deleteFavouriteMobileExpectation.fulfill()
      }
      waitForExpectations(timeout: 1.0)
    }
  }
  
  // MARK: - Test
  
  func testFetchFavouriteMobilesShouldReturnListOfMobiles_OptionalError()
  {
    addFavourtieMobilesToCoreDataStore()
    
    var fetchedMobiles: [Mobile]?
    var fetchedError: DataError?
    let expect = expectation(description: "Wait for fetchFavouriteMobiles() to return")
    sut.fetchFavouriteMobiles { (mobiles, error) in
      fetchedMobiles = mobiles
      fetchedError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    // Then
    XCTAssertNotNil(fetchedMobiles, "fetchedMobiles should not be nil")
    XCTAssertEqual(fetchedMobiles!.count, testMobiles.count, "fetchFavouriteMobiles() should return a list of mobiles")
    for mobile in fetchedMobiles! {
      XCTAssert(testMobiles.contains(mobile), "Fetched favourite mobiles should match the mobiles in the data store")
    }
    XCTAssertNil(fetchedError, "fetchedError should be nil")
  }
  
  func testAddFavouriteMobileShouldReturnMobile_OptionalError()
  {
    deleteAllMobilesInOrdersCoreDataStore()
    let mobileToAdd = testMobiles.first!
    
    var addedMobile: Mobile?
    var addedError: DataError?
    let expect = expectation(description: "Wait for addFavouriteMobiles() to return")
    sut.addFavouriteMobile(mobile: mobileToAdd) { (mobile, error) in
      addedMobile = mobile
      addedError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    XCTAssertNotNil(addedMobile, "addedMobile should not be nil")
    XCTAssertEqual(addedMobile!, mobileToAdd, "addFavouriteMobiles() should return a mobile")
    XCTAssertNil(addedError, "addedError should be nil")
  }
  
  func testDeleteFavouriteMobileShouldReturnMobile_OptionalError()
  {
    addFavourtieMobilesToCoreDataStore()
    let mobileToDelete = testMobiles.first!
    
    var deletedMobile: Mobile?
    var deletedError: DataError?
    let expect = expectation(description: "Wait for deleteFavouriteMobiles() to return")
    sut.deleteFavouriteMobile(id: mobileToDelete.id) { (mobile, error) in
      deletedMobile = mobile
      deletedError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    XCTAssertNotNil(deletedMobile, "deletedMobile should not be nil")
    XCTAssertEqual(deletedMobile!, mobileToDelete, "deleteFavouriteMobiles() should return a mobile")
    XCTAssertNil(deletedError, "addedError should be nil")
  }
}
