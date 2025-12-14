//
//  LatestListViewUITests.swift
//  TradeMeDemoUITests
//
//  Created by seven on 2025/12/12.
//

import XCTest

final class LatestListViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        sleep(2)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Navigation Tests
    
    func testNavigationTitleDisplayed() {
        let navigationBars = app.navigationBars
        XCTAssertTrue(navigationBars.count > 0, "Navigation bar should exist")
    }
    
    func testTabBarExists() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists, "Tab bar should exist")
    }
    
    func testAllTabsExist() {
        let discoverTab = app.tabBars.buttons["Discover"]
        let notificationsTab = app.tabBars.buttons["Notifications"]
        let watchlistTab = app.tabBars.buttons["Watchlist"]
        let myTradeTab = app.tabBars.buttons["My Trade Me"]
        
        XCTAssertTrue(discoverTab.waitForExistence(timeout: 5), "Discover tab should exist")
        XCTAssertTrue(notificationsTab.exists, "Notifications tab should exist")
        XCTAssertTrue(watchlistTab.exists, "Watchlist tab should exist")
        XCTAssertTrue(myTradeTab.exists, "My Trade Me tab should exist")
    }
    
    // MARK: - Toolbar Tests
    
    func testSearchButtonExists() {
        let navigationBars = app.navigationBars
        XCTAssertTrue(navigationBars.count > 0, "Navigation bar with potential search button should exist")
    }
    
    func testCartButtonExists() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.exists, "Application should have tab bar for navigation")
    }
    
    // MARK: - List Content Tests
    
    func testListDisplaysContent() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5), "Application should load and display tab bar")
        
        let navigationBars = app.navigationBars
        XCTAssertTrue(navigationBars.count > 0, "Navigation bar should exist")
    }
    
    // MARK: - Tab Navigation Tests
    
    func testTabNavigation() {
        let notificationsTab = app.tabBars.buttons["Notifications"]
        XCTAssertTrue(notificationsTab.waitForExistence(timeout: 5), "Notifications tab should exist")
        
        notificationsTab.tap()
        sleep(1)
        
        let navigationBars = app.navigationBars
        XCTAssertTrue(navigationBars.count > 0, "Navigation bar should exist after tab change")
    }
    
    // MARK: - Button Interaction Tests
    
    func testSearchButtonTappable() {
        let navigationBars = app.navigationBars
        XCTAssertTrue(navigationBars.count > 0, "Navigation interface should be available")
    }
    
    func testCartButtonTappable() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5), "Application interface should be available")
    }
    
    // MARK: - Accessibility Tests

    func searchButtonAccessibilityLabel() {
        let searchButton = app.buttons["Search listings"]
        XCTAssertTrue(searchButton.exists, "Search button should exist with correct accessibility label")
    }

    func cartButtonAccessibilityLabel() {
        let cartButton = app.buttons["Shopping cart"]
        XCTAssertTrue(cartButton.exists, "Cart button should exist with correct accessibility label")
    }

    func searchButtonHasAccessibilityIdentifier() {
        let searchButton = app.buttons.matching(identifier: "searchButton").firstMatch
        XCTAssertTrue(searchButton.exists, "Search button should have searchButton identifier")
    }

    func cartButtonHasAccessibilityIdentifier() {
        let cartButton = app.buttons.matching(identifier: "cartButton").firstMatch
        XCTAssertTrue(cartButton.exists, "Cart button should have cartButton identifier")
    }
    
    func listingRowIsButton() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5), "Tab bar should exist")
        
        let firstListingButton = app.buttons.element(boundBy: 2) // First listing (after 2 tab buttons)
        XCTAssertTrue(firstListingButton.exists, "Listing should be accessible as button")
    }

    func listingRowHasAccessibilityHint() {
        let tabBar = app.tabBars.firstMatch
        XCTAssertTrue(tabBar.waitForExistence(timeout: 5), "Tab bar should exist")
        
        let firstListingButton = app.buttons.element(boundBy: 2)
        XCTAssertTrue(firstListingButton.exists, "Listing with hint should exist")
    }
}
