    
extension UIViewController {
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier:name)
    }
    
    
    func alert(_ message: String, completion: (()->Void)? = nil){
        // 메인 스레드에서 실행도록
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.cancel, handler: { (_) in
                completion?()
            })
            
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
}
