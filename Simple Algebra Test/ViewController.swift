//
//  ViewController.swift
//  Simple Algebra Test
//
//  Created by Prato Das on 2017-08-16.
//  Copyright © 2017 Prato Das. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var lblQuestionOUTLET: UILabel!
    @IBOutlet weak var txtInputOUTLET: ShakingTextField!
    @IBOutlet weak var lblRightorWrongOUTLET: UILabel!
    @IBOutlet weak var btnCheckOUTLET: UIButton!
    @IBOutlet weak var btnStartOUTLET: UIButton!
    @IBOutlet weak var btnQuitOUTLET: UIButton!
    @IBOutlet weak var sldMaximumOUTLET: UISlider!
    @IBOutlet weak var lblMaximumOUTLET: UILabel!
    
    var randomNumber1: Int?
    var randomNumber2: Int?
    var inputNumber: Int?
    var progress: Int = 0
    var score: Int = 0
    var questionsAttempted: Int = 0
    var result: Int?
    var questionFormat: Int?
    var operationFormat: Int?
    var correctAnswer: Int?
    var operation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyView()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        txtInputOUTLET.delegate = self
        
        lblQuestionOUTLET.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.addPulse))
        tapGestureRecognizer.numberOfTapsRequired = 1
        lblQuestionOUTLET.addGestureRecognizer(tapGestureRecognizer)
        
        sldMaximumOUTLET.minimumValue = 1
        sldMaximumOUTLET.maximumValue = 7
        
        sldMaximumOUTLET.value = 3
        lblMaximumOUTLET.text = String(Int(exp(sldMaximumOUTLET.value)))
        animate()
        
        lblQuestionOUTLET.center.x = self.view.frame.width - 60
        txtInputOUTLET.center.x = self.view.frame.width + 30
        btnCheckOUTLET.center.x = self.view.frame.width - 60
        lblRightorWrongOUTLET.center.x = self.view.frame.width + 30
        let centerOfSlider = sldMaximumOUTLET.center.y
        sldMaximumOUTLET.center.y = self.view.frame.height + 30
        let centerOfLabel = lblMaximumOUTLET.center.y
        lblMaximumOUTLET.center.y = self.view.frame.height + 30
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions(rawValue: 1), animations: ({
            
            self.sldMaximumOUTLET.center.y = centerOfSlider
            self.lblMaximumOUTLET.center.y = centerOfLabel
        }), completion: nil)
        
    }
    
    func addPulse() {
        let pulse = Pulsing(numberOfPulses: 1, radius: 100, position: lblQuestionOUTLET.center)
        pulse.animationDuration = 1
        pulse.backgroundColor = UIColor.red.cgColor
        self.view.layer.insertSublayer(pulse, below: lblQuestionOUTLET.layer)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCheckAnswerACTION(_ sender: UIButton) {
        if txtInputOUTLET.text != "" {
        questionsAttempted = questionsAttempted + 1
        
        if Int(txtInputOUTLET.text!) == correctAnswer {
            score = score + 1
            lblRightorWrongOUTLET.text = "Correct. Score: " + String(score) + " / " + String(questionsAttempted)
            lblRightorWrongOUTLET.backgroundColor = UIColor.green
            
        }
        else {
            let strRN2 = String(randomNumber2!)
            let strRN1 = String(randomNumber1!)
            let strRSLT = String(result!)
            let temp = "\n" + strRN1 + operation! + strRN2 + " = " + strRSLT    
        
            lblRightorWrongOUTLET.text = "Incorrect. Score: " + String(score) + " / " + String(questionsAttempted) + temp
            lblRightorWrongOUTLET.backgroundColor = UIColor.red
            txtInputOUTLET.shake()
        }
            generateQuestion()
            displayQuestion()
            txtInputOUTLET.text = ""
        }
        else {
            txtInputOUTLET.shake()

        }
    }
    
    @IBAction func btnStartACTION(_ sender: UIButton) {
        
        generateQuestion()
        displayQuestion()
        txtInputOUTLET.isEnabled = true
        btnQuitOUTLET.isEnabled = true
        btnCheckOUTLET.isEnabled = true
        btnStartOUTLET.isEnabled = false
        txtInputOUTLET.placeholder = "Enter number"
        btnCheckOUTLET.isHidden = false
        btnStartOUTLET.isHidden = true
        btnQuitOUTLET.isHidden = false
        
        animate()
    }
    @IBAction func btnQuitAction(_ sender: UIButton) {
        animate()
        modifyView()
    }

    @IBAction func sldMaximumACTION(_ sender: UISlider) {
        lblMaximumOUTLET.text = String(Int(exp(sldMaximumOUTLET.value)))
    }
    
    func generateQuestion() {
        questionFormat = Int(arc4random_uniform(3))
        operationFormat = Int(arc4random_uniform(4))
        
        switch operationFormat! {
        case 0:
            randomNumber1 = Int(arc4random_uniform(UInt32(lblMaximumOUTLET.text!)!))
            randomNumber2 = Int(arc4random_uniform(UInt32(lblMaximumOUTLET.text!)!))
            result = randomNumber1! + randomNumber2!
            operation = " + "
        case 1:
            randomNumber1 = Int(arc4random_uniform(UInt32(lblMaximumOUTLET.text!)!))
            randomNumber2 = Int(arc4random_uniform(UInt32(lblMaximumOUTLET.text!)!))
            result = randomNumber1! - randomNumber2!
            operation = " - "
        case 2:
            randomNumber1 = Int(arc4random_uniform(UInt32(lblMaximumOUTLET.text!)!))
            randomNumber2 = Int(arc4random_uniform(UInt32(lblMaximumOUTLET.text!)!))
            result = randomNumber1! * randomNumber2!
            operation = " x "
        case 3:
            randomNumber1 = 1 + Int(arc4random_uniform(UInt32(lblMaximumOUTLET.text!)!))
            randomNumber2 = 1 + Int(arc4random_uniform(UInt32(lblMaximumOUTLET.text!)!))
            result = randomNumber1! / randomNumber2!
            operation = " / "
        default:
            break
        }
        
        if randomNumber1 == 0 || randomNumber2 == 0 || result == 0 || randomNumber1! % randomNumber2! != 0  {
            generateQuestion()
        }
    }
    
    func displayQuestion() {
        let first: String = String(randomNumber1!)
        let second: String = String(randomNumber2!)
        let third: String = String(result!)
        
        switch questionFormat! {
        case 0:
            correctAnswer = randomNumber1
            lblQuestionOUTLET.text = "? " + operation! + second + " = " + third
        case 1:
            correctAnswer = randomNumber2
            lblQuestionOUTLET.text = first + operation! + " ?" + " = " + third
        case 2:
            correctAnswer = result
            lblQuestionOUTLET.text = first + operation! + second + " = ?"
        default:
            break
        }
        
        lblQuestionOUTLET.center.x = self.view.frame.width - 60
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions(rawValue: 1), animations: ({

            self.lblQuestionOUTLET.center.x = self.view.frame.width / 2
        }), completion: nil)
    }
    
    func modifyView() {
        lblRightorWrongOUTLET.text = ""
        btnStartOUTLET.isEnabled = true
        btnCheckOUTLET.isEnabled = false
        btnQuitOUTLET.isEnabled = false
        txtInputOUTLET.isEnabled = false
        btnQuitOUTLET.isEnabled = false
        self.view.backgroundColor = UIColor(red: 0.53, green: 0.66, blue: 0.66, alpha: 1)
        lblRightorWrongOUTLET.text = ""
        lblRightorWrongOUTLET.backgroundColor = UIColor(red: 0.53, green: 0.66, blue: 0.66, alpha: 1)
        txtInputOUTLET.keyboardType = UIKeyboardType.numbersAndPunctuation
        txtInputOUTLET.placeholder = ""
        txtInputOUTLET.text = ""
        lblQuestionOUTLET.text = ""
        score = 0
        questionsAttempted = 0
        btnCheckOUTLET.isHidden = true
        btnStartOUTLET.isHidden = false
        btnQuitOUTLET.isHidden = true
        
        sldMaximumOUTLET.minimumValue = 1
        sldMaximumOUTLET.maximumValue = 7
        lblMaximumOUTLET.text = String(Int(exp(sldMaximumOUTLET.value)))
    }
    
    func animate() {
        lblQuestionOUTLET.center.x = self.view.frame.width - 60
        txtInputOUTLET.center.x = self.view.frame.width + 30
        btnCheckOUTLET.center.x = self.view.frame.width - 60
        lblRightorWrongOUTLET.center.x = self.view.frame.width + 30
        let centerofQuit = btnQuitOUTLET.center.y
        btnQuitOUTLET.center.y = self.view.frame.height + 30
        let centerofStart = btnStartOUTLET.center.y
        btnStartOUTLET.center.y = self.view.frame.height + 30
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 2.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions(rawValue: 33), animations: ({
            
            
            self.lblQuestionOUTLET.center.x = self.view.frame.width / 2
            self.txtInputOUTLET.center.x = self.view.frame.width / 2
            self.btnCheckOUTLET.center.x = self.view.frame.width / 2
            self.lblRightorWrongOUTLET.center.x = self.view.frame.width / 2
            
        }), completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 50, options: UIViewAnimationOptions(rawValue: 1), animations: ({
            
            self.btnStartOUTLET.center.y = centerofStart
            self.btnQuitOUTLET.center.y = centerofQuit
            
        }), completion: nil)
    }
}

