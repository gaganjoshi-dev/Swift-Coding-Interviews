/*
 Live Assignment 1
 The following string represents the contents of a CSV file.
 In the data below, the first record lists the names of the value or property.
 There is no built-in functionality in Foundation or the Swift Standard library to process this data. You will need to write string-processing code to read in the data.


 Task:
 1. Read the contents of the CSV file into a data structure that you create to hold each record.
 Counter Task:
 1. Find why some data is not being parsed.
 2. Introduce error handling in solution.
 3. Change method signature to accommodate model + error - Result
 4. What are other ways we can create result structure, post answering I was asked to implement the same.
 5. Sort based on model properties
 6. Filtering models
 7. Show only errors, show only names.

 */
let csvFile = """
Name, Age, Address, Phone Number, Email, Favorite Number, Employed
Boone Malimoe, 19,7259 Anhalt Court, 776-410-0007,bmalimoe0@canalblog.com,142,false
Burgess Greasley, 33,04 Ridge Oak Street, 649-893-5297,ogreasley1@4shared.com,337,true
Derwin Brunel, 13,0843 Bunting Hill, 790-611-6437,dbrune 2@discovery.com,961,true
Sheffie Spadotto, 55,5298 Grover Court, 265-791-1163,5spadotto3@salon.com,479,true
Courtney Fearnyhough, 63,2102 Garrison Circle, 502-971-1269, cfearnyhough4@wikipedia.org,876,true
Melloney Stickens, 19,97934 Crownhardt Plaza, 145-301-1842,mstickens5@facebook.com,852,false
Ellery Geere, 53,7 Kedzie Center, 515-764-9730,egeere6@adobe.com,516,false
Nikki Goodere, 61,6 Canary Parkway, 827-542-0107,ngoodere7@chicagotribune.com,0,true
Annabela Riddel,34,9132 Westridge Way, 605-920-8468,ariddel8@w3.org,672b,false
"""
struct Person {
    let name: String
    let age: Int
    let address: String
    let phone: String
    let email: String
    let favNumber: Int
    let employed: Bool
}

func convertCSVToModel(_ csv: String) -> [Person] {

    var rows = csv.components(separatedBy: "\n")
    rows.removeFirst()

    var result = [Person]()

    for row in rows {
        let coulmns = row.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }

        if coulmns.count < 7 {
            continue
        }
        let name = coulmns[0]
        let age = Int(coulmns[1]) ?? 0
        let address = coulmns[2]
        let phone = coulmns[3]
        let email = coulmns[4]
        let favNumber = Int(coulmns[5]) ?? 0
        let employed: Bool = coulmns[5] == "true" ? true : false

        let person = Person(name: name, age: age, address: address, phone: phone, email: email, favNumber: favNumber, employed: employed)

        result.append(person)
    }



    print(result.count)

    return result

}

print(convertCSVToModel(csvFile))
