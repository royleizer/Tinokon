//
//  WebViewer.m
//  shemtov
//
//  Created by Roy Leizer on 19/06/2022.
//  Copyright © 2022 Roy Leizer. All rights reserved.
//

#import <Foundation/Foundation.h>


class ViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }}
