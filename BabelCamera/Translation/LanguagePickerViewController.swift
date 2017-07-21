//
//  LanguagePickerViewController.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-21.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import UIKit

protocol LanguagePickerDelegate: class {
    func picked(language: Language)
}

class LanguagePickerViewController: UIViewController {

    private static let storyboard = "LanguagePickerViewController"
    private let languages = Language.all()
    private var selectedLanguage = Language.french
    weak var delegate: LanguagePickerDelegate?

    @IBOutlet weak var languagePickerView: UIPickerView!

    static func createInstance(selectedLanguage: Language) -> LanguagePickerViewController? {
        let storyboard = UIStoryboard(
            name: LanguagePickerViewController.storyboard,
            bundle: Bundle(for: LanguagePickerViewController.self))
        guard let viewController = storyboard.instantiateInitialViewController() as? LanguagePickerViewController else {
            print("Could not instantiate LanguagePickerViewController")
            return nil
        }
        viewController.selectedLanguage = selectedLanguage
        viewController.modalPresentationStyle = .popover
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        languagePickerView.delegate = self
        languagePickerView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // If this is done in viewDidLoad the language will not be selected
        if let selectedIndex = languages.index(of: selectedLanguage) {
            languagePickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
    }
}

// MARK: - UIPickerViewDelegate

extension LanguagePickerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].description()
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = languages[row]
        print("Picked language: \(selectedLanguage.description())")
        delegate?.picked(language: selectedLanguage)
    }

}

// MARK: - UIPickerViewDataSource

extension LanguagePickerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }

}
