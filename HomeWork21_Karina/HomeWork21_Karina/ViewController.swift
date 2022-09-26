//
//  ViewController.swift
//  HomeWork21_Karina
//
//  Created by Karina Kovaleva on 25.09.22.
//

import UIKit

class ViewController: UIViewController {
    let arrayOfImageNames = ["myData", "myDocument", "myFile", "myImage", "myPhoto"]

    override func viewDidLoad() {
        super.viewDidLoad()
        for name in arrayOfImageNames {
            guard var cacheDirectoryURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }
            cacheDirectoryURL.append(component: name)
            let image = UIImage(named: name)
            let data = image?.pngData()
            do {
                try data?.write(to: cacheDirectoryURL)
            } catch {
                print("error")
            }
        }
    }
    @IBAction func moveToDocumentFolder(_ sender: Any) {
        guard let cacheDirectoryURL = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }
        guard let arrayOfImagesUrls = try? FileManager.default.contentsOfDirectory(at: cacheDirectoryURL, includingPropertiesForKeys: nil) else { return }
        var sortedArrayOfImagesUrls = arrayOfImagesUrls.sorted { $0.description < $1.description }
        sortedArrayOfImagesUrls.removeFirst()
        var dictionary = zip(arrayOfImageNames, sortedArrayOfImagesUrls)
        for (name, url) in dictionary {
            guard var documentDirectoryURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }
            documentDirectoryURL.append(component: name)
            do {
                try FileManager.default.moveItem(at: url, to: documentDirectoryURL)
            } catch {
                print("error")
            }
        }
    }
}
