//
//  LocationViewController.swift
//  SeSAC2LectureNetworkBasic
//
//  Created by 박관규 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController{
    
    
//    static var reuseIdentifier: String = String(describing: LocationViewController.self)
//    // LocationViewController.self = 메타 타입 -> "LocationViewController"
//    // 위와같이 작성하면 "LocationViewController"를 가져온다.
//    // 메타 타입을 이용하여 따로 문자열을 넣어주지않고 작성할 수 있다.
//    // 코드에 문자열을 많이 넣어주지 않는게 좋다. (오류방지)
    

    // 로컬 노티피케이션을 담당하는 기능을 한가지 가져온다.
    // Notification 1.      UN = UserNotification의 약자
    let notificationCenter = UNUserNotificationCenter.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Font
        for family in UIFont.familyNames {
            print("=============\(family)============")
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
            
        }
        
        // 해당 부분에서 호출하면 화면이 떴을 때 바로 알람을 보낼 수 있고
        requestAuthorization()
        
    }
    @IBAction func btn_notification(_ sender: UIButton) {
        
        // 해당 부분에서 호출하면 버튼이 눌렸을 떄 알람을 보낼 수 있다.
//        requestAuthorization()
        sendNotification()
        
        
    }
    
    // Notification 2. 권한요청
    // removePendding = 한번에 쌓여있는 알림을 없애는 기능
    func requestAuthorization() {
        // 아래의 코드 옵션 부분에 들어가야 할 내용을 미리 상수로 선언.
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            // 만약 성공했다면?
            if success {
                // 함수 내부에 함수를 사용하기 때문에 self.가 붙어야한다.
                self.sendNotification()
            }
        }
    }
    
    /*
     - 권한을 허용 해야만 알림이 온다.
     - 권한 허용 문구는 시스템적으로 최초 한번만 뜬다.
     - 허용 안된 경우 애플 설정으로 직접 유도하는 코드를 구성 해야한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다.
     - 로컬 알림에서 60초 이상 반복 가능하다. / 갯수 제한 64개 / 커스텀 사운드 30초까지 가능하다.
     
     
     1. 벳지 제거? -> SceneDelegate에서 액티브 상태를 확인하여 뱃지를 제거할 수 있다.
     2. 노티 제거? -> 노티의 유효기간은? 별도 설정이 없다면 한달이 기본이다.
     3. 포그라운드 수신? -> AppDelegate에서 새로운 함수를 생성하여 사용할 수 있다.
    
     +alpha ( 개발자 계정이 있어야한다! )
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     - 포그라운드 수신 -> 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 받고싶다면?
     - iOS15부터 등장한 집중모드에서 5~6개의 앱에 알림 우선순위를 설정할 수 있다.
     */
    
    // Notification 3. 권한 허용한 사용자에게 알림 요청 (언제? 어떤 컨텐츠를?)
    // iOS 시스템에서 알림을 담당 -> 알림 등록
    func sendNotification() {
        
        let notificationContent = UNMutableNotificationContent()
        
        // 어떤 내용인지에 대한 content
        // title == bold
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: 1...100))입니다."
        notificationContent.body = "저는 따끔따끔 다마고치 입니다. 배고파요!"
        // badge에 표시 될 숫자?
        notificationContent.badge = 40
        
        // 언제 보낼지에 대한 trigger 설정 1. 시간 간격, 2. 캘린더, 3. 위치에 따라 설정 가능
        // 시간 간격은 60초 이상 설정해야 반복이 가능하다. == 반복시간을 60이상 하거나 반복을 하지 않으면 된다.
        // 하루에 한번만 보낸다면 86400을 넣어주면된다.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//        var dateComponents = DateComponents()
//        dateComponents.minute = 15
//
//        let trigger  = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // 알림 요청 notificationContent와 trigger를 사용하여 보내 줄 알림 내용.
        // identifier가 동일하다면 하나의 스택에 쌓이지만
        // 다르다면? 하나씩 스택의 구조로 쌓이게 된다.
        // 만약 알림 관리 할 필요가 없다면? 알림 클릭하면 앱을 켜주는 기능으로 마무리 할 수 있다.
        // 만약 알리 관리가 필요하다면? 알림 클릭하면 +1을 해준다거나, 교유한 이름, 규칙 등을 지정해줘야한다.
        // identifier:
        let request = UNNotificationRequest(identifier: "kidult", content: notificationContent, trigger: trigger)
        
        // 최종적으로 알림센터에 추가를 해줘야한다.
        notificationCenter.add(request)
        // 알림의 권한 성공 여부를 따져 실패시의 동작도 구현할 수 있다.
//        notificationCenter.add(request) { error in
//            print()
//        }
        
    }
    
}
