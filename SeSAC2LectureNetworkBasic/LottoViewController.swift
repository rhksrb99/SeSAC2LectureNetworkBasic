//
//  LottoViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/28.
//

import UIKit

class LottoViewController: UIViewController {
    

//    @IBOutlet weak var lottoPickerView: UIPickerView!
    @IBOutlet weak var tf_number: UITextField!
      
    //자동으로 구현된다.
    var lottoPickerView = UIPickerView()
    // 코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있다.
    
    let numberList: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 텍스트필드를 클릭했을 때 지정한 뷰가 보여짐.
        tf_number.inputView = lottoPickerView
        // 커서 숨기기
        tf_number.tintColor = .clear
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
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
        tf_number.text = "\(numberList[row])회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])번쨰"
    }
}
