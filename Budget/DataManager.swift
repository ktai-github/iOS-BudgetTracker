// Copyright (c) 2017 Lighthouse Labs. All rights reserved.
// 
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical or
// instructional purposes related to programming, coding, application development,
// or information technology.  Permission for such use, copying, modification,
// merger, publication, distribution, sublicensing, creation of derivative works,
// or sale is expressly withheld.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import SQLite3

class DataManager: NSObject {

  let dailyBudget = NSDecimalNumber(string: "10.00")
  var spent = NSDecimalNumber(string: "0.00")
  
  var database: OpaquePointer?
  
  func openDatabase() {
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask,
                                               appropriateFor: nil, create: false)
      .appendingPathComponent("test-database.db")
    let status = sqlite3_open(fileURL.path, &database)
    if status != SQLITE_OK {
      print("error opening")
    }
  }
  
  func budgetRemainingToday() -> NSDecimalNumber {
    let startOfDay = NSCalendar.current.startOfDay(for: Date())
    
    var components = DateComponents()
    components.day = 1
    components.second = -1
    
    return dailyBudget.subtracting(spent)
  }
  
  func spend(amount: NSDecimalNumber, time: Date) {
    let timeString = String(Int(Date().timeIntervalSince1970))
    let amountString = String(describing: amount.multiplying(by: 100.00))
    let query = """
      INSERT INTO transactions (amount, timestamp)
      VALUES(
      """
      + amountString + """
      ,
      """
      + timeString + """
      );
      """
//    let database = SQLiteDatabase()
    let status = sqlite3_exec(database, query, nil, nil, nil)
    if status != SQLITE_OK {
      let errmsg = String(cString: sqlite3_errmsg(database)!)
      print("error \(errmsg)")
    }
    spent = spent.adding(amount)
  }
  
  func initialSetup() {
    let query = """
      CREATE TABLE "transactions" (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount INTEGER,
          timestamp INTEGER
      );
      CREATE TABLE "daily_budgets" (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount INTEGER
      );
      """
//    let database = SQLiteDatabase()
    let status = sqlite3_exec(database, query, nil, nil, nil)
    if status != SQLITE_OK {
      let errmsg = String(cString: sqlite3_errmsg(database)!)
      print("error \(errmsg)")
    }

//    let createPeople = """
//      CREATE TABLE famous_people (
//      id INTEGER PRIMARY KEY,
//      first_name VARCHAR(50),
//      last_name VARCHAR(50),
//      birthdate DATE
//      );
//      INSERT INTO famous_people (first_name, last_name, birthdate)
//      VALUES ('Abraham', 'Lincoln', '1809-02-12'
//      );
//      INSERT INTO famous_people (first_name, last_name, birthdate)
//      VALUES ('Mahatma', 'Gandhi', '1869-10-02'
//      );
//      """
//
//    let status = sqlite3_exec(database, createPeople, nil, nil, nil)
//    if status != SQLITE_OK {
//      let errmsg = String(cString: sqlite3_errmsg(database)!)
//      print("error \(errmsg)")
//    }

  }
  
  func closeDatabase() {
    let status = sqlite3_close(database)
    if status != SQLITE_OK {
      print("error closing")
    }
  }

  
  deinit {
    closeDatabase()
  }
}
