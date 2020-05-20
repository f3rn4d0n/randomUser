//
//  randomUserTests.swift
//  randomUserTests
//
//  Created by Luis Fernando Bustos Ramírez on 18/05/20.
//  Copyright © 2020 justo. All rights reserved.
//

import XCTest
@testable import randomUser

class randomUserTests: XCTestCase {

    var presenter: UsersListPresenter!
    var interactor: UsersListInteractor!
    var router: TestUserListRouting!
    
    override func setUp() {
        super.setUp()
        presenter = UsersListPresenter()
        interactor = UsersListInteractor()
        router = TestUserListRouting()
//        view.presenter = presenter
//        presenter.view = view
        presenter.interactor = interactor
        presenter.routing = router
        interactor.presenter = presenter
//        navigationController = UINavigationController(rootViewController: view)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func createFakeResponse() -> RandomMe{
        let wsResponse = """
        {"results":[{"gender":"female","name":{"title":"Ms","first":"Stephanie","last":"Nguyen"},"location":{"street":{"number":7119,"name":"London Road"},"city":"Belfast","state":"Borders","country":"United Kingdom","postcode":"NN12 9ZF","coordinates":{"latitude":"14.5370","longitude":"51.2568"},"timezone":{"offset":"0:00","description":"Western Europe Time, London, Lisbon, Casablanca"}},"email":"stephanie.nguyen@example.com","login":{"uuid":"eaf6b510-ea71-4392-93ee-264bb6c5b463","username":"whitedog452","password":"thanatos","salt":"PBfoKhho","md5":"c8d6dca5c237fda72d7c0eaa476b64f2","sha1":"274b3a188faed45cd55db7cfce6bdde560eb0c15","sha256":"ae23afa6b6aa4dec77d4aeee0a1bc5dbf37470a8da15e6f7f0fc0022a6ec4309"},"dob":{"date":"1959-10-23T01:16:27.728Z","age":61},"registered":{"date":"2014-06-16T05:47:17.298Z","age":6},"phone":"0121 014 9447","cell":"0716-325-437","id":{"name":"NINO","value":"LK 26 02 06 Z"},"picture":{"large":"https://randomuser.me/api/portraits/women/68.jpg","medium":"https://randomuser.me/api/portraits/med/women/68.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/women/68.jpg"},"nat":"GB"},{"gender":"male","name":{"title":"Mr","first":"Cohen","last":"Edwards"},"location":{"street":{"number":9264,"name":"North Road"},"city":"Palmerston North","state":"West Coast","country":"New Zealand","postcode":49282,"coordinates":{"latitude":"-65.5854","longitude":"-111.7116"},"timezone":{"offset":"+6:00","description":"Almaty, Dhaka, Colombo"}},"email":"cohen.edwards@example.com","login":{"uuid":"df3bfe16-b757-4d08-ab94-4117f76bee2c","username":"blackleopard217","password":"berkeley","salt":"Z1nmkima","md5":"3859101f43f4e635b7ca53654d19de10","sha1":"18925239ada22deec0a99a275a6fe389d7b1ff35","sha256":"58d7252ed7bb13fb5dda9e45007cadd0a63e0fcf0ee433783c25cda412a14140"},"dob":{"date":"1948-10-07T18:52:39.467Z","age":72},"registered":{"date":"2018-12-26T08:11:51.426Z","age":2},"phone":"(288)-769-6853","cell":"(690)-206-0885","id":{"name":"","value":null},"picture":{"large":"https://randomuser.me/api/portraits/men/52.jpg","medium":"https://randomuser.me/api/portraits/med/men/52.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/men/52.jpg"},"nat":"NZ"}],"info":{"seed":"0c55b9c8fa42821d","results":2,"page":1,"version":"1.3"}}
        """
        return try! JSONDecoder().decode(RandomMe.self, from: wsResponse.data(using: .utf8)!)
    }
    
    func testListUserPresenterUser(){
        presenter.newListOfUsers(users: createFakeResponse().results)
        XCTAssertEqual(presenter.countListUsers(), 2)
        XCTAssertEqual(presenter.getUserAt(index: 0)?.name.first, "Stephanie")
        XCTAssertEqual(presenter.getUserAt(index: 0)?.location.timezone.description, "Western Europe Time, London, Lisbon, Casablanca")
        presenter.searchUsers(name: "Edwards", gender: "male")
        XCTAssertEqual(presenter.countListUsers(), 1)
        XCTAssertEqual(presenter.getUserAt(index: 0)?.name.first, "Cohen")
        XCTAssertEqual(presenter.getUserAt(index: 0)?.location.timezone.description, "Almaty, Dhaka, Colombo")
    }
    
    func testRoutingUserList(){
        presenter.newListOfUsers(users: createFakeResponse().results)
        presenter.selectUser(user: presenter.getUserAt(index: 0)!)
        router.showDetail(for: presenter.getUserAt(index: 0)!)
        XCTAssertTrue(router.showDetailCalled)
        let routerDetail = UserDetailRouting()
        routerDetail.presenter.setUser(user: presenter.getUserAt(index: 0)!)
        XCTAssertEqual(presenter.getUserAt(index: 0)?.name.first, routerDetail.presenter.getUserInformation().name.first)
    }
}

extension randomUserTests {
    class TestUserListRouting: UserListRouting {
        var showDetailCalled = false
        
        func showDetail(for user: User) {
            showDetailCalled = true
        }
    }
}
