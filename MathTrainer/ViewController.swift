//
//  ViewController.swift
//  MathTrainer
//
//  Created by Даниил Сивожелезов on 21.05.2024.
//

import UIKit

enum MathType: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet var signLabels: [UILabel]!
    
    // MARK: - Properties
    private var selectedType: MathType = .add
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
    }
    // MARK: - IBActions
    @IBAction func buttonsAction(_ sender: UIButton) {
        selectedType = MathType(rawValue: sender.tag) ?? .add
        performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) {
        guard let sourceVC = unwindSegue.source as? TrainViewController else { return }
        signLabels.forEach { label in
            if selectedType.rawValue == label.tag {
                label.text = sourceVC.scoreLabel.text
            }
        }
    }
    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func configureButtons() {
        // Add shadow
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 3)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
}

