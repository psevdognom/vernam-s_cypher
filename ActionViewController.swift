

import UIKit

var textArray = [String]()

let abc: [Character] = ["а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"]


func getLiteraNumber(litera: Character) -> Int {
    var re: Int
    re = 0
    for index in 0..<abc.count {
        //  print(abc[index])
        if litera == abc[index] {
            re = index
        }
    }
    return re
}






func codeLitera(cypherLitera: Character, originalLitera: Character) -> Character {
    let newIndex = (getLiteraNumber(litera: cypherLitera) + getLiteraNumber(litera: originalLitera)) % 32
    return abc[newIndex]
}

func decodeLitera(cypherLitera: Character, originalLitera: Character) -> Character {
    var newIndex: Int
    newIndex = abs(getLiteraNumber(litera: originalLitera) - getLiteraNumber(litera: cypherLitera))
    return abc[newIndex]
}

func codeString(originalString: String, cypherString: String) -> String {
    var newString = ""
    for index in originalString.indices {
        newString.insert(codeLitera(cypherLitera: cypherString[index], originalLitera: originalString[index]), at: newString.endIndex)
    }
    return newString
}

func decodeString(originalString: String, cypherString: String) -> String {
    var newString = ""
    for index in originalString.indices {
        newString.insert(decodeLitera(cypherLitera: originalString[index], originalLitera: cypherString[index]), at: newString.endIndex)
    }
    return newString 
}

func getCypherKey(stringNumber: Int) -> String {
    if let path = Bundle.main.path(forResource: "cypher", ofType: "txt") {
        if let data = try? String(contentsOfFile: path){
            textArray = data.components(separatedBy: "\n")
        }
    }
        return textArray[stringNumber]
}

class ActionViewController: UIViewController {

    @IBOutlet weak var textArea: UITextView!
    @IBAction func codeButton(_ sender: UIButton) {
        let num = Int(String(self.textArea.text[self.textArea.text.startIndex]))
        self.textArea.text.remove(at: self.textArea.text.startIndex)
        String(num!)
        self.textArea.text = "\(num!)" + codeString(originalString: self.textArea.text, cypherString: getCypherKey(stringNumber: num!))
        
        
        
            
        
    }
    @IBAction func decodeButton(_ sender: UIButton) {
        let num = Int(String(self.textArea.text[self.textArea.text.startIndex]))
        self.textArea.text.remove(at: self.textArea.text.startIndex)
        String(num!)
        self.textArea.text = "\(num!)" + decodeString(originalString: self.textArea.text, cypherString: getCypherKey(stringNumber: num!))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

