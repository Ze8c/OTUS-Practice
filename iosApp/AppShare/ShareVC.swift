//
//  ShareVC.swift
//  OTUS-Share
//
//  Created by Mak on 14.05.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

@objc(ShareVC)
final class ShareVC: SLComposeServiceViewController {
    
    private let cacheProvider: SharingServiceAbstract = SharingService()
    private var selectedTxt: String = ""
    
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getText()
    }
    
    private func setupUI() {
        let imageView = UIImageView(image: UIImage(named: "vurb-icon-rounded"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.navigationBar.topItem?.titleView = imageView
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .systemRed
    }
    
    private func getText() {
        let propertyList = String(kUTTypePlainText)
        
        if let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
            let itemProvider = extensionItem.attachments?.first {
            
            itemProvider.loadItem(forTypeIdentifier: propertyList, options: nil, completionHandler: { (item, error) -> Void in
                guard let txt = item as? NSString else { return }
                self.selectedTxt = txt as String
            })
        } else {
            print("LOG > Share type information is wrong")
        }
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        openApp()
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        return nil
    }
    
    func openApp() {
        cacheProvider.setShare(selectedTxt)
        
        guard let url = URL(string: "OtusPractice://share?text") else { return }
        
        let selectorOpenURL = sel_registerName("openURL:")
        var responder: UIResponder? = self
        
        while responder != nil {
            if responder?.responds(to: selectorOpenURL) == true {
                responder?.perform(selectorOpenURL, with: url)
            }
            responder = responder?.next
        }
    }
}
