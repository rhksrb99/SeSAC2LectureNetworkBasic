//
//  ViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocol{
    

    static let identifier: String = "ViewController"
    
    var backgrountColor: UIColor {
        get {
            return .blue
        }
    }
    
    var navigationTitleString: String {
        get {
            return " 대장님의 다마고치 "
        }
        set {
            title = newValue
        }
    }
    
    var backgroundColor: UIColor = .systemGray
    
    func configureView() {
        navigationTitleString = "어른이님의 다마고치"
        // 선언할 때 읽기전용이였지만.
        // 사용할 수 있다,
//        backgroundColor = .lightGray
        
        title = navigationTitleString
        view.backgroundColor = backgroundColor
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 해당 값이 helper의 nickname의 newValue에 들어간다.
        UserDefaultsHelper.shared.nickname = "어른이"
        
        // 네비게이션 타이틀에 저장된 닉네임을 띄운다는 가정
        title = UserDefaultsHelper.shared.nickname
        
        UserDefaultsHelper.shared.age = 24
        
        print(UserDefaultsHelper.shared.age)
        
    }
}

