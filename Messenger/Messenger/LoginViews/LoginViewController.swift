//
//  ViewController.swift
//  Messenger
//
//  Created by Tejas Kashid on 30/09/23.
//

import UIKit
import ProgressHUD

class LoginViewController: UIViewController {
    
    //MARK: - IBOutlets
    //labels
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var repeatPasswordLabelOutlet: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    
    
    //textfields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    //buttons
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var resendEmailButtonOutlet: UIButton!
    
    //views
    @IBOutlet weak var repeatPasswordLineView: UIView!
    
    //MARK: Vars
    
    var isLogin = true
    
    //MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUIFor(login: true)
        
        setupTextFieldDelegates()
        
        setupBackgroundTap()
    }

    //MARK: - IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if isDataInputtedFor(type: isLogin ? "login" : "registration") {
            
            isLogin ? loginUser() : registerUser()
            
        }
        else{
            ProgressHUD.showFailed("All fields are required!")
        }
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        if isDataInputtedFor(type: "password") {
            //reset password
            resetPassword()
        }
        else{
            ProgressHUD.showFailed("Email is required!")
        }
    }
    
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
        if isDataInputtedFor(type: "password") {
            //resend verification email
            resendVerificationEmail()
        }
        else{
            ProgressHUD.showFailed("Email is required!")
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        updateUIFor(login: sender.titleLabel?.text == "Login")
        isLogin.toggle()
    }
    
    //MARK: Setup
    
    private func setupTextFieldDelegates() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        updatePlaceholderLabels(textField: textField)
        
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
    }
    
    //MARK: Animations
    
    private func updateUIFor(login : Bool) {
        loginButtonOutlet.setImage(UIImage(named: login ? "loginBtn" : "registerBtn"), for: .normal)
        
        signUpButtonOutlet.setTitle(login ? "Sign Up" : "Login", for: .normal)
        
        signUpLabel.text = login ? "Don't have an account?" : "Already have an account?"
        
        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordTextField.isHidden = login
            self.repeatPasswordLabelOutlet.isHidden = login
            self.repeatPasswordLineView.isHidden = login
            
        }
    }
    
    private func updatePlaceholderLabels(textField: UITextField){
        
        switch textField {
        case emailTextField:
            emailLabelOutlet.text = emailTextField.hasText ? "Email" : ""
            
        case passwordTextField:
            passwordLabelOutlet.text = passwordTextField.hasText ? "Password" : ""
            
        default:
            repeatPasswordLabelOutlet.text = repeatPasswordTextField.hasText ? "Repeat Password" : ""
        }
        
        
    }
    
    //MARK: Helpers
    
    private func isDataInputtedFor(type : String) -> Bool{
        
        switch type{
        case "login":
            return emailTextField.text != "" && passwordTextField.text != ""
            
        case "registration":
            return emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != ""
            
        default:
            return emailTextField.text != ""
        }
    }
    
    private func loginUser() {
        FirebaseUserListener.shared.loginUserWithEmail(email: emailTextField.text!, password: passwordTextField.text!) { error, isEmailVerified in
            
            if error == nil {
                
                self.goToApp()
                
            } else {
                ProgressHUD.showFailed("Please verify email.")
                self.resendEmailButtonOutlet.isHidden = false
            }
        }
    }
    
    private func registerUser() {
        if passwordTextField.text! == repeatPasswordTextField.text! {
            FirebaseUserListener.shared.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
                if error == nil {
                    ProgressHUD.showSuccess("Verification mail has been sent")
                    self.resendEmailButtonOutlet.isHidden = false
                } else {
                    ProgressHUD.showFailed(error!.localizedDescription)
                }
            }
        } else {
            ProgressHUD.showFailed("The Passwords do not match")
        }
    }
    
    private func resetPassword() {
        FirebaseUserListener.shared.resetPasswordFor(email: emailTextField.text!) { (error) in
            if error == nil {
                ProgressHUD.showSuccess("Reset link sent to email.")
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    
    private func resendVerificationEmail() {
        FirebaseUserListener.shared.resendVerification(email: emailTextField.text!) { (error) in
            if error == nil {
                ProgressHUD.showSuccess("New verification email sent.")
            } else {
                ProgressHUD.showFailed(error!.localizedDescription)
            }
        }
    }
    
    //MARK:Navigation
    
    private func goToApp() {
        
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainApp") as! UITabBarController
        
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
        
    }
}

