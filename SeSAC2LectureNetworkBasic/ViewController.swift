//
//  ViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/27.
//

import UIKit

class ViewController: UIViewController, ViewPresentableProtocol{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

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
    

}

