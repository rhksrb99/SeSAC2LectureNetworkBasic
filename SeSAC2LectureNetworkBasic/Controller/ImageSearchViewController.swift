//
//  ImageSearchViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON

class ImageSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var snackCollectionVIew: UICollectionView!
    
    var count = 0
    var urlList:[Snack] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        snackCollectionVIew.delegate = self
        snackCollectionVIew.dataSource = self
        snackCollectionVIew.register(UINib(nibName: ImageSearchCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier)

        designCollectionView()
        
        fetchImage()
        // Do any additional setup after loading the view.
        
    }
    
    // fetchImage, requestImage, callRequestImage, getImage... > response에 따라 네이밍을 설정해주기도 함.
    // 내일 > 페이지네이션
    func fetchImage() {
        let text = "과자".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = EndPoint.imageSearchURL + "query=\(text)&display=30&start=31"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret":APIKey.NAVER_SECRET]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                let countValue = json["display"].intValue
                self.count = countValue
                var data:Snack
//                for snack in 0...countValue {
//                    guard let thumbnail = URL(string: json["items"][snack]["thumbnail"].stringValue) else {return}
//                    data = Snack(thumbnail: thumbnail)
//
//                    self.urlList.append(data)
//                }
                for snack in json["items"].arrayValue {
                    let thumbnail = URL(string: snack["thumbnail"].stringValue)!
                    data = Snack(thumbnail: thumbnail)
                    
                    self.urlList.append(data)
                }
                print(self.urlList)
//                print(self.urlList)
                // 값은 가져와서 리스트에 넣어지는데 포문 밖에서 리스트를 출력하면 출력이 안됨.
                // 일단 값은 가져옴.. 일단..
                self.snackCollectionVIew.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func designCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        snackCollectionVIew.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .clear
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: self.urlList[indexPath.item].thumbnail) {
                DispatchQueue.main.async {
                    cell.img_main.image = UIImage(data: data)
                }
            }
        }
        
        return cell
    }
    
    
}
