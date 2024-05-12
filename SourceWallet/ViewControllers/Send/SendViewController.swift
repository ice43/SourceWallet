//
//  SendViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/12/24.
//

import UIKit

final class SendViewController: UIViewController {
    @IBOutlet private weak var sendAllFundsButton: UIButton!
    @IBOutlet private weak var customSliderLabel: UILabel!
    @IBOutlet private weak var lowSliderLabel: UILabel!
    @IBOutlet private weak var mediumSliderLabel: UILabel!
    @IBOutlet private weak var highSliderLabel: UILabel!
    @IBOutlet private weak var feeLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    private let availableValues: [Float] = [0, 0.35, 0.67, 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupColorSliderLabel()
        setupSendAllFundsButton()
    }
    
    @IBAction private func sliderValueChanged(_ sender: UISlider) {
        let index = Int(round(sender.value * Float(availableValues.count - 1)))
        sender.value = availableValues[index]
        
        switch index {
        case 0:
            customSliderLabel.textColor = .white
            lowSliderLabel.textColor = .darkGray
            mediumSliderLabel.textColor = .darkGray
            highSliderLabel.textColor = .darkGray
            
            timeLabel.text = "Custom"
            feeLabel.text = ""
        case 1:
            customSliderLabel.textColor = .darkGray
            lowSliderLabel.textColor = .white
            mediumSliderLabel.textColor = .darkGray
            highSliderLabel.textColor = .darkGray
            
            timeLabel.text = "~ 4 hours"
            feeLabel.text = "( 10.98 satoshi / vbyte )"
        case 2:
            customSliderLabel.textColor = .darkGray
            lowSliderLabel.textColor = .darkGray
            mediumSliderLabel.textColor = .white
            highSliderLabel.textColor = .darkGray
            
            timeLabel.text = "~ 2 hours"
            feeLabel.text = "( 11.93 satoshi / vbyte )"
        default:
            customSliderLabel.textColor = .darkGray
            lowSliderLabel.textColor = .darkGray
            mediumSliderLabel.textColor = .darkGray
            highSliderLabel.textColor = .white
            
            timeLabel.text = "~ 30 minutes"
            feeLabel.text = "( 12.25 satoshi / vbyte )"
        }
    }
}

// MARK: - UI
private extension SendViewController {
    func setupSendAllFundsButton() {
        sendAllFundsButton.layer.borderWidth = 2
        sendAllFundsButton.layer.borderColor = UIColor.white.cgColor
        sendAllFundsButton.layer.cornerRadius = 10
    }
    
    func setupColorSliderLabel() {
        mediumSliderLabel.textColor = .white
    }
}
