//
//  DetailViewController.swift
//  Day_33 Project7
//
//  Created by Felix Leitenberger on 21.05.20.
//  Copyright © 2020 Felix Leitenberger. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        <b>\(detailItem.title)</b>
        <br>
        <br>
        \(detailItem.body)
        </body>
        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }
}
