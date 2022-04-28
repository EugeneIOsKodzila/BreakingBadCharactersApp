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
            loginTextField.delegate = self
            loginTextField.placeholder = Constants.loginPlaceholder
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
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
        setupKeyboardHeight()
    }
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        if (loginTextField.text?.isValidEmail)! {
            print("Email goood")
        } else {
            let alert = UIAlertController(title: "Не правильный формат", message: "Попробуй example@mail.ru", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func acceptTermsSwitch(_ sender: UISwitch) {
        checkInput()
    }
    @IBAction func loginEditText(_ sender: UITextField) {
        checkInput()
    }
    @IBAction func passswordEditText(_ sender: UITextField) {
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

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
}

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[a-zA-Z0-9._]{1,30}+@[a-zA-Z0-9]{1,10}+\\.[a-zA-Z]{1,10}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
