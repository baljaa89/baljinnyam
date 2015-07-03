import UIKit

class AccountController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var backButton = UIBarButtonItem(title: "戻る", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
