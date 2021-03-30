//  ViewController.swift
//  Calculator
//
//  Created by Carlos Salazar on 1/24/21.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var firstNumber: Double = 0.00
    var resultNumber: Double = 0.00
    //By default, we have no operation
    var currentOperations: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica-Bold", size: 90)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }

    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
        zeroButton.setTitleColor(.black, for: .normal)
        
        if (zeroButton.isSelected) {
            zeroButton.backgroundColor = UIColor.red
        } else {
            zeroButton.backgroundColor = .white
        }
        
        zeroButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        zeroButton.layer.cornerRadius = 4
        zeroButton.layer.borderWidth = 1
        zeroButton.setTitle("0", for: .normal)
        
        zeroButton.tag = 1 //Tag for button will be 0
        zeroButton.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        holder.addSubview(zeroButton)
        
        for x in 0..<3 {
            let button1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 2), width: buttonSize, height: buttonSize))
            button1.setTitleColor(.black, for: .normal)
            
            if (!button1.isSelected) {
                button1.backgroundColor = .white
            } else if (button1.isSelected) {
                button1.backgroundColor = .red
            }
            
            button1.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
            button1.layer.cornerRadius = 4
            button1.layer.borderWidth = 1
            button1.setTitle("\(x+1)", for: .normal)
            
            button1.tag = x + 2 //Tag for buttons will be 1-3
            button1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button1)
        }
        
        for x in 0..<3 {
            let button2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 3), width: buttonSize, height: buttonSize))
            button2.setTitleColor(.black, for: .normal)
            button2.backgroundColor = .white
            button2.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
            button2.layer.cornerRadius = 4
            button2.layer.borderWidth = 1
            button2.setTitle("\(x+4)", for: .normal)
            
            button2.tag = x + 5 //Tags for buttons will be 4-6
            button2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button2)
        }
        
        for x in 0..<3 {
            let button3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 4), width: buttonSize, height: buttonSize))
            button3.setTitleColor(.black, for: .normal)
            button3.backgroundColor = .white
            button3.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
            button3.layer.cornerRadius = 4
            button3.layer.borderWidth = 1
            button3.setTitle("\(x+7)", for: .normal)
            
            button3.tag = x + 8 //Tags for buttons will be 7-9
            button3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(button3)
        }
        
        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonSize * 5), width: view.frame.size.width - buttonSize, height: buttonSize))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .white
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        clearButton.layer.cornerRadius = 4
        clearButton.layer.borderWidth = 1
        clearButton.setTitle("Clear all", for: .normal)
        holder.addSubview(clearButton)
        
        let operations = ["=","➕", "➖", "✖️", "➗"]
        
        
        for x in 0..<5 {
            let button4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height - (buttonSize * CGFloat(x + 1)), width: buttonSize, height: buttonSize))
            button4.setTitleColor(.darkGray, for: .normal)
            button4.backgroundColor = .orange
            button4.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.bold)
            button4.layer.cornerRadius = 4
            button4.layer.borderWidth = 1
            button4.setTitle(operations[x], for: .normal)
            holder.addSubview(button4)
            button4.tag = x + 1
            button4.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
        }
        
        resultLabel.frame = CGRect(x: -20, y: clearButton.frame.origin.y - (holder.frame.size.height / 6), width: view.frame.size.width, height: 100)
        holder.addSubview(resultLabel)
        
        
        //Actions
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }
    
    //@objc is required for selectors to get called
    @objc func clearResult() {
        resultLabel.text = "0"
        
        //Without this, the second number will be in the first number, ruining the calculation
        currentOperations = nil
        firstNumber = 0.00
    }
    
    @objc func numberPressed(_ sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        } else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
            resultLabel.adjustsFontSizeToFitWidth = true
        }
    }
    
    @objc func operationPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if let text = resultLabel.text, let value = Double(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
        if tag == 1 {
            if let operation = currentOperations {
                var secondNumber = 0.00
                
                if let text = resultLabel.text, let value = Double(text) {
                    secondNumber = value
                }

                
                switch operation {
                case .add:
                    let result = firstNumber + secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .subtract:
                    let result = firstNumber - secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .multiply:
                    let result = firstNumber * secondNumber
                    resultLabel.text = "\(result)"
                    break
                case .divide:
                    let result = firstNumber / secondNumber
                    resultLabel.text = "\(result)"
                    break
                }
            }
            
        } else if tag == 2 {
            currentOperations = .add
            
        } else if tag == 3 {
            currentOperations = .subtract
            
        } else if tag == 4 {
            currentOperations = .multiply
            
        } else if tag == 5 {
            currentOperations = .divide
        }
        
    }
}
