//
//  ViewController.swift
//  Pomodoro_Timer_App
//
//  Created by Dmitriy Baskakov on 29.05.2022.
//

import UIKit

class ViewController: UIViewController {
    //Create flag's
    var isWork = true
    var isStarted = false
    
    //MARK: - View's
    
    lazy var timerLabel: UILabel = {
        let timerLabel = UILabel()
        
        timerLabel.text = "01:00"
        timerLabel.font = UIFont.systemFont(ofSize: 50)
        timerLabel.textColor = .red
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return timerLabel
    }()
    
    lazy var timerButton: UIButton = {
        let timerButton = UIButton()
        
        timerButton.setBackgroundImage(UIImage(systemName: "play")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        
        return timerButton
    }()
    
    lazy var shapeView: UIImageView = {
        let shapeView = UIImageView()
        
        shapeView.image = UIImage(systemName: "circle")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        shapeView.translatesAutoresizingMaskIntoConstraints = false
        
        return shapeView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHiererchy()
        setupView()
        setupConstraint()
        
    }
    
    //MARK: - SetupHiererchy
    
    private func setupHiererchy() {
        view.addSubview(shapeView)
        
        shapeView.addSubview(timerLabel)
        shapeView.addSubview(timerButton)
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

