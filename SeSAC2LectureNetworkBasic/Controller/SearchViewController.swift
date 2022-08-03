//
//  SearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON

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
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    // 타입 어노테이션 vs 타입추론 = 누가 더 속도가 빠를지.
    // 타입 어노테이션이 속도는 아주 조금 빠르지만
    // 타입 추론으로 편하게 사용하는건 어떨까?
    var nickname: String = ""
    var username = ""
    
    // BoxOffice를 담을 배열
    var list: [BoxOfficeModel] = []
    var defaultDate = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        searchTableView.backgroundColor = .clear
        // 연결고리 작업: 테이블 뷰가 해야 할 역할 -> 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        // 테이블뷰가 사용할 테이블뷰 셀(XIB) 등록
        // XIB : xml interface builder <=> Nib
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        searchBar.delegate = self
        date()
        // 어제 날짜 가져와서 넘버에 넣어주기.------------------------------
        requestBoxOffice(number: defaultDate)
    }
    
    func date(){
        let today = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        format.locale = Locale(identifier: Locale.current.identifier)
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)

        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)
        
        defaultDate = format.string(from: yesterday!)
        
        print(defaultDate)
        
        
    }
    
    func requestBoxOffice(number: String) {
        list.removeAll()
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(number)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                        
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    let rank = movie["rank"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc, rank: rank)
                    
                    self.list.append(data)
                }
                print(self.list)
                
                self.searchTableView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 50
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.lb_title.font = .boldSystemFont(ofSize: 18)
        cell.lb_title.text = "\(list[indexPath.row].movieTitle)"
        cell.lb_rank.text = "\(list[indexPath.row].rank)"
        cell.lb_total.text = "\(list[indexPath.row].totalCount)명"
        
        return cell
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(number: searchBar.text!) // 옵셔널 바인딩, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인지? 등
    }
}
