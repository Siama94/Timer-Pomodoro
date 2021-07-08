//
//  ViewController.swift
//  Timer Pomodoro
//
//  Created by Анастасия on 08.07.2021.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Elements
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Начать", for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var circleView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Circle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var timerLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 60)
        label.text = "10"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timer = Timer()
    private lazy var durationTaimer = 25
    
    
    //MARK: - Actions
    
    @objc private func startButtonAction() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction() {
        
        durationTaimer -= 1
        timerLabel.text = "\(durationTaimer)"
        
        if durationTaimer == 0 {
            timer.invalidate()
        }
        
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVew()
        setupHierarchy()
        setupLayout()
    }


    // MARK: - Settings
    
    private func setupHierarchy() {
        
        view.addSubview(startButton)
    }
    
    private func setupLayout() {
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 45),
            startButton.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        view.addSubview(circleView)
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            circleView.heightAnchor.constraint(equalToConstant: 300),
            circleView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        circleView.addSubview(timerLabel)
        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
        ])
    }
    
    private func setupVew() {
        view.backgroundColor = .systemYellow
    }
}

    //MARK: - Actions

