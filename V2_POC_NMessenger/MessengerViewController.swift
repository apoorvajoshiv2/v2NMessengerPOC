//
//  MessengerViewController.swift
//  V2_POC_NMessenger
//
//  Created by apoorva on 13/10/17.
//  Copyright © 2017 apoorva. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import NMessenger

class MessengerViewController: NMessengerViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var inputTextBarView = InputTextBarView()
    var messengerBarView = NMessengerBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        loadMessengerView()
        //        loadInputView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // SEND TEXT
    
    override func sendText(_ text: String, isIncomingMessage: Bool) -> GeneralMessengerCell {
        
        if segmentControl.selectedSegmentIndex == 0 {
            return self.postText(text,isIncomingMessage: true)
        } else {
            return self.postText(text,isIncomingMessage: false)
        }
        
    }
    
    func postText(_ text: String, isIncomingMessage:Bool) -> GeneralMessengerCell {
        let newMessage = createTextMessage(text, isIncomingMessage: isIncomingMessage)
        
        self.addMessageToMessenger(newMessage)
        return newMessage
    }
    
    override func createTextMessage(_ text: String, isIncomingMessage:Bool) -> GeneralMessengerCell {
        let textContent = TextContentNode(textMessageString: text, currentViewController: self, bubbleConfiguration: self.sharedBubbleConfiguration)
        let newMessage = MessageNode(content: textContent)
        newMessage.cellPadding = messagePadding
        newMessage.currentViewController = self
        newMessage.isIncomingMessage = isIncomingMessage
        if isIncomingMessage {
            newMessage.avatarNode = self.createAvatar()
        }
        print("new message",newMessage)
        return newMessage
    }
    
    private func createAvatar()->ASImageNode {
        let avatar = ASImageNode()
        avatar.backgroundColor = UIColor.lightGray
        avatar.preferredFrameSize = CGSize(width: 20, height: 20)
        avatar.layer.cornerRadius = 10
        return avatar
    }
    
    fileprivate func loadMessengerView() {
        self.messengerView = NMessenger(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 63))
        messengerView.delegate = self
        self.view.addSubview(self.messengerView)
    }
    
    func loadInputView() {
        self.inputBarView = self.getInputBar()
        self.view.addSubview(inputTextBarView)
    }
    
    override func getInputBar() -> NMessengerBarView {
        let result = NMessengerBarView()
        result.numberOfRows = 0
        return NMessengerBarView(controller: self)
    }
    
    override func sendImage(_ image: UIImage, isIncomingMessage:Bool) -> GeneralMessengerCell {
        return self.postImage(image,isIncomingMessage: isIncomingMessage)
    }
    
    func postImage(_ image: UIImage, isIncomingMessage:Bool) -> GeneralMessengerCell {
        print("isIncoming",isIncomingMessage)
        let newMessage = self.createImageMessage(image, isIncomingMessage: isIncomingMessage)
        self.addMessageToMessenger(newMessage)
        return newMessage
    }
    
}

