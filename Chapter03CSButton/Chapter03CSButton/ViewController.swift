import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 코드로 버튼 생성
        let csBtn = CSButton()
        csBtn.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        csBtn.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        self.view.addSubview(csBtn)
        
        
        // 인자값에 따라 스타일 생성 버튼 1
        let rectBtn = CSButton(type: CSButton.CSButtonType.rect)
        rectBtn.frame = CGRect(x: 30, y: 200, width: 150, height: 30)
        self.view.addSubview(rectBtn)
        
        // 초기화 이후 스타일 변경시
        rectBtn.style = .circle
        
        // 인자값에 따라 스타일 생성 버튼 2
        let circleBtn = CSButton(type: CSButton.CSButtonType.circle)
        circleBtn.frame = CGRect(x: 200, y: 200, width: 150, height: 30)
        self.view.addSubview(circleBtn)
        
        // 객체 생성
        self.createObject()
    }
    
    // 객체 생성
    func createObject(){
        
        // a객체 신규 생성
        let a = Foo(a: 1, b: 1)
        
        // s클래스 신규 생성
        let s = Boo.init()
        // s클래스 값 지정
        s.v = 100
        s.c = "SSS"
        
        // q클래스 생성 -> s클래스로 지정
        let q = s
        
        // q클래스 값 지정 : s 객체 값 변경됨 (주소값을 복사)
        q.v = 999
        q.c = "QQQ"
        
        // g클래스 생성 : Boo 클래스 상속 클래스
        let g = Too()
        
        // 객체 추가 생성
        let i = Boo()
        
        // 객체 추가 생성
        let z = Boo.init()
        
        print("a = \(a)")                                   //   a = Foo(a: 1, b: 1)
        print("s = \(s) int : \(s.v) String : \(s.c)")  // s = int : 999 String : QQQ
        print("q = \(q) int : \(q.v) String : \(q.c)")  // q = int : 999 String : QQQ
        print("s = \(s) int : \(s.v) String : \(s.c)")  // s = int : 999 String : QQQ
        print("g = \(g) Boo int : \(g.v) Boo String : \(g.c) Boo String : \(g.d)" )  // s = int : 0 String : nil
        print("i = \(i) int : \(i.v) String : \(i.c)")  // z = int : 0 String :
        print("z = \(z) int : \(z.v) String : \(z.c)")  // z = int : 0 String :
        
    }


    
    // 객체 생성
    struct Foo {
        var a: Int
        var b: Int = 0
        
         init(a: Int, b: Int) {
            self.a = a
            self.b = b
        }
    }
    
    class Boo {
        var v: Int = 0
        var c: String = ""
    }
    
    
    class Too : Boo {
        var d : Int?
        
        override init() {
//            super.init()
        }
    }
}

