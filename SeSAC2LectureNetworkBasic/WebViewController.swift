//
//  WebViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
//    // 프로토콜을 이용하여 화면 전환을 하기 위해
//    // 화면 전환 프로토콜을 채택하여 사용할 수 있다.
//    static var reuseIdentifier: String = String(describing: WebViewController.self)
//    // 메타 타입을 이용하여 따로 문자열을 넣어주지않고 작성할 수 있다.
    

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    // 웹킷 뷰가 실행되면 처음 연결되는 url 지정
    var destinationURL: String = "https://www.apple.com"
    // App Transport Security Settings
    // http
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openWebPage(url: destinationURL)
        searchBar.delegate = self
    }
    
    func openWebPage(url:String) {
        // 이 부분에서 웹킷 뷰가 실행됐을 떄의 코드가 실행된다.
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @IBAction func btn_goForwardClicked(_ sender: UIBarButtonItem) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    @IBAction func btn_refreshClicked(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    @IBAction func btn_goBackClicked(_ sender: UIBarButtonItem) {
        if webView.canGoBack{
            webView.goBack()
        }
    }
    
}

extension WebViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
