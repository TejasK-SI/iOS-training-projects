//
//  EditProfileTableViewController.swift
//  Messenger
//
//  Created by Tejas Kashid on 07/10/23.
//

import UIKit
import YPImagePicker
import ProgressHUD

class EditProfileTableViewController: UITableViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    //MARK: Vars
    var picker: YPImagePicker?
    
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        configureTextField()
        
        setupPicker()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showUserInfo()
        
    }
    
    //MARK: Table Delegates
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "tableViewBackgroundColor")
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 30.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO: show status view
        if indexPath.section == 1 && indexPath.row == 0 {
            performSegue(withIdentifier: "editProfileToStatusSeg", sender: self)
        }
    }
    
    //MARK: IBActions
    
    @IBAction func showPickerButtonClicked(_ sender: Any) {
        showPicker()
    }
    
    //MARK: Setup Image Picker
    
    func setupPicker() {
            var config = YPImagePickerConfiguration()
            config.showsPhotoFilters = false
            config.screens = [.library]
            
            config.library.maxNumberOfItems = 1
        
     
            picker = YPImagePicker(configuration: config)
        }
        
        func showPicker() {
            
            guard let picker = picker else { return }
            
            picker.didFinishPicking { [unowned picker] items, cancelled in

                for item in items {
                    switch item {
                    case .photo(let photo):
                        //this is just an example to show in imageView
                        DispatchQueue.main.async {
                            self.uploadAvatarImage(photo.image)
                            self.avatarImageView.image = photo.image.circleMasked
                            ProgressHUD.showSuccess("Successfully changed the profile picture.")
                        }
                    case .video(let video):
                        //if you need to access videos as well
                        print(video)
                    }
                }
                picker.dismiss(animated: true, completion: nil)
            }
            
            present(picker, animated: true, completion: nil)
        }
    
    
    
    //MARK: UpdateUI
    
    private func showUserInfo() {
        if let user = User.currentUser {
            usernameTextField.text = user.username
            statusLabel.text = user.status
            
            if user.avatarLink != "" {
                //set avatar
                FileStorage.downloadImage(imageUrl: user.avatarLink) { (avatarImage) in
                    self.avatarImageView.image = avatarImage?.circleMasked
                }
            }
        }
    }
    
    
    //MARK: Configure
    
    private func configureTextField() {
        usernameTextField.delegate = self
        usernameTextField.clearButtonMode = .whileEditing
    }
    
    //MARK: Upload Avatar Images
    
    private func uploadAvatarImage(_ image : UIImage) {
        let fileDirectory = "Avatars/" + "_\(User.currentId)" + ".jpg"
        
        FileStorage.uploadImage(image, directory: fileDirectory) { (avatarLink) in
            if var user = User.currentUser {
                user.avatarLink = avatarLink ?? ""
                saveUserLocally(user)
                FirebaseUserListener.shared.saveUserToFirestore(user)
            }
            
            //TODO: Save image locally
            FileStorage.saveFileLocally(fileData: image.jpegData(compressionQuality: 1.0)! as NSData, fileName: User.currentId)
            
        }
    }
}




extension EditProfileTableViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            if textField.text != "" {
                if var user = User.currentUser {
                    user.username = textField.text!
                    saveUserLocally(user)
                    FirebaseUserListener.shared.saveUserToFirestore(user)
                }
            }
            
            textField.resignFirstResponder() //disappears the keyboard
            return false
        }
        return true
    }
}
