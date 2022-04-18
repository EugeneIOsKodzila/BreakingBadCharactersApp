//
//  ViewController.swift
//  TestWorkSiberian


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
    }
  
    @IBAction func enterButtonPressed(_ sender: Any) {
    }
    @IBAction func acceptTermsSwitch(_ sender: Any) {
    }
    
    private func setupSwitch() {
        switcher.isOn = false
        switcher.onTintColor = UIColor.red
        switcher.thumbTintColor = UIColor.black
        switcher.subviews[0].subviews[0].backgroundColor = UIColor.white
    }
}

