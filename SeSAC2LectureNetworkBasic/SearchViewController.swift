//
//  SearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/27.
//

import UIKit

/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 위의 2가지 protocol을 가져와야한다.
 */

// extension을 이용하여 색 지정
//extension UIViewController {
//
//    func setBackgroundColor() {
//        view.backgroundColor = .systemIndigo
//    }
//
//}


// uiview를 이용하여 tableview를 생성하면 delegate와 datasource를 가져와와 사용할 수 있다.
class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchTableView.backgroundColor = .clear
        // 연결고리 작업: 테이블 뷰가 해야 할 역할 -> 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB : xml interface builder <=> Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)
        
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 50
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        cell.lb_title.font = .boldSystemFont(ofSize: 22)
        cell.lb_title.text = "Hello World!"
        
        return cell
    }
    
}
