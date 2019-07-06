//
//  MobilesAPITest.swift
//  MPBGTests
//
//  Created by Pipat Shuleepongchad on 6/7/2562 BE.
//  Copyright © 2562 Pipat Shuleepongchad. All rights reserved.
//

@testable import MPBG
import XCTest
import OHHTTPStubs

class MobilesAPITest: XCTestCase {

  // MARK: - Subject under test
  
  var sut: MobilesAPI!
  
  // MARK: - Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupMobilesAPI()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }

  // MARK: - Test setup
  
  func setupMobilesAPI()
  {
    sut = MobilesAPI()
  }
  
  // MARK: - Test
  
  func testFetchMobilesShouldReturnListOfMobiles_OptionalError()
  {
    let path = Bundle(for: type(of: self)).path(forResource: "MobileList", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    let testMobiles = try! JSONDecoder().decode([Mobile].self, from: data)
    
    
    stub(condition: isPath("/api/mobiles")) { _ in
      let stubPath = OHPathForFile("MobileList.json", type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
    }
    
    var fetchedMobiles: [Mobile]?
    var fetchedError: DataError?
    let expect = expectation(description: "Wait for fetchMobiles() to return")
    sut.fetchMobiles { (mobiles, error) in
      fetchedMobiles = mobiles
      fetchedError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    XCTAssertNotNil(fetchedMobiles, "fetchedMobiles should not be nil")
    XCTAssertEqual(fetchedMobiles!.count, testMobiles.count, "fetchMobiles() should return a list of mobiles")
    for mobile in fetchedMobiles! {
      XCTAssert(testMobiles.contains(mobile), "fetchMobiles() should match the mobiles in the data store")
    }
    XCTAssertNil(fetchedError, "fetchedError should be nil")
  }
  
  func testFetchMobileImagesShouldReturnListOfMobileImages_OptionalError()
  {
    let path = Bundle(for: type(of: self)).path(forResource: "MobileImageList", ofType: "json")!
    let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    let testMobileImages = try! JSONDecoder().decode([MobileImage].self, from: data)
    
    stub(condition: isPath("/api/mobiles/1/images")) { _ in
      let stubPath = OHPathForFile("MobileImageList.json", type(of: self))
      return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
    }
    
    var fetchedMobileImages: [MobileImage]?
    var fetchedError: DataError?
    let expect = expectation(description: "Wait for fetchMobiles() to return")
    sut.fetchMobileImages(id: 1) { (mobileImages, error) in
      fetchedMobileImages = mobileImages
      fetchedError = error
      expect.fulfill()
    }
    waitForExpectations(timeout: 1.0)
    
    XCTAssertNotNil(fetchedMobileImages, "fetchedMobileImages should not be nil")
    XCTAssertEqual(fetchedMobileImages!.count, testMobileImages.count, "fetchMobileImages() should return a list of mobiles")
    for mobile in fetchedMobileImages! {
      XCTAssert(testMobileImages.contains(mobile), "fetchMobileImages() should match the mobiles in the data store")
    }
    XCTAssertNil(fetchedError, "fetchedError should be nil")
  }
}
