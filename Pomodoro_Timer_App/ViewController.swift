//
//  ViewController.swift
//  Pomodoro_Timer_App
//
//  Created by Dmitriy Baskakov on 29.05.2022.
//

import UIKit

class ViewController: UIViewController {
    //Create flag's
    static var isWork = true
    static var isStarted = true
    static var color = UIColor.red
    
    //MARK: - View's
    
    lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        
        timerLabel.text = "\(formattedTime())"
        timerLabel.font = UIFont.systemFont(ofSize: 50)
        timerLabel.textColor = ViewController.color
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return timerLabel
    }()
    
    lazy var timerButton: UIButton = {
        let timerButton = UIButton()
        
        timerButton.setBackgroundImage(UIImage(systemName: "play")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        
        return timerButton
    }()
    
    lazy var shapeView: UIImageView = {
        let shapeView = UIImageView()
        
        shapeView.image = UIImage(systemName: "circle")?.withTintColor(.systemGray6, renderingMode: .alwaysOriginal)
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        
        return shapeView
    }()
    
    var timer = Timer()
    
    let shapeLayer = CAShapeLayer()
    
    var timeDuration = 30
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animationCircular()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHiererchy()
        setupView()
        setupConstraint()
        
        timerButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Timer Action's
    @objc private func startButtonTapped() {
        if ViewController.isStarted {
            
            basicAnimationShapeView()
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            ViewController.isStarted = false
            timerButton.setBackgroundImage(UIImage(systemName: "pause")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            
            stopAnimationShapeView()
            
            timer.invalidate()
            
            ViewController.isStarted = true
            timerButton.setBackgroundImage(UIImage(systemName: "play")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
    @objc private func timerAction() {
        timeDuration -= 1
        timerLabel.text = formattedTime()
        
        if timeDuration == 0 {
            if ViewController.isWork {
                restChange()
            } else {
                workChange()
            }
        }
    }
    
    private func formattedTime() -> String {
        let minute = timeDuration / 60 % 60
        let second = timeDuration % 60
        
        return String(format: "%02i:%02i", minute, second)
    }
    
    private func restChange() {
        timeDuration = 10
        ViewController.color = UIColor.systemGreen
        timerLabel.textColor = ViewController.color
        timerButton.setBackgroundImage(UIImage(systemName: "pause")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        ViewController.isWork = false
        
        basicAnimationShapeView()
    }
    
    private func workChange() {
        timeDuration = 30
        ViewController.color = UIColor.red
        timerLabel.textColor = ViewController.color
        timerButton.setBackgroundImage(UIImage(systemName: "pause")?.withTintColor(ViewController.color, renderingMode: .alwaysOriginal), for: .normal)
        ViewController.isWork = true
        
        basicAnimationShapeView()
    }
    
    //MARK: - Animation Action's
    
    private func animationCircular() {
        let centerShapeView = CGPoint(x: shapeView.frame.width / 2, y: shapeView.frame.height / 2)
        let endAngleShapeView = (-CGFloat.pi / 2)
        let startAngleShapeView = 2 * CGFloat.pi + endAngleShapeView
        
        let circularPath = UIBezierPath(arcCenter: centerShapeView, radius: 120, startAngle: startAngleShapeView, endAngle: endAngleShapeView, clockwise: false)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = 25
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = ViewController.color.cgColor
        shapeView.layer.addSublayer(shapeLayer)
        
    }
    
    private func basicAnimationShapeView() {
        let basicAnimationShapeView = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimationShapeView.toValue = 0
        basicAnimationShapeView.duration = CFTimeInterval(timeDuration)
        basicAnimationShapeView.fillMode = CAMediaTimingFillMode.forwards
        basicAnimationShapeView.isRemovedOnCompletion = true
        shapeLayer.add(basicAnimationShapeView, forKey: "basicAnimationShapeView")
    }
    
    private func stopAnimationShapeView() {
        if let strokeEnd = shapeLayer.presentation()?.strokeEnd {
            shapeLayer.strokeEnd = strokeEnd
            shapeLayer.removeAllAnimations()
        }
    }
    //MARK: - SetupHiererchy
    
    private func setupHiererchy() {
        view.addSubview(shapeView)
        view.addSubview(timerButton)
        
        shapeView.addSubview(timerLabel)
        
    }
    
    //MARK: -SetupView
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    //MARK: -SetupCinstraint
    
    private func setupConstraint() {
        shapeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shapeView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        shapeView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        shapeView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        timerLabel.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor).isActive = true
        timerLabel.topAnchor.constraint(equalTo: shapeView.topAnchor, constant: 100).isActive = true
        
        timerButton.centerXAnchor.constraint(equalTo: shapeView.centerXAnchor).isActive = true
        timerButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20).isActive = true
        timerButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

