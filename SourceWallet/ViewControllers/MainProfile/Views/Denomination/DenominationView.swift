//
//  DenominationView.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/7/24.
//

import UIKit

protocol DenominationViewDelegate: AnyObject {
    func cancelButtonTapped()
    func okButtonTapped(with value: String)
}

final class DenominationView: UIView {
    weak var delegate: DenominationViewDelegate?
    
    // MARK: Private properties
    private var denominationValue = "BTC"
    private var referenceRateValue = "USD from BITSTAMP" {
        didSet {
            showAlert()
        }
    }
    
    // MARK: UI
    private var titleLabel: UILabel {
        let label = UILabel(
            frame: CGRect(
                x: 0,
                y: 25,
                width: frame.width,
                height: 19
            )
        )
        
        label.font = .boldSystemFont(ofSize: 19)
        label.textAlignment = .center
        label.text = "Denomination & Exchange Rate"
        
        return label
    }
    
    private var denominationButton: UIButton {
        let button = UIButton(
            frame: CGRect(
                x: (frame.width - 300) / 2,
                y: 0,
                width: 300,
                height: 71
            )
        )
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 13)
        titleLabel.textColor = .darkGray
        titleLabel.text = "Denomination"
        
        let subtitleLabel = UILabel()
        subtitleLabel.font = .boldSystemFont(ofSize: 14)
        subtitleLabel.text = denominationValue
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        button.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [
                stackView.leadingAnchor.constraint(
                    equalTo: button.leadingAnchor,
                    constant: 20
                ),
                stackView.centerYAnchor.constraint(
                    equalTo: button.centerYAnchor
                )
            ]
        )
        
        let chevronImage = UIImage(systemName: "chevron.right")
        let chevronImageView = UIImageView(image: chevronImage)
        chevronImageView.frame = CGRect(
            x: button.frame.width - 15 - chevronImageView.frame.width,
            y: (button.frame.height - chevronImageView.frame.height) / 2,
            width: chevronImageView.frame.width,
            height: chevronImageView.frame.height
        )
        button.addSubview(chevronImageView)
        
        button.backgroundColor = .backModal
        button.layer.cornerRadius = 10
        button.frame.origin.y = 70
        
        let firstItem = Denomination.btc.rawValue
        let secondItem = Denomination.mbtc.rawValue
        let thirdItem = Denomination.ubtc.rawValue
        let fourthItem = Denomination.bits.rawValue
        let fifthItem = Denomination.sats.rawValue
        
        let firstMenuItem = UIAction(title: firstItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = firstItem
            denominationValue = firstItem
        }
        
        let secondMenuItem = UIAction(title: secondItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = secondItem
            denominationValue = secondItem
        }
        
        let thirdMenuItem = UIAction(title: thirdItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = thirdItem
            denominationValue = thirdItem
        }
        
        let fourthMenuItem = UIAction(title: fourthItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = fourthItem
            denominationValue = fourthItem
        }
        
        let fifthMenuItem = UIAction(title: fifthItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = fifthItem
            denominationValue = fifthItem
        }
        
        let menu = UIMenu(
            title: "",
            children: [
                firstMenuItem,
                secondMenuItem,
                thirdMenuItem,
                fourthMenuItem,
                fifthMenuItem
            ]
        )
        
        button.showsMenuAsPrimaryAction = true
        button.menu = menu
        
        return button
    }
    
    private var referenceRateButton: UIButton {
        let button = UIButton(
            frame: CGRect(
                x: (frame.width - 300) / 2,
                y: 0,
                width: 300,
                height: 71
            )
        )
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 13)
        titleLabel.textColor = .darkGray
        titleLabel.text = "Reference exchange rate"
        
        let subtitleLabel = UILabel()
        subtitleLabel.font = .boldSystemFont(ofSize: 14)
        subtitleLabel.text = referenceRateValue
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        button.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [
                stackView.leadingAnchor.constraint(
                    equalTo: button.leadingAnchor,
                    constant: 20
                ),
                stackView.centerYAnchor.constraint(
                    equalTo: button.centerYAnchor
                )
            ]
        )
        
        let chevronImage = UIImage(systemName: "chevron.right")
        let chevronImageView = UIImageView(image: chevronImage)
        chevronImageView.frame = CGRect(
            x: button.frame.width - 15 - chevronImageView.frame.width,
            y: (button.frame.height - chevronImageView.frame.height) / 2,
            width: chevronImageView.frame.width,
            height: chevronImageView.frame.height
        )
        button.addSubview(chevronImageView)
        
        button.backgroundColor = .backModal
        button.layer.cornerRadius = 10
        button.frame.origin.y = denominationButton.frame.origin.y + denominationButton.frame.height + 20
        
        let firstItem = "USD from BITSTAMP"
        let secondItem = "USD from BITFINEX"
        let thirdItem = "USD from KRAKEN"
        let fourthItem = "USD from COINGECKO"
        
        let firstMenuItem = UIAction(title: firstItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = firstItem
            referenceRateValue = firstItem
        }
        
        let secondMenuItem = UIAction(title: secondItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = secondItem
            referenceRateValue = secondItem
        }
        
        let thirdMenuItem = UIAction(title: thirdItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = thirdItem
            referenceRateValue = thirdItem
        }
        
        let fourthMenuItem = UIAction(title: fourthItem) { [weak self] _ in
            guard let self else { return }
            subtitleLabel.text = fourthItem
            referenceRateValue = fourthItem
        }
        
        let menu = UIMenu(
            title: "",
            children: [
                firstMenuItem,
                secondMenuItem,
                thirdMenuItem,
                fourthMenuItem
            ]
        )
        
        button.showsMenuAsPrimaryAction = true
        button.menu = menu
        
        
        return button
    }
    
    private var actionStack: UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside
        )
        
        let okButton = UIButton(type: .system)
        okButton.setTitle("Ok", for: .normal)
        okButton.addTarget(
            self,
            action: #selector(okButtonTapped),
            for: .touchUpInside
        )
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(okButton)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [
                stackView.trailingAnchor.constraint(
                    equalTo: trailingAnchor,
                    constant: -30
                ),
                stackView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -20
                )
            ]
        )
        
        return stackView
    }
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .back
        
        if let denominationValue = UserDefaults.standard.string(forKey: "Denomination") {
            self.denominationValue = denominationValue
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: View life cycle
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.backModal.cgColor
        clipsToBounds = true
        
        addSubview(titleLabel)
        addSubview(denominationButton)
        addSubview(referenceRateButton)
        addSubview(actionStack)
    }

    // MARK: Delegate
    @objc private func cancelButtonTapped() {
        delegate?.cancelButtonTapped()
    }
    
    @objc private func okButtonTapped() {
        delegate?.okButtonTapped(with: denominationValue)
        
        UserDefaults.standard.set(denominationValue, forKey: "Denomination")
    }
    
    private func showAlert() {
        guard let viewController = self.superview?.next as? UIViewController else {
            return
        }
        
        let alertController = UIAlertController(
            title: nil,
            message: "The exchange rate change is temporarily unavailable",
            preferredStyle: .alert
        )
        alertController.view.backgroundColor = .black.withAlphaComponent(0.7)
        alertController.view.alpha = 0.7
        alertController.view.layer.cornerRadius = 10
        
        viewController.present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    DenominationView()
}
