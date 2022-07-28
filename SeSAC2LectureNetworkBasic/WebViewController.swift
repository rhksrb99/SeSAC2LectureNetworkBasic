//
//  WebViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/28.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    var destinationURL: String = "https://www.apple.com"
    // App Transport Security Settings
    // http
    
    override func viewDidLoad() {
        super.viewDidLoad()

        openWebPage(url: destinationURL)
        searchBar.delegate = self
    }
    
    func openWebPage(url:String) {
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
