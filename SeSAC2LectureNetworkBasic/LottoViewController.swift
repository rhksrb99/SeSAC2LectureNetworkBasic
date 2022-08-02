//
//  LottoViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/28.
//

import UIKit
// 애플 내부 라이브러리를 첫번째,
// 한칸 띄우고 외부 라이브러리를 알파벳 순서대로 정렬
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController {
    
    @IBOutlet var lottoNumber: [UILabel]!
    
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    @IBOutlet weak var tf_number: UITextField!
      
    //자동으로 구현된다.
    var lottoPickerView = UIPickerView()
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있다.
    
    let numberList: [Int] = Array(1...1025).reversed()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 문자의 내용중 일부를 가져와서 텍스트필드에 출력
        // 인증번호가 대표적
        tf_number.textContentType = .oneTimeCode
        
        // 텍스트필드를 클릭했을 때 지정한 뷰가 보여짐.
        tf_number.inputView = lottoPickerView
        // 커서 숨기기
        tf_number.tintColor = .clear
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        date()
        requestLotto(number: count)
        
        
    }
    
    func date() {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        format.locale = Locale(identifier: Locale.current.identifier)
        format.timeZone = TimeZone(identifier: TimeZone.current.identifier)
        let lastDate = Date()
        let firstDate = format.date(from: "20020714") ?? Date()
        
        let interval = lastDate.timeIntervalSince(firstDate)
        let result = Int(interval / 86400)
        count = Int((result/7))
        
        
    }
    
    func requestLotto(number:Int) {
        let url = "\(EndPoint.lottoURL)&drwNo=\(number)"
        AF.request(url, method: .get).validate(statusCode: 200..<400).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for i in 1...6{
                    self.lottoNumber[i-1].text = String(json["drwtNo\(i)"].intValue)
                }
                
                let bonus = json["bnusNo"].intValue
                self.lottoNumber[6].text = String(bonus)
//                print(bonus)
                
                let date = json["drwNoDate"].stringValue
//                print(date)
                
                self.tf_number.text = date
                
                
                if json["returnValue"].stringValue == "fail" {
                    // 동영님의 결과물..
//                    var newCount = self.count - 1
//                    self.count = newCount
//                    self.requestLotto(number: self.count)
                    repeat{
                        var newCount = self.count - 1
                        self.count = newCount
                        self.requestLotto(number: self.count)
                        print(newCount)
                    }while json["returnValue"].stringValue == "success"
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
    }

}


extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // 0부터 시작하기 때문에
        // 1025개를 보여줄 떈 하나 빼고.
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // 셀을 클릭했을 때도 requestLotto의 함수를 호출
        requestLotto(number: numberList[row])
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
