//
//  SearchViewController.swift
//  Flickr Demo
//
//  Created by apple on 2020/5/25.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController {

    static let identifier = "SearchViewController"
    
    lazy var contentTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "欲搜尋內容"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        return textField
    }()
    
    lazy var perAmountTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "每頁呈現數量"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(self.textFieldDidChanged), for: .editingChanged)
        return textField
    }()
    
    lazy var searchButton: UIButton = {
       let button = UIButton()
        button.setTitle("搜尋", for: .normal)
        button.backgroundColor = .lightGray
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [contentTextField, perAmountTextField, searchButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var textFieldViewModel = TextFieldViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setUpViews()
    }
    
    private func configureUI() {
        self.title = "搜尋輸入頁"
        self.view.backgroundColor = .white
    }
    
    private func setUpViews() {
        self.view.addSubview(stackView)
        stackView.addSubview(contentTextField)
        stackView.addSubview(perAmountTextField)
        stackView.addSubview(searchButton)
        
        stackView.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.center.equalTo(view)
        }
    }
    
    @objc func buttonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: ResultViewController.identifier) as! ResultViewController
        vc.content = contentTextField.text ?? ""
        vc.amount = Int(perAmountTextField.text ?? "0") ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        contentTextField.resignFirstResponder()
        perAmountTextField.resignFirstResponder()
    }
    
    @objc func textFieldDidChanged() {
        textFieldViewModel.checkIsNotEmpty(contentTextField.text ?? "", perAmountTextField.text ?? "", completion: { (isEnabled) in
            self.searchButton.isEnabled = isEnabled
            self.searchButton.backgroundColor = isEnabled ? UIColor.defaultColor : UIColor.lightGray
            isEnabled ? self.searchButton.setBackgroundImage(UIColor.defaultColor.rectImage(with: self.searchButton.bounds.width, height: self.searchButton.bounds.height), for: .normal) : self.searchButton.setBackgroundImage(nil, for: .normal)
        }) { (isZero) in
            if isZero {
                let index = self.perAmountTextField.text?.index(self.perAmountTextField.text!.endIndex, offsetBy: -1)
                self.perAmountTextField.text = String(self.perAmountTextField.text![..<index!])
            }
        }
    }

}
