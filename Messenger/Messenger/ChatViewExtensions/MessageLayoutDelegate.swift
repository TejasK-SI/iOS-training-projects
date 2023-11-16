//
//  MessageLayoutDelegate.swift
//  Messenger
//
//  Created by Tejas Kashid on 13/10/23.
//

import Foundation
import MessageKit

extension ChatViewController: MessagesLayoutDelegate {
    
    //MARK: Cell Top Label
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if indexPath.section % 3 == 0 {
            //TODO: set different size for pull to reload
            
            if ((indexPath.section == 0) && (allLocalMessages.count > displayingMessagesCount)) {
                return 40
            }
            
            return 18
        }
        
        return 0
    }
    
    //MARK: Cell Bottom Label
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return isFromCurrentSender(message: message) ? 17 : 0
    }

    //MARK: Message Bottom Label
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return indexPath.section != mkMessages.count - 1 ? 10 : 0
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        avatarView.set(avatar: Avatar(initials: mkMessages[indexPath.section].senderInitials))
    }
    
}


extension ChannelChatViewController: MessagesLayoutDelegate {
    
    //MARK: Cell top label
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        if indexPath.section % 3 == 0 {

            if ((indexPath.section == 0) && (allLocalMessages.count > displayingMessagesCount)) {
                
                return 40
            }
            return 18
        }
        
        return 0
    }
    
    //MARK: Message Bottom Label
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 10
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        avatarView.set(avatar: Avatar(initials: mkMessages[indexPath.section].senderInitials))
    }

}
