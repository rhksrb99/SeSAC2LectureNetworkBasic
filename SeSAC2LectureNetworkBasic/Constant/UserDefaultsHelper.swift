//
//  UserDefaultsHelper.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    
    
    
    static let shared = UserDefaultsHelper()
    
    // 유저디폴트를 간소화 시킬 수 있는 방법
    let userDefaults = UserDefaults.standard // singleton pattern 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
    // 타입 프로퍼티는 사용하는 내내 메모리에 남아있지만
    // 싱글톤 패턴을 사용하면 사용하는 순간에만 메모리에 올라간다
    
    enum Key: String {
        case nickName, age
    }
    
    // 옵셔널 해결방법 1. 옵셔널 타입으로 선언하기
    // var nickname: String? { ----- 이런 식으로!
    var nickname: String {
        get {
            // 2. 값에 대한 옵셔널 처리를 해주기
            return userDefaults.string(forKey: Key.nickName.rawValue) ?? "대장"
        }
        set {// 연산 프로퍼티 prameter
            // 저장되는 새로운 값(newValue)을 받아와서 nickName에 저장
            userDefaults.set(newValue, forKey: Key.nickName.rawValue)
        }
    }
    
    // Int, Bool은 기본값이 0, true로 지정되어 있기 때문에 옵셔널 에러가 발생하지 않는다.
    var age: Int {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
}
