import UIKit

func createButton(title:String) -> UIButton {
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.setTitleColor(UIColor(hexString: "#ae0000"), for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    //    button.layer.borderWidth = 0.5
    //    button.layer.borderColor = UIColor(hexString: "#ae0000").cgColor
    return button
}

func printFonts() {
    let fontFamilyNames = UIFont.familyNames
    for familyName in fontFamilyNames {
        print("------------------------------")
        print("Font Family Name = [\(familyName)]")
        let names = UIFont.fontNames(forFamilyName: familyName)
        print("Font Names = [\(names)]")
    }
}
