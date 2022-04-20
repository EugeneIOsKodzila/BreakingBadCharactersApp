import UIKit

class ViewController: UIViewController {
    
    enum Constants {
        static let mainTitle = "Мое приложение"
        static let termsTitle = "Согласен с условиями"
        static let loginPlaceholder = "Введите логин"
        static let passwordPlaceholder = "Введите пароль"
        static let enterTitle = "Войти"
    }

    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.image = UIImage(named: "background")
        }
    }
    @IBOutlet weak var mainLabel: UILabel! {
        didSet {
            mainLabel.text = Constants.mainTitle
        }
    }
    @IBOutlet weak var loginTextField: UITextField! {
        didSet {
            loginTextField.placeholder = Constants.loginPlaceholder
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.placeholder = Constants.passwordPlaceholder
        }
    }
    @IBOutlet weak var enterButton: UIButton! {
        didSet {
            enterButton.setTitleColor(.black, for: .normal)
            enterButton.setTitle(Constants.enterTitle, for: .normal)
            enterButton.isEnabled = false
        }
    }
    @IBOutlet weak var termsLabel: UILabel! {
        didSet {
            termsLabel.text = Constants.termsTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       print("Привет Женя, все работает")
        setupSwitch()
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -100
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0.0
        }
    }
  
    @IBAction func enterButtonPressed(_ sender: UIButton) {
    }
    @IBAction func acceptTermsSwitch(_ sender: UISwitch) {
        if sender.isOn && !loginTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            enterButton.isEnabled = true
        }else{
            enterButton.isEnabled = false
        }
    }
    
    private func setupSwitch() {
        switcher.isOn = false
        switcher.onTintColor = UIColor.red
        switcher.thumbTintColor = UIColor.black
        switcher.subviews[0].subviews[0].backgroundColor = UIColor.white
    }
}

