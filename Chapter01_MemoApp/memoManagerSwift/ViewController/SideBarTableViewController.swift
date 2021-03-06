import UIKit

class SideBarTableViewController: UITableViewController {
    
    let uinfo = UserInfoManager()
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    
    let icons = [
        UIImage(named: "icon01.png"),
        UIImage(named: "icon02.png"),
        UIImage(named: "icon03.png"),
        UIImage(named: "icon04.png"),
        UIImage(named: "icon05.png"),
        UIImage(named: "icon06.png")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 헤더뷰 생성
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.brown
        
        // 이름 라벨 생성
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
//        self.nameLabel.text = "꼼꼼이"
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.nameLabel.backgroundColor = UIColor.clear
        
        headerView.addSubview(self.nameLabel)
        
        // 이메일 생성
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30)
//        self.emailLabel.text = "123@gmail.com"
        self.emailLabel.textColor = UIColor.white
        self.emailLabel.font = UIFont.boldSystemFont(ofSize: 11)
        self.emailLabel.backgroundColor = UIColor.clear
        
        headerView.addSubview(self.emailLabel)
        
        //기본 이미지 생성
//        let defaultProfile = UIImage(named: "account.jpg")
//        self.profileImage.image = defaultProfile
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width/2)
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        view.addSubview(self.profileImage)
        
        self.tableView.tableHeaderView = headerView

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        self.emailLabel.text = self.uinfo.account ?? ""
        self.profileImage.image = self.uinfo.profile
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let id = "menicell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: id)
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell

    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if titles[indexPath.row] == titles[0] {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            let target = self.revealViewController().frontViewController as! UINavigationController
            target.pushViewController(uv!, animated: true)
            self.revealViewController().revealToggle(self)
        }else if titles[indexPath.row] == titles[4]  {
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            self.present(uv!, animated: true) {
                self.revealViewController().revealToggle(self)
            }
        }
    }

}
