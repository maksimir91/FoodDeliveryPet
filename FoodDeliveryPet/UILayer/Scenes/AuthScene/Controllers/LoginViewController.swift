//
//  LoginViewController.swift
//  FoodDeliveryPet
//
//  Created by Stanislav Shut on 02.06.2024.
//

import UIKit

enum LoginViewState {
    case initial
    case signIn
    case signUp
}

protocol LoginViewInput: AnyObject {
    func startLoader()
    func stopLoader()
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private var state: LoginViewState = .initial
    var viewOutput: LoginViewOutput!
    private var isKeyboardShown = false
    private var bottomCTValue = 0.0
    
    // MARK: - Views
    private lazy var bottomView = FDBottomView()
    private lazy var titleLabel = UILabel()
    private lazy var signInUsername = FDTextField()
    private lazy var signInPassword = FDTextField()
    private lazy var signUpUsername = FDTextField()
    private lazy var signUpPassword = FDTextField()
    private lazy var signUpReEnterPassword = FDTextField()
    private lazy var forgotLabel = UILabel()
    private lazy var logoImage = UIImageView()
    private lazy var signInButton = FDButton()
    private lazy var signUpButton = FDButton()
    private lazy var verticalStack = UIStackView()
    private lazy var loader = UIActivityIndicatorView(style: .large)
    private lazy var loaderContainer = UIView()
    
    // MARK: - Constraints
    private var stackViewBottomCT = NSLayoutConstraint()
    
    // MARK: - Initializers
    init(viewOutput: LoginViewOutput, state: LoginViewState) {
        self.state = state
        self.viewOutput = viewOutput
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupObservers()
    }

    deinit {
        stopKeyboardListner()
    }
    
    func facebookPress() {
        print("facebook")
    }
    func googlePress() {
        print("google")
    }

}

// MARK: - Layout
private extension LoginViewController {
    func setupLayout() {
        switch state {
        case .initial:
            setupBottomView()
            setupLogoImage()
            setupSignInButton()
            setupSignUpButton()
        case .signIn:
            setupBottomView()
            setupStack()
            setupSignInPassword()
            setupSignInUsername()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()
            setupNavigationBar()
        case .signUp:
            setupBottomView()
            setupStack()
            setupSignUpUsername()
            setupSignUpPass()
            setupSignUpReEnterPass()
            setupTitleLabel()
            setupSignInButton()
            setupForgotLabel()
            setupNavigationBar()
        }
        setupLoaderView()
    }
    
