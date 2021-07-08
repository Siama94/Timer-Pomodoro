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
        label.text = "00:10"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.text = "Hard work"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timer = Timer()
    private lazy var durationTimerWork = 10
    private lazy var shapeLayer = CAShapeLayer()
    
    
    //MARK: - Actions
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func startButtonAction() {
        
        animation()
        
        startTimer()
        
    }
    
    @objc private func timerAction() {
        
        durationTimerWork -= 1
        
        func formatTime() -> String{
                let minutes = Int(durationTimerWork) / 60 % 60
                let seconds = Int(durationTimerWork) % 60
                return String(format:"%02i:%02i", minutes, seconds)
                
            }
        timerLabel.text = formatTime()
        
        if timerLabel.text == "00:00" {
            timerLabel.text = "00:05"
            infoLabel.text = "Rest"
            durationTimerWork = 5
            animation()
        }
    }
    
    //MARK: - Animation
    
    private func circleAnimation() {
        
        let center = CGPoint(x: circleView.frame.width / 2, y: circleView.frame.height / 2)
        let endAngle = (-CGFloat.pi / 2)
        let startAngle = 2 * CGFloat.pi + endAngle
    
        let cirlePath = UIBezierPath(arcCenter: center, radius: 138, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        shapeLayer.path = cirlePath.cgPath
        shapeLayer.lineWidth = 21
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = UIColor.blue.cgColor
        circleView.layer.addSublayer(shapeLayer)
    }
    
    
    private func animation() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 0
        animation.duration = CFTimeInterval(durationTimerWork)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = true
        shapeLayer.add(animation, forKey: "animation")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.circleAnimation()
    }
    
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
        
        view.addSubview(infoLabel)
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 325),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
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
        view.backgroundColor = .white
    }
}

    //MARK: - Actions

