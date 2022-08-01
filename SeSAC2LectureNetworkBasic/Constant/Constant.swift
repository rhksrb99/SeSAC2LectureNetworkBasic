//
//  Constant.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/08/01.
//

import Foundation


//enum StoryboardName: String {
//    case Main
//    case Search
//    case Setting
//}

// StoryboardName.Main.rawValue

struct StoryboardName {

// 접근제어를 통해 초기화 방지
    // private이 붙으면 해당 코드 내에서만 사용된다.
    // 다른 파일에서 접근이 불가능해진다.
    private init() {
        
    }

    static let main = "Main"
    static let search = "Search"
    static let setting = "Setting"
}

// StoryboardName.search

// 열거형은 인스턴스를 만들지못한다.
// 그렇기 때문에 타입 프로퍼티를 사용해야한다.
// 열거형 내부에 타입 프로퍼티를 사용하는 구조
/*
 1. struct내에서 타입프로퍼티를 사용하는 것과 enum내에서 타입프로퍼티를 사용하는 것 -> 인스턴스 생성 방지
 2. enum에서 case를 사용하는 것과 enum에서 static을 사용하는 것 -> 중복된 내용을 하드코딩할 수 있는지 없는지, case의 사용에 제약이 있다.
 
 */
//enum StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}

// 3가지의 영역에서 폰트를 사용한다는 가정
enum FontName {
//    case title = "SanFransisco"
//    case body = "SanFransisco"
//    case caption = "AppleSandol"
    static let title = "SanFransisco"
    static let body = "SanFransisco"
    static let caption = "AppleSandol"
}