    func setupNavigationBar() {
        let backImage = UIImage(resource: .back)
        let backButtonItem = UIBarButtonItem(image: backImage,
                                             style: .plain,
                                             target: navigationController,
                                             action: #selector(navigationController?.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.leftBarButtonItem?.tintColor = AppColors.black
        //backButtonItem.tintColor = AppColors.black
    }
    
    func setupStack() {
        view.addSubview(verticalStack)
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        
        switch state {
        case .initial:
            return
        case .signIn:
                verticalStack.addArrangedSubview(signInUsername)
                verticalStack.addArrangedSubview(signInPassword)
                bottomCTValue = -262
                stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)
            
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              //  verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -262)
                stackViewBottomCT
            ])
        case .signUp:
            verticalStack.addArrangedSubview(signUpUsername)
            verticalStack.addArrangedSubview(signUpPassword)
            verticalStack.addArrangedSubview(signUpReEnterPassword)
            bottomCTValue = -227
            stackViewBottomCT = verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: bottomCTValue)
            
            NSLayoutConstraint.activate([
                verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              //  verticalStack.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -227)
                stackViewBottomCT
            ])
        }
    }
    func setupBottomView() {
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.button2Action = { [weak self] in
            self?.facebookPress()
        }
        bottomView.button1Action = { [weak self] in
            self?.googlePress()
        }
        
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 150)
        
        ])
    }
    
    func setupSignInPassword() {
        signInPassword.translatesAutoresizingMaskIntoConstraints = false
        signInPassword.placeholder = "Password"
        
        NSLayoutConstraint.activate([
            signInPassword.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signInPassword.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signInPassword.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupSignInUsername() {
        signInUsername.translatesAutoresizingMaskIntoConstraints = false
        signInUsername.placeholder = "Username"
        
        NSLayoutConstraint.activate([
            signInUsername.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signInUsername.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signInUsername.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .Roboto.bold.size(of: 24)
        
        
        switch state {
        case .signIn:
            titleLabel.text = "Sign in"
        case .signUp:
            titleLabel.text = "Sign up"
        case .initial:
            return
        }
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: verticalStack.topAnchor, constant: -38),
            titleLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            titleLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupLogoImage () {
        view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(resource: .loginLogo)
        logoImage.layer.cornerRadius = 24
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 109),
            logoImage.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 57),
            logoImage.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -57),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor)
        ])
    }
    
    func setupSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.setTitle("Sign in")
        signInButton.scheme = .orange
        signInButton.action = { [weak self] in
            self?.onSignInTapped()
        }
        
        switch state {
        case .initial:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 60),
                signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
                signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .signIn:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 30),
                signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
                signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        case .signUp:
            NSLayoutConstraint.activate([
                signInButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 30),
                signInButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
                signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
                signInButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        

    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("Sign up")
        signUpButton.scheme = .grey
        signUpButton.action = { [weak self] in
            self?.onSignUpTapped()
        }
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            signUpButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signUpButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupForgotLabel() {
        view.addSubview(forgotLabel)
        
        forgotLabel.translatesAutoresizingMaskIntoConstraints = false
        forgotLabel.text = "Forgot Password?"
        forgotLabel.font = .Roboto.regular.size(of: 14)
        forgotLabel.textColor = AppColors.bottomViewGrey
        
        NSLayoutConstraint.activate([
            forgotLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            forgotLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30)
        ])
    }
    
    func setupSignUpPass() {
      //  view.addSubview(signUpPassword)
        signUpPassword.translatesAutoresizingMaskIntoConstraints = false
        signUpPassword.placeholder = "Enter Password"
        
        NSLayoutConstraint.activate([
            signUpPassword.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signUpPassword.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signUpPassword.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupSignUpUsername() {
//        view.addSubview(signUpUsername)
        signUpUsername.translatesAutoresizingMaskIntoConstraints = false
        signUpUsername.placeholder = "Enter Username"
        
        NSLayoutConstraint.activate([
            signUpUsername.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signUpUsername.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signUpUsername.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupSignUpReEnterPass() {
//        view.addSubview(signUpReEnterPassword)
        signUpReEnterPassword.translatesAutoresizingMaskIntoConstraints = false
        signUpReEnterPassword.placeholder = "Re-enter Password"
        
        NSLayoutConstraint.activate([
            signUpReEnterPassword.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30),
            signUpReEnterPassword.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            signUpReEnterPassword.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupLoaderView() {
        view.addSubview(loaderContainer)
        loaderContainer.translatesAutoresizingMaskIntoConstraints = false
        loaderContainer.backgroundColor = AppColors.black.withAlphaComponent(0.3)
        loaderContainer.isHidden = true
        
        NSLayoutConstraint.activate([
            loaderContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            loaderContainer.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        loaderContainer.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: loaderContainer.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: loaderContainer.centerYAnchor)
        ])
    }
}


// MARK: - Private methods

private extension LoginViewController {
    func onSignInTapped() {
        switch state {
        case .initial:
            viewOutput.goToSignIn()
        case .signIn:
            print(#function)
            viewOutput.loginStart(login: signInUsername.text ?? "", password: signInPassword.text ?? "")
        case .signUp:
            return
        }
    }
    
    func onSignUpTapped() {
        switch state {
        case .initial:
            viewOutput.goToSignUp()
        case .signIn:
            return
        case .signUp:
            return
        }
    }
    
    func onFacebookTapped() {
        
    }
    
    func onGoogleTapped() {
        
    }
    
    func onForgotTapped() {
        
    }
    
    func onBackPressed() {
        
    }
    
}

// MARK: - LoginViewInput delegate
extension LoginViewController: LoginViewInput {
    func startLoader() {
        loaderContainer.isHidden = false
        loader.startAnimating()
    }
    
    func stopLoader() {
        loaderContainer.isHidden = true
        loader.stopAnimating()
    }
}


// MARK: - Observers
private extension LoginViewController {
    func setupObservers() {
        startKeyboardListner()
    }
    func startKeyboardListner() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    func stopKeyboardListner() {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        
        if !isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant -= keyboardHeight/4
                self.view.layoutIfNeeded()
                self.isKeyboardShown = true
            }
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        if isKeyboardShown {
            UIView.animate(withDuration: 0.3) {
                self.stackViewBottomCT.constant = self.bottomCTValue
                self.view.layoutIfNeeded()
                self.isKeyboardShown = false
            }
        }
    }
}

//#Preview("LoginVC") {
//    LoginViewController(viewOutput: LoginPresenter(), state: .signUp)
//}
