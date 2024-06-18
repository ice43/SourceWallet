//
//  WelcomeViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/2/24.
//

import UIKit

final class WelcomeViewController: UIViewController {
    @IBOutlet private weak var getStartedButton: UIButton!
    @IBOutlet private weak var checkText: UITextView!
    
    private var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetupGetStartedButton()
        setAgreeText()
    }
    
    @IBAction private func setCheckmark(_ sender: UIButton) {
        isChecked.toggle()
        
        // Set checkmark image for sender
        let imageCheck = isChecked ? "checkmark" : ""
        sender.setImage(UIImage(systemName: imageCheck), for: .normal)
        
        getStartedButton.isEnabled = isChecked
        
        // Changing the alpha of the button depending on the checkmark
        getStartedButton.alpha = getStartedButton.isEnabled ? 1 : 0.5
    }
}

// MARK: - Private functions
private extension WelcomeViewController {
    // MARK: Initial setup of GetStartedButton
    func initialSetupGetStartedButton() {
        getStartedButton.alpha = 0.5
    }
    
    // MARK: Allows the direction of URLs
    func textView(
        _ textView: UITextView,
        shouldInteractWith URL: URL,
        in characterRange: NSRange,
        interaction: UITextItemInteraction
    ) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
    
    // MARK: Sets text near checkmark button
    func setAgreeText() {
        let attributedString = NSMutableAttributedString(
            string: "I agree to Terms of Service and Privacy Policy"
        )
        
        // First link - Terms of Service
        attributedString.addAttribute(
            .link,
            value: "https://www.hackingwithswift.com",
            range: NSRange(location: 11, length: 16)
        )
        // Second link - Privacy Policy
        attributedString.addAttribute(
            .link,
            value: "https://www.hackingwithswift.com",
            range: NSRange(location: 32, length: 14)
        )
        // Set color of checkText
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.white,
            range: NSRange(location: 0, length: attributedString.length)
        )
        // Set font size of checkText
        attributedString.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 16),
            range: NSRange(location: 0, length: attributedString.length)
        )
        
        checkText.attributedText = attributedString
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    WelcomeViewController()
}
