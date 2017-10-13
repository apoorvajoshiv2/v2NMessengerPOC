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

    var inputTextBarView = InputTextBarView()
    
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
        return self.postText(text,isIncomingMessage: isIncomingMessage)
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
        print("new message",newMessage)
        return newMessage
    }
    
    fileprivate func loadMessengerView() {
        self.messengerView = NMessenger(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 63))
        messengerView.delegate = self
        messengerView.backgroundColor = UIColor.black
        self.view.addSubview(self.messengerView)
    }

    func loadInputView() {
        self.inputBarView = self.getInputBar()
        self.view.addSubview(inputTextBarView)
    }
    
    override func getInputBar() -> InputBarView {
        return NMessengerBarView(controller: self)
    }
    
}
