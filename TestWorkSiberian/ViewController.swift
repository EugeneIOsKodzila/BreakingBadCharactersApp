//
//  ViewController.swift
//  TestWorkSiberian


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switcher: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
       print("Привет Женя, все работает")
        setupSwitch()
        
    }
  
    func setupSwitch() {
        switcher.isOn = false
        switcher.onTintColor = UIColor.red
        switcher.thumbTintColor = UIColor.black
        switcher.subviews[0].subviews[0].backgroundColor = UIColor.white
    }
    
}

