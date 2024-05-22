//
//  TrainViewController.swift
//  MathTrainer
//
//  Created by Даниил Сивожелезов on 21.05.2024.
//

import UIKit

final class TrainViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var problemLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    var type: MathType = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var firstNumber: Int = 0
    private var secondNumber: Int = 0
    private var sign: String = ""
    private var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureQuestion()
        configureButtons()
    }
    
    // MARK: - IBAction
    @IBAction func leftButtonAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    @IBAction func rightButtonAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    
    // MARK: - Methods
    private func configureButtons() {
        let buttonsArray = [leftButton, rightButton]
        
        buttonsArray.forEach { button in
            button?.backgroundColor = .systemYellow
        }
        
        buttonsArray.forEach { button in
            button?.layer.shadowColor = UIColor.darkGray.cgColor
            button?.layer.shadowOffset = CGSize(width: 0, height: 3)
            button?.layer.shadowOpacity = 0.4
            button?.layer.shadowRadius = 3
        }
        
        let isRightButton = Bool.random()
        
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while answer == randomAnswer
        
        rightButton.setTitle(isRightButton ? String(answer) : String(randomAnswer), for: .normal)
        leftButton.setTitle(isRightButton ? String(randomAnswer) : String(answer), for: .normal)
    }
    private func getNumbers() {
        firstNumber = Int.random(in: 1...99)
        secondNumber = Int.random(in: 1...99)
    }
    
    private func configureQuestion() {
        
        switch type {
        case .divide:
            repeat {
                getNumbers()
            } while firstNumber % secondNumber != 0
        default:
            getNumbers()
        }
        
        let question = "\(firstNumber) \(sign) \(secondNumber) ="
        problemLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            let isSecondAttempt = leftButton.backgroundColor == .red || rightButton.backgroundColor == .red
            score += isSecondAttempt ? 0 : 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
}
