import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
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
        loginTextField.delegate = self
        passwordTextField.delegate = self
        setupSwitch()
        setupKeyboardHeight()
    }
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
    }
    @IBAction func acceptTermsSwitch(_ sender: UISwitch) {
        checkInput()
    }
    
    private func setupSwitch() {
        switcher.isOn = false
        switcher.onTintColor = UIColor.red
        switcher.thumbTintColor = UIColor.black
        switcher.subviews[0].subviews[0].backgroundColor = UIColor.white
    }
    
    private func checkInput() {
        guard let textLogin = loginTextField.text, let textPassword = passwordTextField.text else {
            return
        }
        enterButton.isEnabled = switcher.isOn && !textLogin.isEmpty && !textPassword.isEmpty
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkInput()
    }
    
    // MARK: - Notification Center
    
    private func setupKeyboardHeight() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = -100
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 0.0
        }
    }
}

