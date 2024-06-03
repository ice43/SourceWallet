//
//  MainProfileViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/7/24.
//

import UIKit

final class MainProfileViewController: UIViewController {
    // MARK: IB Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var fiatLabel: UILabel!
    @IBOutlet private weak var hideButton: UIButton!
    @IBOutlet private weak var sideMenuView: UIView!
    @IBOutlet private weak var backViewForSideMenu: UIView!
    @IBOutlet private weak var leadingConstraintSideMenu: NSLayoutConstraint!
    
    // MARK: Private properties
    private let bottomMenuView = BottomMenuView()
    private let user = User.getUser()
    private var isHidden = false
    private var sideMenuViewController: SideMenuViewController?
    private var blurView: UIVisualEffectView?
    private var denominationView: DenominationView?
    
    var selectedWallet: Wallet?
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        setupUserInfo()
        setupBottomMenu()
        setupTableView()
        
        setupLabelTapRecognition()
    }
    
    // MARK: IB Actions
    @IBAction private func hideButtonTapped(_ sender: UIButton) {
        isHidden.toggle()
        
        for cell in tableView.visibleCells {
            guard let transactionCell = cell as? TransactionViewCell else { return }
            
            if isHidden {
                balanceLabel.text = "*****"
                fiatLabel.text = "*****"
                transactionCell.hideAmountLabel()
                
                let closedEyeImage = UIImage(named: "closed_eye")?.resized(
                    to: CGSize(width: 30, height: 25)
                )
                sender.setImage(closedEyeImage, for: .normal)
            } else {
                guard let wallet = selectedWallet else { return }
                
                balanceLabel.text = wallet.balance + " BTC"
                fiatLabel.text = wallet.fiat
                transactionCell.showAmountLabel()
                
                sender.setImage(UIImage(systemName: "eye"), for: .normal)
            }
        }
    }
    
    @IBAction private func showSideMenu(_ sender: UIBarButtonItem) {
        sideMenuView.isHidden = false
        leadingConstraintSideMenu.constant = .zero
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        bottomMenuView.isHidden = true
        navigationController?.navigationBar.isHidden = true
        backViewForSideMenu.isHidden = false
    }
    
    @IBAction private func tapOutOfSideMenu(_ sender: UITapGestureRecognizer) {
        hideSideMenu()
    }
    
    @IBAction func denominationButtonTapped() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = view.bounds
        self.blurView = blurView
        blurView.alpha = 0
        
        let denominationView = DenominationView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width / 1.1,
                height: 300
            )
        )
        
        self.denominationView = denominationView
        
        denominationView.delegate = self
        denominationView.center = view.center
        denominationView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        view.addSubview(blurView)
        view.addSubview(denominationView)
        navigationController?.navigationBar.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            blurView.alpha = 1
            denominationView.transform = CGAffineTransform.identity
        })
    }
}

// MARK: - UI
private extension MainProfileViewController {
    func setupSideMenu() {
        sideMenuView.isHidden = true
        backViewForSideMenu.isHidden = true
    }
    
    func setupUserInfo() {
        selectedWallet = selectedWallet ?? user.wallets.first
        
        guard let wallet = selectedWallet else { return }
        
        balanceLabel.text = wallet.balance + " BTC"
        fiatLabel.text = wallet.fiat
        
        // Transfer data about the selected wallet to the side menu to display a point above the selected wallet
        guard let sideMenuViewController = sideMenuViewController else { return }
        
        sideMenuViewController.selectedWallet = wallet
        sideMenuViewController.tableView.reloadData()
    }
    
    func setupBottomMenu() {
        bottomMenuView.delegate = self
        bottomMenuView.translatesAutoresizingMaskIntoConstraints = false
        bottomMenuView.layer.cornerRadius = 10
        view.addSubview(bottomMenuView)
        
        // Setting up constraints
        NSLayoutConstraint.activate(
            [
                bottomMenuView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 20
                ),
                bottomMenuView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -20
                ),
                bottomMenuView.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor,
                    constant: -40
                ),
                bottomMenuView.heightAnchor.constraint(
                    equalToConstant: 50
                )
            ]
        )
    }
    
    func setupTableView() {
        tableView.register(
            UINib(
                nibName: "TransactionViewCell",
                bundle: nil
            ),
            forCellReuseIdentifier: "TransactionViewCell"
        )
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .none
    }
}

// MARK: - Labels interaction
private extension MainProfileViewController {
    func setupLabelTapRecognition() {
        let balanceLabelTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(labelTapped)
        )
        balanceLabel.addGestureRecognizer(balanceLabelTapGesture)
        balanceLabel.isUserInteractionEnabled = true
        
        let fiatLabelTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(labelTapped)
        )
        fiatLabel.addGestureRecognizer(fiatLabelTapGesture)
        fiatLabel.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped() {
        let tempText = balanceLabel.text
        balanceLabel.text = fiatLabel.text
        fiatLabel.text = tempText
    }
}

// MARK: - UITableViewDataSource
extension MainProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedWallet?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionViewCell", for: indexPath) as? TransactionViewCell,
              let transaction = selectedWallet?.transactions[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configureCell(withData: transaction)
        cell.backgroundColor = .clear
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let transaction = selectedWallet?.transactions[indexPath.row],
              let transactionDetailsVC = storyboard?.instantiateViewController(
                withIdentifier: "TransactionDetailsViewController"
              ) as? TransactionDetailsViewController else { return }
        
        transactionDetailsVC.transaction = transaction
        transactionDetailsVC.selectedWallet = selectedWallet
        
        navigationController?.pushViewController(transactionDetailsVC, animated: true)
    }
}

// MARK: - Navigation
extension MainProfileViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSideMenu" {
            guard let controller = segue.destination as? SideMenuViewController else { return }
            
            sideMenuViewController = controller
            sideMenuViewController?.delegate = self
        }
    }
}

// MARK: - SideMenuViewControllerDelegate
extension MainProfileViewController: SideMenuViewControllerDelegate {
    func hideSideMenu() {
        leadingConstraintSideMenu.constant = -320
        
        navigationController?.navigationBar.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.backViewForSideMenu.isHidden = true
            self.bottomMenuView.isHidden = false
            self.sideMenuView.isHidden = true
        }
    }
}

// MARK: - BottomMenuViewDelegate
extension MainProfileViewController: BottomMenuViewDelegate {
    func openSendViewController() {
        guard let sendVC = storyboard?.instantiateViewController(
            withIdentifier: "SendViewController"
        ) as? SendViewController else { return }
        
        navigationController?.pushViewController(sendVC, animated: true)
    }
    
    func openQrViewController() {
        guard let qrVC = storyboard?.instantiateViewController(withIdentifier: "QrViewController") else {
            return
        }
        
        present(qrVC, animated: true)
    }
    
    func openReceiveViewController() {
        guard let receiveVC = storyboard?.instantiateViewController(
            withIdentifier: "ReceiveViewController"
        ) as? ReceiveViewController else { return }
        
        navigationController?.pushViewController(receiveVC, animated: true)
    }
    
}

// MARK: - DenominationViewDelegate
extension MainProfileViewController: DenominationViewDelegate {
    func cancelButtonTapped() {
        blurView?.removeFromSuperview()
        denominationView?.removeFromSuperview()
        navigationController?.navigationBar.isHidden = false
    }
    
    func okButtonTapped() {
        blurView?.removeFromSuperview()
        denominationView?.removeFromSuperview()
        navigationController?.navigationBar.isHidden = false
    }
}
