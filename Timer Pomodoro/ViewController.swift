//
//  ViewController.swift
//  Timer Pomodoro
//
//  Created by Анастасия on 08.07.2021.
//

import UIKit

class ViewController: UIViewController {

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Начать", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVew()
        setupLayout()
    }


    // MARK: - Settings
    
    private func setupLayout() {
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        startButton.heightAnchor.constraint(equalToConstant: 50),
        startButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupVew() {
        view.backgroundColor = .systemYellow
    }
}

