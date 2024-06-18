//
//  SetPhraseViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/13/24.
//

import UIKit

final class SetPhraseViewController: UIViewController {
    private let pageControl = UIPageControl()
    private let topStackView = UIStackView()
    private let scrollView = UIScrollView()
    private let bottomStackView = UIStackView()
    private let seedPhrase = DataStore.shared.seedPhrase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .back

        setupPageControl()
        setupTopStackView()
        setupScrollView()
        setupBottomStackView()
    }
}

// MARK: - UI
private extension SetPhraseViewController {
    func setupPageControl() {
        view.addSubview(pageControl)
        
        pageControl.numberOfPages = seedPhrase.count
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.addTarget(
            self,
            action: #selector(
                pageControlValueChanged(_:)
            ),
            for: .valueChanged
        )
        
        NSLayoutConstraint.activate(
            [
                pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            ]
        )
    }
    
    
    func setupTopStackView() {
        topStackView.axis = .vertical
        topStackView.spacing = 8
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Write down your recovery phrase in the correct order"
        titleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        topStackView.addArrangedSubview(titleLabel)
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Store it somewhere safe"
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .lightGray
        subtitleLabel.textAlignment = .center
        topStackView.addArrangedSubview(subtitleLabel)
        
        view.addSubview(topStackView)
       
        NSLayoutConstraint.activate(
            [
                topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                topStackView.topAnchor.constraint(
                    equalTo: pageControl.bottomAnchor,
                    constant: 30
                ),
                topStackView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 47
                )
            ]
        )
    }
    
    func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate(
            [
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.topAnchor.constraint(
                    equalTo: topStackView.bottomAnchor,
                    constant: 60
                ),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contentView)
        
        var leadingAnchor = contentView.leadingAnchor
        for index in 0..<seedPhrase.count {
            let pageView = createPageView(with: seedPhrase[index])
            contentView.addSubview(pageView)
            
            NSLayoutConstraint.activate(
                [
                    pageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    pageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                    pageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    pageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
                ]
            )
            
            leadingAnchor = pageView.trailingAnchor
        }
        
        NSLayoutConstraint.activate(
            [
                contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                contentView.trailingAnchor.constraint(equalTo: leadingAnchor)
            ]
        )
    }
    
    func setupBottomStackView() {
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 8
        bottomStackView.alignment = .center
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.backModal, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(
                nextButtonTapped
            ),
            for: .touchUpInside
        )
        bottomStackView.addArrangedSubview(button)
        
        NSLayoutConstraint.activate(
            [
                button.widthAnchor.constraint(equalToConstant: 341),
                button.heightAnchor.constraint(equalToConstant: 64)
            ]
        )
        
        let imageView = UIImageView(image: UIImage(named: "environment"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate(
            [
                imageView.widthAnchor.constraint(equalToConstant: 30),
                imageView.heightAnchor.constraint(equalToConstant: 30)
            ]
        )
        
        let label = UILabel()
        label.text = "Make sure to be in a private and safe place"
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.addArrangedSubview(label)
        
        view.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate(
            [
                bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
}

// MARK: - UIScrollViewDelegate
extension SetPhraseViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = round(scrollView.contentOffset.x / scrollView.frame.width)
        
        if !currentPage.isInfinite && !currentPage.isNaN {
            pageControl.currentPage = Int(currentPage)
        }
    }
}

// MARK: - Actions
private extension SetPhraseViewController {
    @objc func pageControlValueChanged(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let offsetX = CGFloat(currentPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    @objc func nextButtonTapped() {
        let nextPage = pageControl.currentPage + 1
        let offsetX = CGFloat(nextPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        if nextPage == seedPhrase.count {
            showSetPinScreen()
        }
    }
}

// MARK: - Private methods
extension SetPhraseViewController {
    func createPageView(with words: [String]) -> UIView {
        let pageView = UIView()
        pageView.translatesAutoresizingMaskIntoConstraints = false
        
        var wordCount = 0
        for (index, word) in words.enumerated() {
            
            let attributedText = NSMutableAttributedString(string: "\(wordCount + 1) \(word)")
            
            let numberAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: view.tintColor ?? .white
            ]
            attributedText.addAttributes(
                numberAttributes,
                range: NSRange(location: 0, length: "\(wordCount)".count + 1)
            )
            
            let label = UILabel()
            wordCount += 1
            label.attributedText = attributedText
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20)
            pageView.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate(
                [
                    label.leadingAnchor.constraint(equalTo: pageView.leadingAnchor),
                    label.trailingAnchor.constraint(equalTo: pageView.trailingAnchor),
                    label.topAnchor.constraint(
                        equalTo: pageView.topAnchor,
                        constant: CGFloat(index) * 60
                    )
                ]
            )
        }
        
        return pageView
    }
}

// MARK: - Navigation
private extension SetPhraseViewController {
    func showSetPinScreen() {
        let storyboard = UIStoryboard(name: "SetPin", bundle: nil)
        let setPinViewController = storyboard.instantiateInitialViewController()
        navigationController?.pushViewController(setPinViewController!, animated: true)
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    SetPhraseViewController()
}
