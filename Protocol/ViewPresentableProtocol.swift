//
//  ViewPresentableProtocol.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/28.
//

import Foundation
import UIKit

// class 혹은 struct와 같이 예약어를 가지고있다.
// 실질적인 함수 기능은 구현하지 않고 목차를 가진 형태이다.
// 프로토콜을 사용할 때 상속받는 컨트롤러 뒤쪽에 위치해야한다. 중요!!!!!
// 공통적인 함수가 여러 파일에 사용되어야할 떄,
// 가시성이 높아진다.
// 프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다.
// 실질적인 구현은 프로토콜을 채택, 준수한 타입이 구현한다.
// 클래스. 구조체, 익스텐션, 열거형... 등에 사용이 가능하다.
// 클래스는 단일 상속만 가능하지만, 프로토콜은 채택 갯수에 제한이 없다.
// @objc optional -> 선택적 요청 (Optional Requirement)을 사용할 땐
// protocol 전체에도 @objc를 작성해줘야한다.
// object-c에는 class만이 존재하기 때문이다.


// 프로토콜 프로퍼티, 프로토콜 메서드

// 프로토콜 프로퍼티 : 연산 프로퍼티로 쓰든, 저장 프로퍼티로 쓰든 상관하지 않는다.
// 명세하지 않기에, 구현을 할 때, 프로퍼티를 저장 프로퍼티로 쓸 수 있고 연산 프로퍼티로 사용할 수도 있다.
// 무조건!!!!!!!!!!!!!!!!!!!!!! var로 선언해야한다.

// 만약 get만 명시했다면, get기능만 최소한 구현되어있으면 된다.
// 그래서 필요하다면 set도 구현해도 괜찮다.
@objc
protocol ViewPresentableProtocol {
    
    // 프로퍼티를 생성할 수 있다.
    // 최소요구조건
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()
    @objc optional func configureLabel()
    // 사용을 할수도 있고 안할수도있을 때 optional을 붙여준다.
    @objc optional func configureTextField()
}


/*
 ex. 테이블뷰의 필수 함수 2가지를 미리 작성해두고 프로토콜을 사용할 수 있다.
 // 테이블뷰를 사용할 떄 테이블뷰 델리게이트. 테이블뷰 데이터소스는 꼭 상속 받아야한다.
 */

@objc protocol KidultTableViewProtocol {
    func nuberOfRowsInSection() -> Int
    func cellForRowAt(indexPath:IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
