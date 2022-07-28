//
//  TranslateViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/28.
//

import UIKit

// UIButton, UITextField -> Action이 가능하다
// UITextView, UISearchBar, UIPickerView -> Action 사용이 불가능하다
// UIController
// UIResponderChain -> resignFirstResponder(), becomeFirstResponder()



class TranslateViewController: UIViewController {

    @IBOutlet weak var tf_userInput: UITextView!
    
    let tvPlaceholerText = "번역하고 싶은 문장을 작성해보세요"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tf_userInput.delegate = self
        
        placeHolder(tv: tf_userInput)
        
    }
    
    func placeHolder(tv:UITextView) {
        tv.text = tvPlaceholerText
        tv.textColor = .lightGray
    }
}


extension TranslateViewController:UITextViewDelegate {
    // 텍스트뷰의 텍스트가 변할 때마가 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    // 편집이 시작될 떄, 커서가 시작될 때
    // 텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
        
    }
    
    // 편집이 끝났을 때, 커서가 없어지는 순간
    // 텍스트뷰 글자: 사용자가 아무 글자도 안썼으면 플레이스 홀더 글자 보이게 하도록!
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        
        if textView.text.isEmpty {
            placeHolder(tv: textView)
        }
    }
    
}
