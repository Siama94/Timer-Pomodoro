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
    
    private lazy var timerLabelWork: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 60)
        label.text = formatTime()
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
    private lazy var isTimerStarted = false
    private lazy var isAnimationStarted = false
    private lazy var isWorkedTime = true
    private lazy var durationTimer = 10
    private lazy var shapeLayer = CAShapeLayer()
    
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
        shapeLayer.strokeColor = UIColor.orange.cgColor
        circleView.layer.addSublayer(shapeLayer)
    }
    
    private func animation() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1
        animation.toValue = 0
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = true
        animation.duration = CFTimeInterval(durationTimer)
        shapeLayer.add(animation, forKey: "animation")
        isAnimationStarted = true
    }
    
    private func pauseAnimation() {
        let pauseTime = shapeLayer.convertTime(CACurrentMediaTime(), from: nil)
        shapeLayer.speed = 0.0
        shapeLayer.timeOffset = pauseTime
    }

    private func resumeAnimation() {
        let pausedTime = shapeLayer.timeOffset
        shapeLayer.speed = 1.0
        shapeLayer.timeOffset = 0.0
        shapeLayer.beginTime = 0.0
        let timeSincePaused = shapeLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        shapeLayer.beginTime = timeSincePaused
    }

    private func startAndResumeAnimation() {
        if !isAnimationStarted {
            animation()
        } else {
            resumeAnimation()
        }
    }

    
    //MARK: - Actions
    
    private func startTimer() {
        startAndResumeAnimation()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(tickTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func tickTimer() {
        durationTimer -= 1
        timerLabelWork.text = formatTime()
        timerAction()
    }
    
    
    @objc private func startButtonAction() {
      
        
        if !isTimerStarted {
            
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Пауза", for: .normal)
            
        } else {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Продолжить", for: .normal)
            pauseAnimation()
        }
    }
    
    private func formatTime() -> String{
        let minutes = Int(durationTimer) / 60 % 60
        let seconds = Int(durationTimer) % 60
        return String(format:"%02i:%02i", minutes, seconds)
        
    }
    
    @objc private func timerAction() {
        
        if timerLabelWork.text == "00:00" && infoLabel.text == "Hard work" {
            
            durationTimer = 5
            timerLabelWork.text = formatTime()
            infoLabel.text = "Rest"
            isAnimationStarted = false
            
            isTimerStarted = false
            isWorkedTime = false
        }
        
        if timerLabelWork.text == "00:00" && infoLabel.text == "Rest" {
            
            durationTimer = 10
            timerLabelWork.text = formatTime()
            infoLabel.text = "Hard work"
            isAnimationStarted = false
            
            isTimerStarted = false
            isWorkedTime = true
            
        }
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
        view.addSubview(infoLabel)
        view.addSubview(circleView)
        circleView.addSubview(timerLabelWork)
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
        
        circleView.addSubview(timerLabelWork)
        NSLayoutConstraint.activate([
            timerLabelWork.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            timerLabelWork.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
        ])
    }
    
    private func setupVew() {
        view.backgroundColor = .white
    }
}
